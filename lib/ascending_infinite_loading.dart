import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:http/http.dart' as http;

class AscendingInfiniteLoading extends StatefulWidget {
  const AscendingInfiniteLoading({super.key});

  @override
  State<AscendingInfiniteLoading> createState() =>
      _AscendingInfiniteLoadingState();
}

class _AscendingInfiniteLoadingState extends State<AscendingInfiniteLoading> {
  final ScrollController _controller = ScrollController();
  List<Pokemon> _pokemons = [];
  String? _nextPageLink;

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _add();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    if (_nextPageLink != null && _nextPageLink != null) {
      _fetchPokemon(Uri.parse(_nextPageLink!));
    }
  }

  void _fetchPokemon(Uri uri) async {
    http.Response _res = await http.get(uri);

    Map<String, dynamic> data = jsonDecode(_res.body);

    List<dynamic> dd =
        data['results'].map((item) => Pokemon.fromJson(item)).toList();

    setState(() {
      _pokemons.addAll(dd.map((item) => item as Pokemon).toList());
      _nextPageLink = data['next'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: _pokemons.isEmpty
          ? Container(
              width: double.infinity,
              height: 100.0,
              child: ElevatedButton(
                onPressed: () {
                  _fetchPokemon(Uri.https('pokeapi.co', '/api/v2/pokemon'));
                },
                child: Text('GET POKEMON'),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                if (_nextPageLink != null && _nextPageLink != null) {
                  _fetchPokemon(Uri.parse(_nextPageLink!));
                } else {
                  _fetchPokemon(Uri.https('pokeapi.co', '/api/v2/pokemon'));
                }
              },
              child: ListView.builder(
                reverse: true,
                itemCount: _pokemons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${_pokemons[index].name}'),
                    tileColor: Colors.greenAccent,
                  );
                },
              ),
            ),
    );
  }
}
