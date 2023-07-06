class LoginModel {
  final String phoneNumber;
  final String password;

  LoginModel({required this.phoneNumber,required this.password});

  factory LoginModel.fromJson(Map<String, String> json) {
    return LoginModel(phoneNumber: json['phone_number']!, password: json['password']!);
  }

  Map<String, String> toJson() {
    final  data =  <String, String>{};
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    return data;
  }
}
