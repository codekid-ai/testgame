import 'dart:async';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:js';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'interop.dart';

// import 'package:flutter/services.dart';

// const platform = MethodChannel('com.example.myapp/mychannel');

// void _handleMethodCall(MethodCall call) {
//   if (call.method == 'mychannel') {
//     context.read(myProvider).state = "Updated Value";
//   }
// }

// final container = ProviderContainer();

void saySomething(String arg) {
  print('Dart function called with argument : $arg');
  // container.read(myProvider.notifier).state = arg;
  // container.refresh(myProvider);
  _streamController.add('say $arg');
}

void main() async {
  // allowInterops(context);
  context['myDartFunction'] = allowInterop(saySomething);

  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // FirebaseFirestore.instance
  //     .collection('project/testgame/code')
  //     .snapshots()
  //     .listen((codes) => codes.docs.forEach((e) {
  //           // print(e.data());
  //           registerEvent(e.data()['handler'],
  //               "try { \n ${e.data()['code']} \n } catch (e) { \n logError('${e.data()['handler']}', e); \n }");
  //         }));

  // Interop.initLog(
  //     FirebaseFirestore.instance.collection('project/testgame/output'));

  runApp(ProviderScope(child: MainApp()));
}

//final something = StateProvider((ref) => 'hello');

// final myProvider = Provider((_) => "Hello, World!");
//final myProvider = StateProvider((_) => "Hello, World!");

StreamController<String> _streamController = StreamController<String>();
Stream<String> get stream => _streamController.stream;

void sendFunctionCall(String functionCall) {
  _streamController.add(functionCall);
}

class MainApp extends ConsumerWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final value = ref.watch(myProvider);

    //container.dispose();
    //bool isDarkTheme = ref.watch(themeStateNotifierProvider);
    return MaterialApp(
        title: 'Test Game 1',
        // themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        home: Scaffold(
            body: StreamBuilder<String>(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              // Do something with the function call data
              return Text(snapshot.data!);
            } else {
              return Text('Waiting for function calls...');
            }
          },
        )
            //Text('say')
            // Text('say  : ${value}')
            ));
  }
}
