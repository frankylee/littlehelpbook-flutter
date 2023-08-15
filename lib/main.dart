import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/common/router/lhb_router.dart';

import 'package:littlehelpbook_flutter/theme/lhb_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();

  final app = await buildAppWithRiverpod(const MyApp());
  runApp(app);
}

/// Initialize the app with a [ProviderScope] and provider overrides.
Future<ProviderScope> buildAppWithRiverpod(Widget app) async {
  final providerScope = ProviderScope(
    child: app,
  );

  return providerScope;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Little Help Book',
      theme: LittleHelpBookTheme.lightTheme,
      darkTheme: LittleHelpBookTheme.darkTheme,
      routerConfig: lhbRouter,
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
