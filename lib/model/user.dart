class User {
  final String name;
  final String email;
  final String company;

  User.fromMap(Map<String, dynamic> map)
    : name = map['name'],
      email = map['email'],
      company = map['company']['name'];
}
