class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final String originName;
  final String locationName;
  final String firstSeen;


  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.originName,
    required this.locationName,
    required this.firstSeen
  });

  // Personagem a partir do JSON da API
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
      originName: json['origin']['name'],
      locationName: json['location']['name'],
      firstSeen: json['episode'][0] // Apenas um exemplo, pegando o primeiro episódio
    );
  }
}