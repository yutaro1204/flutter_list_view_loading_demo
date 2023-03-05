import 'package:flutter_riverpod/flutter_riverpod.dart';

final countStateProvider =
    StateNotifierProvider<CountStateProvider, int>((ref) {
  return CountStateProvider();
});

class CountStateProvider extends StateNotifier<int> {
  CountStateProvider() : super(0);

  void increment() {
    state++;
  }
}
