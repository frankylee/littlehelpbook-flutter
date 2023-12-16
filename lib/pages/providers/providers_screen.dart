import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/provider/service_provider_provider.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/providers_list.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';

class ProvidersScreen extends ConsumerWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<ServiceProvider>>>(
      providersStreamProvider,
      (_, state) => state.showSnackbarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.providers),
      ),
      body: ref.watch(providersStreamProvider).maybeWhen(
            data: ProvidersDataView.new,
            orElse: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

class ProvidersDataView extends StatelessWidget {
  @visibleForTesting
  const ProvidersDataView(this.data, {super.key});

  final List<ServiceProvider> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24.0),
          data.isNotEmpty
              ? ProvidersList(
                  physics: NeverScrollableScrollPhysics(),
                  providers: data,
                  shrinkWrap: true,
                )
              : SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0),
                      child: Text(
                        context.l10n
                            .entityCouldNotBeFound(context.l10n.providers),
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
