import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/entities/provider/service_provider_provider.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/providers_sliver_list.dart';
import 'package:littlehelpbook_flutter/features/search/providers_search_bar.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LhbStyleConstants.maxPageContentWidth,
          ),
          child: ref.watch(providersStreamProvider).maybeWhen(
                data: ProvidersDataView.new,
                orElse: () => Center(child: CircularProgressIndicator()),
              ),
        ),
      ),
    );
  }
}

class ProvidersDataView extends StatefulWidget {
  @visibleForTesting
  const ProvidersDataView(this.data, {super.key});

  final List<ServiceProvider> data;

  @override
  State<StatefulWidget> createState() => _ProvidersDataViewState();
}

class _ProvidersDataViewState extends State<ProvidersDataView> {
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
        const SizedBox(height: 16.0),
        ProviderSearchBar(searchNotifier: _searchNotifier),
        const SizedBox(height: 16.0),
        Expanded(
          child: CustomScrollView(
            slivers: [
              widget.data.isNotEmpty
                  ? ValueListenableBuilder(
                      valueListenable: _searchNotifier,
                      builder: (context, value, child) => ProvidersSliverList(
                        providers: widget.data,
                        searchTerm: value,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: SizedBox(
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
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
