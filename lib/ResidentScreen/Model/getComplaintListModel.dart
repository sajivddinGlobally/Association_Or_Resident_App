// To parse this JSON data, do
//
//     final getComplaintListModel = getComplaintListModelFromJson(jsonString);

import 'dart:convert';

GetComplaintListModel getComplaintListModelFromJson(String str) => GetComplaintListModel.fromJson(json.decode(str));

String getComplaintListModelToJson(GetComplaintListModel data) => json.encode(data.toJson());

class GetComplaintListModel {
    bool? status;
    String? message;
    Data? data;

    GetComplaintListModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetComplaintListModel.fromJson(Map<String, dynamic> json) => GetComplaintListModel(
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
    Header? header;
    RegisteredApartment? registeredApartment;
    List<FilterTab>? filterTabs;
    int? totalCount;
    List<Request>? requests;

    Data({
        this.header,
        this.registeredApartment,
        this.filterTabs,
        this.totalCount,
        this.requests,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        registeredApartment: json["registered_apartment"] == null ? null : RegisteredApartment.fromJson(json["registered_apartment"]),
        filterTabs: json["filter_tabs"] == null ? [] : List<FilterTab>.from(json["filter_tabs"]!.map((x) => FilterTab.fromJson(x))),
        totalCount: json["total_count"],
        requests: json["requests"] == null ? [] : List<Request>.from(json["requests"]!.map((x) => Request.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "header": header?.toJson(),
        "registered_apartment": registeredApartment?.toJson(),
        "filter_tabs": filterTabs == null ? [] : List<dynamic>.from(filterTabs!.map((x) => x.toJson())),
        "total_count": totalCount,
        "requests": requests == null ? [] : List<dynamic>.from(requests!.map((x) => x.toJson())),
    };
}

class FilterTab {
    String? key;
    String? label;
    bool? isActive;

    FilterTab({
        this.key,
        this.label,
        this.isActive,
    });

    factory FilterTab.fromJson(Map<String, dynamic> json) => FilterTab(
        key: json["key"],
        label: json["label"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "label": label,
        "is_active": isActive,
    };
}

class Header {
    String? subtitle;
    String? title;

    Header({
        this.subtitle,
        this.title,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        subtitle: json["subtitle"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "subtitle": subtitle,
        "title": title,
    };
}

class RegisteredApartment {
    String? label;
    String? text;

    RegisteredApartment({
        this.label,
        this.text,
    });

    factory RegisteredApartment.fromJson(Map<String, dynamic> json) => RegisteredApartment(
        label: json["label"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "text": text,
    };
}

class Request {
    int? id;
    String? tokenLabel;
    String? tokenNumber;
    String? status;
    String? statusColor;
    String? title;
    String? location;
    String? viewDetailsUrl;

    Request({
        this.id,
        this.tokenLabel,
        this.tokenNumber,
        this.status,
        this.statusColor,
        this.title,
        this.location,
        this.viewDetailsUrl,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        tokenLabel: json["token_label"],
        tokenNumber: json["token_number"],
        status: json["status"],
        statusColor: json["status_color"],
        title: json["title"],
        location: json["location"],
        viewDetailsUrl: json["view_details_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "token_label": tokenLabel,
        "token_number": tokenNumber,
        "status": status,
        "status_color": statusColor,
        "title": title,
        "location": location,
        "view_details_url": viewDetailsUrl,
    };
}
