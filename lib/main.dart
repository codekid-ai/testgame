import 'dart:async';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:js';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'interop.dart';

StreamController<String> _streamController = StreamController<String>();

void saySomething(String arg) {
  print('Dart function called with argument : $arg');
  _streamController.add('say $arg');
}

void main() async {
  // allowInterops(context);
  context['myDartFunction'] = allowInterop(saySomething);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Test Game 1',
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
        )));
  }
}
