// To parse this JSON data, do
//
//     final getUnitsModel = getUnitsModelFromJson(jsonString);

import 'dart:convert';

GetUnitsModel getUnitsModelFromJson(String str) => GetUnitsModel.fromJson(json.decode(str));

String getUnitsModelToJson(GetUnitsModel data) => json.encode(data.toJson());

class GetUnitsModel {
    bool? status;
    String? message;
    Data? data;

    GetUnitsModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetUnitsModel.fromJson(Map<String, dynamic> json) => GetUnitsModel(
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
    Complex? complex;
    int? totalAvailable;
    List<AvailableUnit>? availableUnits;

    Data({
        this.complex,
        this.totalAvailable,
        this.availableUnits,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        complex: json["complex"] == null ? null : Complex.fromJson(json["complex"]),
        totalAvailable: json["total_available"],
        availableUnits: json["available_units"] == null ? [] : List<AvailableUnit>.from(json["available_units"]!.map((x) => AvailableUnit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "complex": complex?.toJson(),
        "total_available": totalAvailable,
        "available_units": availableUnits == null ? [] : List<dynamic>.from(availableUnits!.map((x) => x.toJson())),
    };
}

class AvailableUnit {
    int? id;
    int? propertyId;
    String? unitNumber;
    String? propertyName;
    String? ownerName;
    bool? isVacant;
    String? floor;
    String? area;
    String? label;

    AvailableUnit({
        this.id,
        this.propertyId,
        this.unitNumber,
        this.propertyName,
        this.ownerName,
        this.isVacant,
        this.floor,
        this.area,
        this.label,
    });

    factory AvailableUnit.fromJson(Map<String, dynamic> json) => AvailableUnit(
        id: json["id"],
        propertyId: json["property_id"],
        unitNumber: json["unit_number"],
        propertyName: json["property_name"],
        ownerName: json["owner_name"],
        isVacant: json["is_vacant"],
        floor: json["floor"],
        area: json["area"],
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "unit_number": unitNumber,
        "property_name": propertyName,
        "owner_name": ownerName,
        "is_vacant": isVacant,
        "floor": floor,
        "area": area,
        "label": label,
    };
}

class Complex {
    int? id;
    String? name;

    Complex({
        this.id,
        this.name,
    });

    factory Complex.fromJson(Map<String, dynamic> json) => Complex(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
