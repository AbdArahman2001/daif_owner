class RememberedUser {
  final String? phoneNumber;
  final String? password;

  RememberedUser({this.phoneNumber, this.password});

  factory RememberedUser.fromJson(Map<String, String?> json) {
    return RememberedUser(
        phoneNumber: json["phone_number"], password: json["password"]);
  }

  Map<String, String?> toJson() {
    return {"phone_number": phoneNumber, "password": password};
  }
}
