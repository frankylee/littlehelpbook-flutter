import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class ProviderSearchBar extends StatefulWidget {
  const ProviderSearchBar({
    super.key,
    required this.searchNotifier,
  });

  final ValueNotifier<String> searchNotifier;

  @override
  State<StatefulWidget> createState() => _ProviderSearchBarState();
}

class _ProviderSearchBarState extends State<ProviderSearchBar> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: SearchBar(
        controller: _textController,
        elevation: WidgetStatePropertyAll(0.0),
        hintText: context.l10n.searchProviders,
        hintStyle: WidgetStatePropertyAll(
          TextStyle(color: context.colorTheme.onSurface.withValues(alpha: 200)),
        ),
        onChanged: (value) => widget.searchNotifier.value = value,
        side: WidgetStatePropertyAll(
          BorderSide(color: context.colorTheme.secondary),
        ),
        trailing: [
          Icon(
            Icons.search_rounded,
            color: context.colorTheme.onSurface.withValues(alpha: 200),
          ),
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: context.colorTheme.onSurface.withValues(alpha: 200),
            ),
            onPressed: () {
              setState(() {
                _textController.text = '';
                widget.searchNotifier.value = '';
              });
            },
          ),
        ],
      ),
    );
  }
}
