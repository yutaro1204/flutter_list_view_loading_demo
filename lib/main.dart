import 'package:flutter/material.dart';
import 'package:flutter_application_1/ascending_infinite_loading.dart';
import 'package:flutter_application_1/default_infinite_loading.dart';
import 'package:flutter_application_1/descending_infinite_loading.dart';
import 'package:flutter_application_1/provider/count_state_provider.dart';
import 'package:flutter_application_1/provider/pokemon_state_provier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

final helloWorldProvider = Provider((_) => 'Hello world');

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DefaultInfiniteLoading(),
        // home: const AscendingInfiniteLoading(),
        // home: const DescendingInfiniteLoading(),
      ),
    );
  }
}
