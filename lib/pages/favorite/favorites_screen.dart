import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/providers_list.dart';
import 'package:littlehelpbook_flutter/features/favorite/favorite_provider.dart';
import 'package:littlehelpbook_flutter/features/search/providers_search_bar.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<ServiceProvider>>>(
      favoritesProvider,
      (_, state) => state.showSnackbarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.favorites),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: ref.watch(favoritesProvider).maybeWhen(
              data: FavoritesScreenDataView.new,
              orElse: () => Center(child: CircularProgressIndicator()),
            ),
      ),
    );
  }
}

class FavoritesScreenDataView extends StatefulWidget {
  @visibleForTesting
  const FavoritesScreenDataView(this.data, {super.key});

  final List<ServiceProvider> data;

  @override
  State<StatefulWidget> createState() => _FavoritesScreenDataViewState();
}

class _FavoritesScreenDataViewState extends State<FavoritesScreenDataView> {
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
        if (widget.data.isNotEmpty && widget.data.length > 4)
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
                      context.l10n.noFavoritesYet,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
