import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:http/http.dart' as http;

class DescendingInfiniteLoading extends StatefulWidget {
  const DescendingInfiniteLoading({super.key});

  @override
  State<DescendingInfiniteLoading> createState() =>
      _DescendingInfiniteLoadingState();
}

class _DescendingInfiniteLoadingState extends State<DescendingInfiniteLoading> {
  final ScrollController _controller = ScrollController();
  bool _isLoading = false;
  List<Pokemon> _pokemons = [];
  String? _nextPageLink;

  @override
  void initState() {
    _fetchPokemon(Uri.https('pokeapi.co', '/api/v2/pokemon'));

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
    setState(() {
      _isLoading = true;
    });

    http.Response _res = await http.get(uri);

    Map<String, dynamic> data = jsonDecode(_res.body);

    List<dynamic> dd =
        data['results'].map((item) => Pokemon.fromJson(item)).toList();

    setState(() {
      _pokemons.addAll(dd.map((item) => item as Pokemon).toList());
      _nextPageLink = data['next'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: _pokemons.length + 1,
        itemBuilder: (context, index) {
          if (index + 1 == _pokemons.length + 1) {
            return Padding(
              padding: EdgeInsets.all(40.0),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            );
          }

          return ListTile(
            title: Text('${_pokemons[index].name}'),
            tileColor: Colors.greenAccent,
          );
        },
      ),
    );
  }
}
