import 'dart:isolate';

import 'package:flutter/material.dart';
import 'dart:js';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void saySomething(String arg) {
  print('Dart function called with argument: $arg');
}

void main() async {
  // allowInterops(context);
  context['myDartFunction'] = allowInterop(saySomething);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MainApp()));
}

final something = StateProvider((ref) => 'hello');

class MainApp extends ConsumerWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //bool isDarkTheme = ref.watch(themeStateNotifierProvider);
    return MaterialApp(
        title: 'Test Game',
        // themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        home:
            Scaffold(body: Text('say: ${ref.watch(something.notifier).state}'))
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
