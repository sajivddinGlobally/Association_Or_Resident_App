// To parse this JSON data, do
//
//     final addResedentBodyModel = addResedentBodyModelFromJson(jsonString);

import 'dart:convert';

AddResedentBodyModel addResedentBodyModelFromJson(String str) => AddResedentBodyModel.fromJson(json.decode(str));

String addResedentBodyModelToJson(AddResedentBodyModel data) => json.encode(data.toJson());

class AddResedentBodyModel {
    String? name;
    String? email;
    String? phone;
    String? password;
    String? confirmPassword;
    String? unitNumber;
    bool? termsAccepted;
    String? occupancyType;

    AddResedentBodyModel({
        this.name,
        this.email,
        this.phone,
        this.password,
        this.confirmPassword,
        this.unitNumber,
        this.termsAccepted,
        this.occupancyType,
    });

    factory AddResedentBodyModel.fromJson(Map<String, dynamic> json) => AddResedentBodyModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        unitNumber: json["unit_number"],
        termsAccepted: json["terms_accepted"],
        occupancyType: json["occupancy_type"] ?? json["resident_type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "confirm_password": confirmPassword,
        "unit_number": unitNumber,
        "terms_accepted": termsAccepted,
        if (occupancyType != null) "occupancy_type": occupancyType,
    };
}
