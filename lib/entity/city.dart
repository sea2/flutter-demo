



class City {
  int id;

  String name;

  String phone;

   City({required this.id, required this.name, required this.phone});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(id: json['id'], name: json['name'], phone: json['phone']);
  }

  @override
  String toString() {
    return 'City{id: $id, name: $name, phone: $phone}';
  }

}
