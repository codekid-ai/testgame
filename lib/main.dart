import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:js';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'interop.dart';

void saySomething(String arg) {
  print('Dart function called with argument: $arg');
}

void main() async {
  // allowInterops(context);
  context['myDartFunction'] = allowInterop(saySomething);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance
      .collection('project/testgame/code')
      .snapshots()
      .listen((codes) => codes.docs.forEach((e) {
            // print(e.data());
            registerEvent(e.data()['handler'],
                "try { \n ${e.data()['code']} \n } catch (e) { \n logError('${e.data()['handler']}', e); \n }");
          }));

  Interop.initLog(
      FirebaseFirestore.instance.collection('project/testgame/output'));

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
