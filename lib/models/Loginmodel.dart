import 'dart:convert';

class Loginmodel {
  bool status;
  String message;
  String token;

  Loginmodel({
    required this.status,
    required this.message,
    required this.token,
  });

  // Factory untuk parsing dari JSON
  factory Loginmodel.fromJson(Map<String, dynamic> json) {
    return Loginmodel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
    );
  }

  // Method untuk convert ke JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'token': token,
    };
  }

  // Helper untuk parsing dari string JSON
  static Loginmodel fromJsonString(String jsonString) {
    return Loginmodel.fromJson(json.decode(jsonString));
  }

  // Helper untuk convert ke string JSON
  String toJsonString() {
    return json.encode(toJson());
  }
}