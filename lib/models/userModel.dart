import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String? fcmTokens;

  UserModel({
    this.fcmTokens,
  });
  UserModel.fromMap(DocumentSnapshot data) {
    fcmTokens = data["fcm_tokens"];
  }
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fcmTokens: json["fcm_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "fcm_tokens": fcmTokens,
      };
}
