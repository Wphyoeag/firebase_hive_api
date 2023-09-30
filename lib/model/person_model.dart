


class PersonModel {
  String? id;
  String name;
  int age;

  PersonModel({ this.id, required this.name, required this.age});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    
    return PersonModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}