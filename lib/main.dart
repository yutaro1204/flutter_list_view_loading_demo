import 'package:flutter/material.dart';
import 'package:flutter_application_1/ascending_infinite_loading.dart';
import 'package:flutter_application_1/default_infinite_loading.dart';
import 'package:flutter_application_1/descending_infinite_loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DefaultInfiniteLoading(),
      // home: const AscendingInfiniteLoading(),
      // home: const DescendingInfiniteLoading(),
    );
  }
}
