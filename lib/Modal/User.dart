class User {
  String firstName;
  String lastName;
  String email;
  String password;
  var dob;
  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.dob,
      required this.password});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'],
        password: json['password'],
        dob: json['dob']);
  }
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob,
      'password': password
    };
  }
}
