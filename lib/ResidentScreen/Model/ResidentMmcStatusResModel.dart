// To parse this JSON data, do
//
//     final residentMmcStatusResModel = residentMmcStatusResModelFromJson(jsonString);

import 'dart:convert';

ResidentMmcStatusResModel residentMmcStatusResModelFromJson(String str) => ResidentMmcStatusResModel.fromJson(json.decode(str));

String residentMmcStatusResModelToJson(ResidentMmcStatusResModel data) => json.encode(data.toJson());

class ResidentMmcStatusResModel {
    final bool status;
    final String message;
    final Data data;

    ResidentMmcStatusResModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ResidentMmcStatusResModel.fromJson(Map<String, dynamic> json) => ResidentMmcStatusResModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final Header header;
    final CurrentMonth currentMonth;
    final Actions actions;

    Data({
        required this.header,
        required this.currentMonth,
        required this.actions,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: Header.fromJson(json["header"]),
        currentMonth: CurrentMonth.fromJson(json["current_month"]),
        actions: Actions.fromJson(json["actions"]),
    );

    Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "current_month": currentMonth.toJson(),
        "actions": actions.toJson(),
    };
}

class Actions {
    final PayNow viewHistory;
    final PayNow payNow;

    Actions({
        required this.viewHistory,
        required this.payNow,
    });

    factory Actions.fromJson(Map<String, dynamic> json) => Actions(
        viewHistory: PayNow.fromJson(json["view_history"]),
        payNow: PayNow.fromJson(json["pay_now"]),
    );

    Map<String, dynamic> toJson() => {
        "view_history": viewHistory.toJson(),
        "pay_now": payNow.toJson(),
    };
}

class PayNow {
    final String label;
    final String endpoint;
    final String method;
    final bool? isAvailable;

    PayNow({
        required this.label,
        required this.endpoint,
        required this.method,
        this.isAvailable,
    });

    factory PayNow.fromJson(Map<String, dynamic> json) => PayNow(
        label: json["label"],
        endpoint: json["endpoint"],
        method: json["method"],
        isAvailable: json["is_available"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "endpoint": endpoint,
        "method": method,
        "is_available": isAvailable,
    };
}

class CurrentMonth {
    final String sectionTitle;
    final String cardTitle;
    final Charge charge;
    final CurrentStatus currentStatus;
    final Month month;
    final Month paidOn;

    CurrentMonth({
        required this.sectionTitle,
        required this.cardTitle,
        required this.charge,
        required this.currentStatus,
        required this.month,
        required this.paidOn,
    });

    factory CurrentMonth.fromJson(Map<String, dynamic> json) => CurrentMonth(
        sectionTitle: json["section_title"],
        cardTitle: json["card_title"],
        charge: Charge.fromJson(json["charge"]),
        currentStatus: CurrentStatus.fromJson(json["current_status"]),
        month: Month.fromJson(json["month"]),
        paidOn: Month.fromJson(json["paid_on"]),
    );

    Map<String, dynamic> toJson() => {
        "section_title": sectionTitle,
        "card_title": cardTitle,
        "charge": charge.toJson(),
        "current_status": currentStatus.toJson(),
        "month": month.toJson(),
        "paid_on": paidOn.toJson(),
    };
}

class Charge {
    final String label;
    final int amount;
    final String currency;
    final String amountDisplay;

    Charge({
        required this.label,
        required this.amount,
        required this.currency,
        required this.amountDisplay,
    });

    factory Charge.fromJson(Map<String, dynamic> json) => Charge(
        label: json["label"],
        amount: json["amount"],
        currency: json["currency"],
        amountDisplay: json["amount_display"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "amount": amount,
        "currency": currency,
        "amount_display": amountDisplay,
    };
}

class CurrentStatus {
    final String label;
    final String value;
    final String badgeColor;

    CurrentStatus({
        required this.label,
        required this.value,
        required this.badgeColor,
    });

    factory CurrentStatus.fromJson(Map<String, dynamic> json) => CurrentStatus(
        label: json["label"],
        value: json["value"],
        badgeColor: json["badge_color"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "badge_color": badgeColor,
    };
}

class Month {
    final String label;
    final String value;

    Month({
        required this.label,
        required this.value,
    });

    factory Month.fromJson(Map<String, dynamic> json) => Month(
        label: json["label"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
    };
}

class Header {
    final String tag;
    final String subtitle;
    final String title;

    Header({
        required this.tag,
        required this.subtitle,
        required this.title,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        tag: json["tag"],
        subtitle: json["subtitle"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "tag": tag,
        "subtitle": subtitle,
        "title": title,
    };
}