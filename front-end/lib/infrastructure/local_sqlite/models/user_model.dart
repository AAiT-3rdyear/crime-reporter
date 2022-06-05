class User {
  final int fullname;
  final String imageURL;
  final String email;
  final String phone_no;
  final int password;
  final int role;
  final int location;

  User({ required this.fullname, required this.imageURL, required this.email, required this.phone_no, required this.password, required this.role, required this.location });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'imageURL': imageURL,
      'email': email,
      'phone_no': phone_no,
      'password': password,
      'role': role,
      'location': location,
    };
  }

  @override
  String toString() {
    return 'Trans{fullname: $fullname, imageURL: $imageURL, email: $email, role: $role, location: $location}';
  }

}