import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:property_association_or_resident/AssociationScreen/MantenanceCharges/outStandingPending.dart';
import 'package:property_association_or_resident/Core/Network/ApiStateNetwork.dart';
import 'package:property_association_or_resident/Core/data/model/BodyModel/aiAssistanceBodyModel.dart';
import 'package:property_association_or_resident/Core/data/model/BodyModel/resetPassBodyModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/commiteDashboardModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/complexDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/documentDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getAlertModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getPropertyAssistantModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getPropertyUnitDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getPropertyUnitListModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/pendingMaintananceModel.dart';
import 'package:property_association_or_resident/ResidentScreen/Model/getVisitorPassListModel.dart';
import '../../ResidentScreen/Model/ResidentCommunityContactResModel.dart';
import '../../ResidentScreen/Model/ResidentEmergencyContactResModel.dart';
import '../../ResidentScreen/Model/ResidentMmcStatusResModel.dart';
import '../../ResidentScreen/Model/ResidentPropertyDetailsResModel.dart';
import '../../ResidentScreen/Model/addResidentComplainResModel.dart';
import '../../ResidentScreen/Model/createPassVisitorBodyModel.dart';
import '../../ResidentScreen/Model/createPassVisotroResModel.dart';
import '../../ResidentScreen/Model/getComplaintListModel.dart';
import '../../ResidentScreen/Model/getComplaintRequestListModel.dart';
import '../../ResidentScreen/Model/getComplaintTrackingModel.dart';
import '../../ResidentScreen/Model/getResidentCalenderModel.dart';
import '../../ResidentScreen/Model/getResidentProfileModel.dart';
import '../../ResidentScreen/Model/residentDashboardModel.dart';
import '../data/model/BodyModel/addResidentBodyModel.dart';
import '../data/model/BodyModel/assocationCalenderBodyModel.dart';
import '../data/model/BodyModel/changePasswordBodyModel.dart';
import '../data/model/BodyModel/forgotPassBodyModel.dart';
import '../data/model/BodyModel/loginBodyModel.dart';
import '../data/model/BodyModel/registerBodyModel.dart';
import '../data/model/BodyModel/updateTicketStatusBodyModel.dart';
import '../data/model/BodyModel/verifyOtpBodyModel.dart';
import '../data/model/ResponseModel/GetNotificaionListModel.dart';
import '../data/model/ResponseModel/MarkNotificationReadResModel.dart';
import '../data/model/ResponseModel/ServiceManagementPerformanceResModel.dart';
import '../data/model/ResponseModel/ServiceManagementResModel.dart';
import '../data/model/ResponseModel/addResidentResModel.dart';
import '../data/model/ResponseModel/assocationComplaintResModel.dart';
import '../data/model/ResponseModel/associationCalenderresModel.dart';
import '../data/model/ResponseModel/AssociationReportResModel.dart';
import '../data/model/ResponseModel/changePassResModel.dart';
import '../data/model/ResponseModel/complaintStatusResModel.dart';
import '../data/model/ResponseModel/defaulterDetailsModel.dart';
import '../data/model/ResponseModel/defaulterListModel.dart';
import '../data/model/ResponseModel/editProfileResModel.dart';
import '../data/model/ResponseModel/forgotPassResModel.dart';
import '../data/model/ResponseModel/getAssignedModel.dart';
import '../data/model/ResponseModel/getComplaintDetailsResModel.dart';
import '../data/model/ResponseModel/getDocumentListModel.dart';
import '../data/model/ResponseModel/getProfileModel.dart';
import '../data/model/ResponseModel/getResidentDetailsModel.dart';
import '../data/model/ResponseModel/getResidentResModel.dart';
import '../data/model/ResponseModel/getServiceRequestDetailsModel.dart';
import '../data/model/ResponseModel/getServiceRequestModel.dart';
import '../data/model/ResponseModel/getServiceRequetStatusModel.dart';
import '../data/model/ResponseModel/getUnitsModel.dart';
import '../data/model/ResponseModel/loginResModel.dart';
import '../data/model/ResponseModel/logoutModel.dart';
import '../data/model/ResponseModel/maintananceChargesModel.dart';
import '../data/model/ResponseModel/maintananceDetailsModel.dart';
import '../data/model/ResponseModel/maintananceOverviewModel.dart';
import '../data/model/ResponseModel/maintenanceChargeStatusModel.dart';
import '../data/model/ResponseModel/outstandingPendingModel.dart';
import '../data/model/ResponseModel/registerResModel.dart';
import '../data/model/ResponseModel/resetPassResModel.dart';
import '../data/model/ResponseModel/ServiceManagementDetailsResModel.dart';
import '../data/model/ResponseModel/ServiceManagementProviderDetailsResModel.dart';
import '../data/model/ResponseModel/verifyOtpResModel.dart';

class AuthService {
  final ApiStateNetwork api;

  AuthService(this.api);

  Future<GetUnAssignedResModel> getUnassigned() async {
    try {
      final response = await api.getunassigned();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<RegisterResModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String role,
    required String complexId,
    required String address,
  }) async {
    try {
      final body = RegisterBodyModel(
        email: email,
        password: password,
        phone: phone,
        name: name,
        role: role,
        confirmPassword: confirmPassword,
        complexId: complexId,
        address: address,
      );
      final response = await api.register(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResModel> login({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final body = LoginBodyModel(login: email, password: password, role: role);
      final response = await api.login(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPassResModel> forgotPassword({required String email}) async {
    try {
      final body = ForgotPassBodyModel(email: email);
      final response = await api.forgotPass(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyOtpResModel> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final body = VerifyOtpBodyModel(email: email, otp: otp);
      final response = await api.verifyOtp(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResetPassResModel> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String email,
  }) async {
    try {
      final body = ResetPassBodyModel(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        email: email,
      );
      final response = await api.resetPassword(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChangePasswordResModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final body = ChangePasswordBodyModel(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      final response = await api.changePassword(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetProfileModel> getProfileData({dynamic propertyId}) async {
    try {
      final response = await api.getProfileData(propertyId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<LogoutModel> logout() async {
    try {
      final response = await api.logout();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<EditProfileResModel> editProfile({
    required String name,
    required String phone,
    required MultipartFile? image,
  }) async {
    try {
      final response = await api.editProfile(name, phone, image);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommiteDashboardModel> getCommitteeDashboardData() async {
    try {
      final response = await api.getCommitteeDashboardData();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ComplexDetailsModel> getComplexDetails() async {
    try {
      final response = await api.getComplexDetails();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPropertyUnitListModel> getPropertyUnitList({
    String? status,
    String? block,
    String? search,
  }) async {
    try {
      final response = await api.getPropertyUnitList(
        status: (status != null && status.trim().isNotEmpty)
            ? status.trim()
            : null,
        block: (block != null && block.trim().isNotEmpty) ? block.trim() : null,
        search: (search != null && search.trim().isNotEmpty)
            ? search.trim()
            : null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPropertyUnitDetailsModel> getPropertyUnitDetails({
    required String id,
  }) async {
    try {
      final response = await api.getPropertyUnitDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetServiceRequestModel> getServiceRequests({
    String? status,
    String? search,
  }) async {
    try {
      final response = await api.getServiceRequestList(status, search);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetServiceRequestDetailsModel> getServiceRequestDetails({
    required String id,
  }) async {
    try {
      final response = await api.getServiceRequestDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetServiceRequestStatusModel> getServiceRequestStatus({
    required String id,
  }) async {
    try {
      final response = await api.getServiceRequestStatus(id: id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetDocumentListModel> getDocumentList({
    required String category,
    required String search,
  }) async {
    try {
      final response = await api.getDocumentList(category, search);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentDetailsModel> getDocumentDetails({required String id}) async {
    try {
      final response = await api.getDocumentDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MaintananceOverviewModel> getMaintenanceOverview() async {
    try {
      final response = await api.getMaintenanceOverview();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<PendingMaintenanceModel> getPendingMaintanance({
    String? priority,
    String? search,
  }) async {
    try {
      final response = await api.getPendingMaintenance(
        priority: priority,
        search: search,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MaintananceDetailsModel> getMaintananceDetails({
    required String id,
  }) async {
    try {
      final response = await api.getMaintananceDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MaintananceChargesModel> getMaintananceCharges() async {
    try {
      final response = await api.getMaintananceCharges();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MaintananceChargeStatusModel> maintenanceChargeStatus({
    required String tab,
  }) async {
    try {
      final response = await api.maintenanceChargeStatus(tab);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<DefaulterListResModel> getDefaulterList({
    required String filter,
    required String search,
  }) async {
    try {
      final response = await api.getDefaulterList(filter, search);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<DefaulterDetailsModel> getDefaulterDetails({
    required String id,
  }) async {
    try {
      final response = await api.getDefaulterDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ///////////////////////////////////
  ///
  Future<AssociationComplaintResModel> getComplaintData({
    required String status,
    required String search,
  }) async {
    try {
      final response = await api.getComplaintData(status, search);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetComplaintDetailsResModel> getComplaintDetails({
    required String id,
  }) async {
    try {
      final response = await api.getComplaintDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateTicketStatus({
    required String id,
    required String status,
  }) async {
    try {
      final body = UpdateTicketStatusBodyModel(status: status);
      final response = await api.updateTicketStatus(id, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ComplaintStatusResModel> getComplaintStatus({
    required String id,
  }) async {
    try {
      final response = await api.complaintStatus(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<OutstandingPendingModel> getOutstandingPending({
    required String filter,
    required String search,
  }) async {
    try {
      final response = await api.getOutstatndingPedning(filter, search);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /////////////////////////////////// Resident /////////////////

  Future<GetUnitsModel> getAvailableUnits() async {
    try {
      final units = await api.getAvailableUnits();
      return units;
    } catch (e) {
      rethrow;
    }
  }

  Future<AddResidentResModel> addResident({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String unitNumber,
    required bool termsAccepted,
  }) async {
    try {
      final body = AddResedentBodyModel(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        unitNumber: unitNumber,
        termsAccepted: termsAccepted,
      );
      final response = await api.addResident(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetResidentListModel> getResidentList() async {
    try {
      final response = await api.getResidentList();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetResidentDetailsModel> getResidentDetails({
    required String id,
  }) async {
    try {
      final response = await api.getResidentDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetAlertModel> getAlerts({required String filter}) async {
    try {
      final response = await api.getAlerts(filter);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetNotificaionListModel> getNotificaionList({
    required String filter,
  }) async {
    try {
      final response = await api.getNotificaionList(filter);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MarkNotificationReadResModel> markNotificationRead({
    required String id,
  }) async {
    try {
      final response = await api.markNotificationRead(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markMultipleNotificationsRead({
    required List<String> ids,
  }) async {
    try {
      await Future.wait(ids.map((id) => api.markNotificationRead(id)));
    } catch (e) {
      log("Error marking notifications as read: $e");
    }
  }

  Future<AssociationCalenderResModel> addAssociationCalendar({
    required String eventName,
    required String eventType,
    required String visitDate,
    required String visitTime,
    required String endTime,
    required String organizedBy,
    required String eventFor,
    required String description,
    required String location,
  }) async {
    try {
      final body = AssociationCalenderBodyModel(
        eventName: eventName,
        eventType: eventType,
        visitDate: DateTime.parse(visitDate),
        visitTime: visitTime,
        endTime: endTime,
        organizedBy: organizedBy,
        eventFor: eventFor,
        description: description,
        location: location,
      );
      final response = await api.addAssociationCalendar(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPropertyAssistantModel> getPropertyAssistant() async {
    try {
      final response = await api.getPropertyAssistant();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPropertyAssistantModel> sendMessageToAi({
    required String query,
  }) async {
    try {
      final body = AiAssistanceBodyModel(query: query);
      final response = await api.sendMessageToAi(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ServiceManagementResModelDart> getServiceManagementData({
    required String status,
    required String search,
  }) async {
    try {
      final queryStatus = status.isEmpty || status.toLowerCase() == "all"
          ? null
          : status;
      final querySearch = search.trim().isEmpty ? null : search.trim();
      final response = await api.getServiceManagement(queryStatus, querySearch);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ServiceManagementDetailsResModel> serviceManagementDetailsData({
    required String id,
  }) async {
    try {
      final response = await api.serviceManagementDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ServiceManagementProviderDetailsResModel>
  serviceManagementProviderDetailsData({required String id}) async {
    try {
      final response = await api.serviceManagementProviderDetails(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ServiceManagementPerformanceResModel>
  serviceManagementPerformanceData({required String id}) async {
    try {
      final response = await api.serviceManagementPerformance(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AssociationReportResModel> associationReportData({
    required String status,
    required String search,
  }) async {
    try {
      final response = await api.associationReport(status, search);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  //////////////////////////  resident dashboard   //////////////////////

  Future<ResidentDashbordModel> getResidentDashboardData() async {
    try {
      final response = await api.getResidentDashbordData();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetResidentProfileModel> getResidentProfileData() async {
    try {
      final response = await api.getResidentProfileData();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AddResidentComplaintResModel> addResidentComplaintData({
    required String category,
    required String subject,
    required String description,
    required MultipartFile? photo,
  }) async {
    try {
      final response = await api.addResidentComplaint(
        category,
        subject,
        description,
        photo,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<GetComplaintRequestListModel> getComplaintFormData() async {
  //   try {
  //     final response = await api.getComplaintFormData();
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<GetComplaintListModel> getComplaintList({
    required String status,
  }) async {
    try {
      final response = await api.getComplaintList(status: status);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetComplaintTrackingModel> getComplaintTracking({
    required String id,
  }) async {
    try {
      final response = await api.getComplaintTracking(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResidentMmcStatusResModel> residentMmnStatusData() async {
    try {
      final response = await api.residentMmcStatus();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResidentPropertyDetailsResModel> residentPropertyDetailsData() async {
    try {
      final response = await api.residentPropertyDetails();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResidentCommunityContactResModel> residentCommunityContact() async {
    try {
      final response = await api.residentCommunityContact();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<CreatVisitorPassResModdel> createVisitorPassRequest({
    required String visitorName,
    required String mobileNumber,
    required String visitorType,
    required String visitDate,
    required String visitTime,
    required String purposeOfVisit,
  }) async {
    try {
      final body = CreateVisitorPassBodyModdel(
        visitorName: visitorName,
        mobileNumber: mobileNumber,
        visitorType: visitorType,
        visitDate: visitDate,
        visitTime: visitTime,
        purposeOfVisit: purposeOfVisit,
      );
      final response = await api.createVisitorPassRequest(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetVisitorPassListModel> getVisitorPass() async {
    try {
      final response = await api.getVisitorPass();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetResidentCalenderModel> getResidentCalender({String? month}) async {
    try {
      final response = await api.getResidentCalender(month: month);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResidentEmergencyContactResModel> emergencyContactData() async {
    try {
      final response = await api.emergencyContact();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
