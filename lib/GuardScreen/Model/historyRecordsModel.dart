// To parse this JSON data, do
//
//     final historyRecordsResModel = historyRecordsResModelFromJson(jsonString);

import 'dart:convert';

HistoryRecordsResModel historyRecordsResModelFromJson(String str) => HistoryRecordsResModel.fromJson(json.decode(str));

String historyRecordsResModelToJson(HistoryRecordsResModel data) => json.encode(data.toJson());

class HistoryRecordsResModel {
    bool? status;
    String? message;
    Data? data;

    HistoryRecordsResModel({
        this.status,
        this.message,
        this.data,
    });

    factory HistoryRecordsResModel.fromJson(Map<String, dynamic> json) => HistoryRecordsResModel(
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
    List<FilterChip>? tabs;
    List<FilterChip>? filterChips;
    List<Map<String, String?>>? records;

    Data({
        this.header,
        this.tabs,
        this.filterChips,
        this.records,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        tabs: json["tabs"] == null ? [] : List<FilterChip>.from(json["tabs"]!.map((x) => FilterChip.fromJson(x))),
        filterChips: json["filter_chips"] == null ? [] : List<FilterChip>.from(json["filter_chips"]!.map((x) => FilterChip.fromJson(x))),
        records: json["records"] == null ? [] : List<Map<String, String?>>.from(json["records"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    );

    Map<String, dynamic> toJson() => {
        "header": header?.toJson(),
        "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x.toJson())),
        "filter_chips": filterChips == null ? [] : List<dynamic>.from(filterChips!.map((x) => x.toJson())),
        "records": records == null ? [] : List<dynamic>.from(records!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    };
}

class FilterChip {
    String? key;
    String? label;
    bool? isActive;

    FilterChip({
        this.key,
        this.label,
        this.isActive,
    });

    factory FilterChip.fromJson(Map<String, dynamic> json) => FilterChip(
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
    String? title;
    String? subtitle;

    Header({
        this.title,
        this.subtitle,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        title: json["title"],
        subtitle: json["subtitle"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
    };
}
