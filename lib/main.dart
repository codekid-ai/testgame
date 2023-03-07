import 'dart:isolate';

import 'package:flutter/material.dart';
import 'dart:js';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //bool isDarkTheme = ref.watch(themeStateNotifierProvider);
    return MaterialApp(
        title: 'Code Kid',
        // themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        home: Scaffold(body: Text('hi'))
        //TheApp(),
        // SandboxLauncher(
        //   app: TheApp(),
        //   sandbox: Sandbox(),
        //   getInitialState: () async {
        //     return (await kDB.doc('sandbox/serge').get()).data();
        //   },
        //   saveState: (s) {
        //     kDB.doc('sandbox/serge').set({'sandbox': s});
        //   },
        // )
        );
  }
}
