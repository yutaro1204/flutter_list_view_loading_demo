import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final pokemonStateProvider =
    StateNotifierProvider.autoDispose<PokemonStateProvider, PokemonState>(
        (ref) {
  return PokemonStateProvider(ref);
});

@immutable
class PokemonState {
  const PokemonState({
    this.pokemons = const [],
    this.nextPageLink,
  });
  final List<Pokemon> pokemons;
  final String? nextPageLink;
}

class PokemonStateProvider extends StateNotifier<PokemonState> {
  PokemonStateProvider(this.ref) : super(const PokemonState());

  final Ref ref;

  void fetchPokemon(Uri uri) async {
    http.Response _res = await http.get(uri);

    Map<String, dynamic> data = jsonDecode(_res.body);

    List<dynamic> dd =
        data['results'].map((item) => Pokemon.fromJson(item)).toList();

    List<Pokemon> current = state.pokemons;

    state = PokemonState(
      pokemons: current + dd.map((item) => item as Pokemon).toList(),
      nextPageLink: data['next'],
    );
  }
}
