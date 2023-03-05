import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:flutter_application_1/provider/count_state_provider.dart';
import 'package:flutter_application_1/provider/pokemon_state_provier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class DefaultInfiniteLoading extends ConsumerStatefulWidget {
  const DefaultInfiniteLoading({super.key});

  @override
  _DefaultInfiniteLoadingState createState() => _DefaultInfiniteLoadingState();
}

class _DefaultInfiniteLoadingState
    extends ConsumerState<DefaultInfiniteLoading> {
  @override
  Widget build(BuildContext context) {
    final String value = ref.watch(helloWorldProvider);
    final int count = ref.watch(countStateProvider);
    final PokemonState pokemon = ref.watch(pokemonStateProvider);

    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('$count'),
      ),
      body: pokemon.pokemons.isEmpty
          ? SizedBox(
              width: double.infinity,
              height: 100.0,
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(pokemonStateProvider.notifier)
                      .fetchPokemon(Uri.https('pokeapi.co', '/api/v2/pokemon'));
                },
                child: Text(value),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                if (pokemon.nextPageLink != null) {
                  ref
                      .read(pokemonStateProvider.notifier)
                      .fetchPokemon(Uri.parse(pokemon.nextPageLink!));
                } else {
                  ref
                      .read(pokemonStateProvider.notifier)
                      .fetchPokemon(Uri.https('pokeapi.co', '/api/v2/pokemon'));
                }
              },
              child: ListView.builder(
                itemCount: pokemon.pokemons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${pokemon.pokemons[index].name}'),
                    tileColor: Colors.greenAccent,
                  );
                },
              ),
            ),
    );
  }
}
