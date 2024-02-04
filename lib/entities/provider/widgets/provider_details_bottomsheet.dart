import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/entities/provider/location_provider.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/locations_list.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/widgets/button/secondary_button.dart';
import 'package:littlehelpbook_flutter/widgets/gradient_container.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ProviderDetailsBottomSheet extends ConsumerStatefulWidget {
  const ProviderDetailsBottomSheet({
    super.key,
    required this.provider,
  });

  final ServiceProvider provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProviderDetailsBottomSheetState();

  static Future<void> show(
    BuildContext context,
    ServiceProvider provider,
  ) async {
    await WoltModalSheet.show<void>(
      context: context,
      maxDialogWidth: 1200,
      minDialogWidth: 88.sh,
      minPageHeight: 0.0,
      maxPageHeight: 0.9,
      modalTypeBuilder: (context) {
        final deviceType = getDeviceType(MediaQuery.of(context).size);
        if (deviceType == DeviceScreenType.tablet &&
            MediaQuery.of(context).orientation == Orientation.landscape) {
          return WoltModalType.dialog;
        } else {
          return WoltModalType.bottomSheet;
        }
      },
      onModalDismissedWithBarrierTap: Navigator.of(context).pop,
      useSafeArea: MediaQuery.of(context).orientation == Orientation.landscape,
      pageListBuilder: (context) {
        return [
          WoltModalSheetPage(
            hasTopBarLayer: false,
            isTopBarLayerAlwaysVisible: false,
            trailingNavBarWidget: IconButton(
              padding: const EdgeInsets.all(LhbStyleConstants.pagePadding),
              icon: const Icon(Icons.close),
              onPressed: Navigator.of(context).pop,
            ),
            child: ProviderDetailsBottomSheet(provider: provider),
          ),
        ];
      },
    );
  }
}

class _ProviderDetailsBottomSheetState
    extends ConsumerState<ProviderDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Location>>>(
      locationByServiceProviderProvider(widget.provider.id),
      (_, state) => state.showSnackbarOnError(
        context,
        message: '${widget.provider.name} locations could not be retrieved',
      ),
    );
    final isSpanish = widget.provider.descriptionEs != null;
    return GradientContainer(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        padding: LhbStyleConstants.pagePaddingInsets,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.0),
                Center(
                  child: Text(
                    widget.provider.name,
                    style: context.textTheme.headlineLarge?.white,
                  ),
                ),
                const SizedBox(height: 32.0),
                Text(
                  widget.provider.descriptionEn,
                  style: context.textTheme.bodyLarge?.white,
                ),
                if (isSpanish) const SizedBox(height: 24.0),
                if (isSpanish)
                  Text(
                    widget.provider.descriptionEs!,
                    style: context.textTheme.bodyLarge?.white,
                  ),
              ],
            ),
            const SizedBox(height: 48.0),
            Column(
              children: [
                if (widget.provider.website != null)
                  SecondaryButton(
                    onPressed: () =>
                        launchUrl(Uri.parse(widget.provider.website!)),
                    child: Text(
                      context.l10n.visitWebsite,
                      style: context.textTheme.bodyLarge?.white,
                    ),
                  ),
                if (widget.provider.email != null)
                  SecondaryButton(
                    onPressed: () => launchUrl(
                      Uri.parse('mailto:${widget.provider.email!}'),
                    ),
                    child: Text(
                      context.l10n.sendEmail,
                      style: context.textTheme.bodyLarge?.white,
                    ),
                  ),
                if (widget.provider.phone != null)
                  SecondaryButton(
                    onPressed: () => launchUrl(
                      Uri.parse('tel:${widget.provider.phone!}'),
                    ),
                    child: Text(
                      context.l10n.callNow,
                      style: context.textTheme.bodyLarge?.white,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 48.0),
            ref
                .watch(locationByServiceProviderProvider(widget.provider.id))
                .when(
                  data: (data) => LocationsList(locations: data),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) {
                    // TODO: Capture exception in Sentry.
                    print('ERROR: $error $stackTrace');
                    return const SizedBox.shrink();
                  },
                ),
          ],
        ),
      ),
    );
  }
}
