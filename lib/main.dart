import 'dart:isolate';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:js';

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
        home: Text('hi')
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
