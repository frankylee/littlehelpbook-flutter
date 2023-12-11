import 'dart:async';

import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/entities/powersync/powersync.dart';
import 'package:littlehelpbook_flutter/features/live_query/result_table.dart';
import 'package:powersync/sqlite3.dart' as sqlite;
import 'package:powersync/sqlite3.dart';

class QueryWidget extends StatefulWidget {
  const QueryWidget({super.key, required this.defaultQuery});
  final String defaultQuery;

  @override
  State<StatefulWidget> createState() {
    return QueryWidgetState();
  }
}

class QueryWidgetState extends State<QueryWidget> {
  QueryWidgetState();
  sqlite.ResultSet? _data;
  late TextEditingController _controller =
      TextEditingController(text: widget.defaultQuery);
  late String _query = _controller.text;
  String? _error;
  StreamSubscription<ResultSet>? _subscription;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _subscription?.cancel();
  }

  void _refresh() async {
    _subscription?.cancel();
    final stream = db.watch(_query);
    _subscription = stream.listen(
      (data) {
        if (!mounted) {
          return;
        }
        setState(() {
          _data = data;
          _error = null;
        });
      },
      onError: (dynamic e) {
        setState(() {
          if (e is sqlite.SqliteException) {
            _error = "${e.message}!";
          } else {
            _error = e.toString();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _controller,
            onEditingComplete: () {
              setState(() {
                _query = _controller.text;
                _refresh();
              });
            },
            decoration: InputDecoration(
              isDense: false,
              border: const OutlineInputBorder(),
              labelText: 'Query',
              errorText: _error,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ResultSetTable(data: _data),
            ),
          ),
        ),
      ],
    );
  }
}
