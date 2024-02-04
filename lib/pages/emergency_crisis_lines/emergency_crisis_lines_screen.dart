import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/entities/provider/service_provider_provider.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/providers_list.dart';
import 'package:littlehelpbook_flutter/features/search/providers_search_bar.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/widgets/bordered_container.dart';

class EmergencyCrisisLinesScreen extends ConsumerWidget {
  const EmergencyCrisisLinesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<ServiceProvider>>>(
      emergencyCrisisLinesProvider,
      (_, state) => state.showSnackbarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.emergencyCrisisLines),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LhbStyleConstants.maxPageContentWidth,
            ),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text(
                    context.l10n.areYouInCrisis,
                    style: context.textTheme.headlineMedium?.primary(context),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: BorderedContainer(
                        child: Text(
                          context.l10n.aCrisisIsDefinedBy,
                          softWrap: true,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                ref.watch(emergencyCrisisLinesProvider).maybeWhen(
                      data: EmergencyCrisisLinesScreenDataView.new,
                      orElse: () => Center(child: CircularProgressIndicator()),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmergencyCrisisLinesScreenDataView extends StatefulWidget {
  @visibleForTesting
  const EmergencyCrisisLinesScreenDataView(this.data, {super.key});

  final List<ServiceProvider> data;

  @override
  State<StatefulWidget> createState() =>
      _EmergencyCrisisLinesScreenDataViewState();
}

class _EmergencyCrisisLinesScreenDataViewState
    extends State<EmergencyCrisisLinesScreenDataView> {
  final _searchNotifier = ValueNotifier('');

  @override
  void dispose() {
    _searchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProviderSearchBar(searchNotifier: _searchNotifier),
        const SizedBox(height: 16.0),
        widget.data.isNotEmpty
            ? ValueListenableBuilder(
                valueListenable: _searchNotifier,
                builder: (context, value, child) => ProvidersList(
                  physics: NeverScrollableScrollPhysics(),
                  providers: widget.data,
                  searchTerm: value,
                  shrinkWrap: true,
                ),
              )
            : SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Text(
                      context.l10n.entityCouldNotBeFound(
                        context.l10n.providers,
                      ),
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
