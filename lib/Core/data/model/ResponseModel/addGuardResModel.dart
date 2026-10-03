// To parse this JSON data, do
//
//     final addGuardResModel = addGuardResModelFromJson(jsonString);

import 'dart:convert';

AddGuardResModel addGuardResModelFromJson(String str) => AddGuardResModel.fromJson(json.decode(str));

String addGuardResModelToJson(AddGuardResModel data) => json.encode(data.toJson());

class AddGuardResModel {
    bool? status;
    String? message;
    Data? data;

    AddGuardResModel({
        this.status,
        this.message,
        this.data,
    });

    factory AddGuardResModel.fromJson(Map<String, dynamic> json) => AddGuardResModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Guard? guard;
    Complex? complex;

    Data({
        this.guard,
        this.complex,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        guard: json["guard"] == null ? null : Guard.fromJson(json["guard"]),
        complex: json["complex"] == null ? null : Complex.fromJson(json["complex"]),
    );

    Map<String, dynamic> toJson() => {
        "guard": guard?.toJson(),
        "complex": complex?.toJson(),
    };
}

class Complex {
    int? id;
    String? name;
    int? associationHeadId;
    List<int>? securityId;

    Complex({
        this.id,
        this.name,
        this.associationHeadId,
        this.securityId,
    });

    factory Complex.fromJson(Map<String, dynamic> json) => Complex(
        id: json["id"],
        name: json["name"],
        associationHeadId: json["association_head_id"],
        securityId: json["security_id"] == null ? [] : List<int>.from(json["security_id"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "association_head_id": associationHeadId,
        "security_id": securityId == null ? [] : List<dynamic>.from(securityId!.map((x) => x)),
    };
}

class Guard {
    int? id;
    String? name;
    String? phone;
    String? mobileNumber;
    String? email;
    String? role;
    String? guardPost;
    bool? isOnDuty;
    Shift? shift;
    String? avatar;
    String? status;

    Guard({
        this.id,
        this.name,
        this.phone,
        this.mobileNumber,
        this.email,
        this.role,
        this.guardPost,
        this.isOnDuty,
        this.shift,
        this.avatar,
        this.status,
    });

    factory Guard.fromJson(Map<String, dynamic> json) => Guard(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        role: json["role"],
        guardPost: json["guard_post"],
        isOnDuty: json["is_on_duty"],
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
        avatar: json["avatar"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "mobile_number": mobileNumber,
        "email": email,
        "role": role,
        "guard_post": guardPost,
        "is_on_duty": isOnDuty,
        "shift": shift?.toJson(),
        "avatar": avatar,
        "status": status,
    };
}

class Shift {
    int? id;
    String? name;
    String? timings;

    Shift({
        this.id,
        this.name,
        this.timings,
    });

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        name: json["name"],
        timings: json["timings"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "timings": timings,
    };
}
