class Users {
  Users({required this.name, required this.password, this.phoneNumber, required this.role});

  Users.fromJson(Map<String, Object?> json)
      : this(
    name: json['name']! as String,
    password: json['password']! as String,
    phoneNumber: json['phoneNumber']! as String?,
    role: json['role']! as int,
  );

  final String name;
  final String password;
  final String? phoneNumber;
  final int role;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'password': password,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}