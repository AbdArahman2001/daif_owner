import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:daif_owner/helper/helper.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UserModel {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String? password;
  final dynamic image; // XFile or String
  final String governorateId;
  final String? accessToken;
   bool? verify;
   TokenType? tokenType;

  UserModel(
      {required this.fullName,
      required this.phoneNumber,
      required this.email,
      this.password,
      this.accessToken,
      required this.image,
      required this.verify,
      required this.governorateId,this.tokenType});

  factory UserModel.fromLocaleJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["full_name"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      accessToken: json["token"],
      image: json["image"],
      verify: json["verify"],
      governorateId: json["governorate_id"],
      tokenType: TokenTypeInfo.getTokenTypeFromName(json["token_type"]) ,
    );
  }

  Map<String, dynamic> toLocaleJson(TokenType tokenType) {
    return {
      "full_name": fullName,
      "phone_number": phoneNumber,
      "email": email,
      "password": password,
      "image": image,
      "governorate_id": governorateId,
      "verify": verify,
      "token": accessToken,
      "token_type": tokenType.name,
    };
  }

  factory UserModel.fromApiJson(Map<String, dynamic> json) {
    final Map<String, dynamic> userData =
        jsonDecode(jsonEncode(json["user-data"]));
    return UserModel(
        fullName: userData["full_name"],
        phoneNumber: userData["phone"],
        accessToken: json["access_token"],
        email: userData["email"],
        image: userData["image"],
        verify: userData["verify"],
        governorateId: userData["governorate_id"]);
  }

  Map<String, dynamic> toApiJson() {
    return {
      "full_name": fullName,
      "phone_number": phoneNumber,
      "email": email,
      "password": password,
      "governorate_id": governorateId,
    };
  }



  // Map<String, dynamic> getRequestHeaders() {
  //   log("getting query headers: ${accessToken?.split("_").last}");
  //   return {
  //
  //   };
  // }
}
