class Pokemon {
  String name;

  Pokemon(this.name);

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final pokemon = Pokemon(json['name']);
    return pokemon;
  }
}
