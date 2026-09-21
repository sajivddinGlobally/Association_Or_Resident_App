// To parse this JSON data, do
//
//     final serviceManagementProviderDetailsResModel = serviceManagementProviderDetailsResModelFromJson(jsonString);

import 'dart:convert';

ServiceManagementProviderDetailsResModel serviceManagementProviderDetailsResModelFromJson(String str) => ServiceManagementProviderDetailsResModel.fromJson(json.decode(str));

String serviceManagementProviderDetailsResModelToJson(ServiceManagementProviderDetailsResModel data) => json.encode(data.toJson());

class ServiceManagementProviderDetailsResModel {
    final bool status;
    final String message;
    final Data data;

    ServiceManagementProviderDetailsResModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ServiceManagementProviderDetailsResModel.fromJson(Map<String, dynamic> json) => ServiceManagementProviderDetailsResModel(
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
    final RegisteredServiceProvider registeredServiceProvider;
    final ProviderInformation providerInformation;
    final PrimaryContact primaryContact;
    final ContactDetails contactDetails;
    final AssignedServices assignedServices;
    final ProviderPerformance providerPerformance;
    final ProviderDocuments providerDocuments;

    Data({
        required this.header,
        required this.registeredServiceProvider,
        required this.providerInformation,
        required this.primaryContact,
        required this.contactDetails,
        required this.assignedServices,
        required this.providerPerformance,
        required this.providerDocuments,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: Header.fromJson(json["header"]),
        registeredServiceProvider: RegisteredServiceProvider.fromJson(json["registered_service_provider"]),
        providerInformation: ProviderInformation.fromJson(json["provider_information"]),
        primaryContact: PrimaryContact.fromJson(json["primary_contact"]),
        contactDetails: ContactDetails.fromJson(json["contact_details"]),
        assignedServices: AssignedServices.fromJson(json["assigned_services"]),
        providerPerformance: ProviderPerformance.fromJson(json["provider_performance"]),
        providerDocuments: ProviderDocuments.fromJson(json["provider_documents"]),
    );

    Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "registered_service_provider": registeredServiceProvider.toJson(),
        "provider_information": providerInformation.toJson(),
        "primary_contact": primaryContact.toJson(),
        "contact_details": contactDetails.toJson(),
        "assigned_services": assignedServices.toJson(),
        "provider_performance": providerPerformance.toJson(),
        "provider_documents": providerDocuments.toJson(),
    };
}

class AssignedServices {
    final String title;
    final List<Service> services;

    AssignedServices({
        required this.title,
        required this.services,
    });

    factory AssignedServices.fromJson(Map<String, dynamic> json) => AssignedServices(
        title: json["title"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
    };
}

class Service {
    final int id;
    final String title;
    final String subtitle;
    final String status;

    Service({
        required this.id,
        required this.title,
        required this.subtitle,
        required this.status,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "status": status,
    };
}

class ContactDetails {
    final String title;
    final String phone;
    final String email;
    final String workingHours;
    final String emergencySupport;

    ContactDetails({
        required this.title,
        required this.phone,
        required this.email,
        required this.workingHours,
        required this.emergencySupport,
    });

    factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
        title: json["title"],
        phone: json["phone"],
        email: json["email"],
        workingHours: json["working_hours"],
        emergencySupport: json["emergency_support"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "phone": phone,
        "email": email,
        "working_hours": workingHours,
        "emergency_support": emergencySupport,
    };
}

class Header {
    final String title;
    final String subtitle;

    Header({
        required this.title,
        required this.subtitle,
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

class PrimaryContact {
    final String title;
    final String contactPerson;
    final String contactRole;
    final String avatar;

    PrimaryContact({
        required this.title,
        required this.contactPerson,
        required this.contactRole,
        required this.avatar,
    });

    factory PrimaryContact.fromJson(Map<String, dynamic> json) => PrimaryContact(
        title: json["title"],
        contactPerson: json["contact_person"],
        contactRole: json["contact_role"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "contact_person": contactPerson,
        "contact_role": contactRole,
        "avatar": avatar,
    };
}

class ProviderDocuments {
    final String title;
    final List<Document> documents;

    ProviderDocuments({
        required this.title,
        required this.documents,
    });

    factory ProviderDocuments.fromJson(Map<String, dynamic> json) => ProviderDocuments(
        title: json["title"],
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
    };
}

class Document {
    final String title;
    final String format;
    final String status;
    final String url;

    Document({
        required this.title,
        required this.format,
        required this.status,
        required this.url,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        title: json["title"],
        format: json["format"],
        status: json["status"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "format": format,
        "status": status,
        "url": url,
    };
}

class ProviderInformation {
    final String title;
    final String providerType;
    final String providerId;
    final String registrationDate;
    final String status;
    final String contractStatus;
    final String serviceArea;

    ProviderInformation({
        required this.title,
        required this.providerType,
        required this.providerId,
        required this.registrationDate,
        required this.status,
        required this.contractStatus,
        required this.serviceArea,
    });

    factory ProviderInformation.fromJson(Map<String, dynamic> json) => ProviderInformation(
        title: json["title"],
        providerType: json["provider_type"],
        providerId: json["provider_id"],
        registrationDate: json["registration_date"],
        status: json["status"],
        contractStatus: json["contract_status"],
        serviceArea: json["service_area"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "provider_type": providerType,
        "provider_id": providerId,
        "registration_date": registrationDate,
        "status": status,
        "contract_status": contractStatus,
        "service_area": serviceArea,
    };
}

class ProviderPerformance {
    final String title;
    final int score;
    final String headline;
    final String serviceQuality;
    final String performanceUrl;

    ProviderPerformance({
        required this.title,
        required this.score,
        required this.headline,
        required this.serviceQuality,
        required this.performanceUrl,
    });

    factory ProviderPerformance.fromJson(Map<String, dynamic> json) => ProviderPerformance(
        title: json["title"],
        score: json["score"],
        headline: json["headline"],
        serviceQuality: json["service_quality"],
        performanceUrl: json["performance_url"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "score": score,
        "headline": headline,
        "service_quality": serviceQuality,
        "performance_url": performanceUrl,
    };
}

class RegisteredServiceProvider {
    final String badge;
    final String tag;
    final String name;
    final String subtitle;
    final Stats stats;

    RegisteredServiceProvider({
        required this.badge,
        required this.tag,
        required this.name,
        required this.subtitle,
        required this.stats,
    });

    factory RegisteredServiceProvider.fromJson(Map<String, dynamic> json) => RegisteredServiceProvider(
        badge: json["badge"],
        tag: json["tag"],
        name: json["name"],
        subtitle: json["subtitle"],
        stats: Stats.fromJson(json["stats"]),
    );

    Map<String, dynamic> toJson() => {
        "badge": badge,
        "tag": tag,
        "name": name,
        "subtitle": subtitle,
        "stats": stats.toJson(),
    };
}

class Stats {
    final String services;
    final String since;
    final String rating;

    Stats({
        required this.services,
        required this.since,
        required this.rating,
    });

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        services: json["services"],
        since: json["since"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "services": services,
        "since": since,
        "rating": rating,
    };
}