import 'package:dio/dio.dart';
import 'package:property_association_or_resident/Core/data/model/BodyModel/aiAssistanceBodyModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/complexDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/defaulterDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/documentDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getPropertyAssistantModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getPropertyUnitDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getPropertyUnitListModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getResidentDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getServiceRequestModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getServiceRequetStatusModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/maintananceChargesModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/maintananceDetailsModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/outstandingPendingModel.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/pendingMaintananceModel.dart';
import 'package:retrofit/retrofit.dart';
import '../data/model/BodyModel/addResidentBodyModel.dart';
import '../data/model/BodyModel/assocationCalenderBodyModel.dart';
import '../data/model/BodyModel/changePasswordBodyModel.dart';
import '../data/model/BodyModel/forgotPassBodyModel.dart';
import '../data/model/BodyModel/loginBodyModel.dart';
import '../data/model/BodyModel/registerBodyModel.dart';
import '../data/model/BodyModel/resetPassBodyModel.dart'
    show ResetPassBodyModel;
import '../data/model/BodyModel/verifyOtpBodyModel.dart';
import '../data/model/ResponseModel/GetNotificaionListModel.dart';
import '../data/model/ResponseModel/ServiceManagementPerformanceResModel.dart';
import '../data/model/ResponseModel/ServiceManagementResModel.dart';
import '../data/model/ResponseModel/addResidentResModel.dart';
import '../data/model/ResponseModel/assocationComplaintResModel.dart';
import '../data/model/ResponseModel/associationCalenderresModel.dart';
import '../data/model/ResponseModel/AssociationReportResModel.dart';
import '../data/model/ResponseModel/changePassResModel.dart';
import '../data/model/ResponseModel/commiteDashboardModel.dart';
import '../data/model/ResponseModel/complaintStatusResModel.dart';
import '../data/model/ResponseModel/defaulterListModel.dart';
import '../data/model/ResponseModel/forgotPassResModel.dart';
import '../data/model/ResponseModel/getAlertModel.dart';
import '../data/model/ResponseModel/getAssignedModel.dart';
import '../data/model/ResponseModel/getComplaintDetailsResModel.dart';
import '../data/model/ResponseModel/getDocumentListModel.dart';
import '../data/model/ResponseModel/getProfileModel.dart';
import '../data/model/ResponseModel/getResidentResModel.dart';
import '../data/model/ResponseModel/getServiceRequestDetailsModel.dart';
import '../data/model/ResponseModel/getUnitsModel.dart';
import '../data/model/ResponseModel/loginResModel.dart';
import '../data/model/ResponseModel/logoutModel.dart';
import '../data/model/ResponseModel/maintananceOverviewModel.dart';
import '../data/model/ResponseModel/maintenanceChargeStatusModel.dart';
import '../data/model/ResponseModel/registerResModel.dart';
import '../data/model/ResponseModel/resetPassResModel.dart';
import '../data/model/ResponseModel/ServiceManagementDetailsResModel.dart';
import '../data/model/ResponseModel/ServiceManagementProviderDetailsResModel.dart';
import '../data/model/ResponseModel/verifyOtpResModel.dart';
import '../data/model/ResponseModel/editProfileResModel.dart';

part 'ApiStateNetwork.g.dart';

@RestApi(baseUrl: "https://realestate.gwsstaging.com")
abstract class ApiStateNetwork {
  factory ApiStateNetwork(Dio dio, {String baseUrl}) = _ApiStateNetwork;

  @GET("/api/v1/complexes/unassigned-head")
  Future<GetUnAssignedResModel> getunassigned();

  @POST("/api/v1/auth/register")
  Future<RegisterResModel> register(@Body() RegisterBodyModel body);

  @POST("/api/v1/auth/login")
  Future<LoginResModel> login(@Body() LoginBodyModel body);

  @POST("/api/v1/auth/forgot-password")
  Future<ForgotPassResModel> forgotPass(@Body() ForgotPassBodyModel body);

  @POST("/api/v1/auth/verify-otp")
  Future<VerifyOtpResModel> verifyOtp(@Body() VerifyOtpBodyModel body);

  @POST("/api/v1/auth/reset-password")
  Future<ResetPassResModel> resetPassword(@Body() ResetPassBodyModel body);

  @PUT("/api/v1/auth/password")
  Future<ChangePasswordResModel> changePassword(
    @Body() ChangePasswordBodyModel body,
  );

  @GET("/api/v1/auth/me")
  Future<GetProfileModel> getProfileData(@Query("property_id") int? propertyId);

  @POST("/api/v1/auth/logout")
  Future<LogoutModel> logout();

  @MultiPart()
  @POST("/api/v1/auth/profile")
  Future<EditProfileResModel> editProfile(
    @Part(name: "name") String name,
    @Part(name: "phone") String phone,
    @Part(name: "image") MultipartFile? image,
  );

  @GET("/api/v1/committee/dashboard")
  Future<CommiteDashboardModel> getCommitteeDashboardData();

  @GET("/api/v1/committee/complex/details")
  Future<ComplexDetailsModel> getComplexDetails();

  @GET("/api/v1/committee/units")
  Future<GetPropertyUnitListModel> getPropertyUnitList({
    @Query("status") String? status,
    @Query("block") String? block,
    @Query("search") String? search,
  });

  @GET("/api/v1/committee/units/{id}")
  Future<GetPropertyUnitDetailsModel> getPropertyUnitDetails(
    @Path("id") String id,
  );

  @GET("/api/v1/committee/service-requests")
  Future<GetServiceRequestModel> getServiceRequestList(
    @Query("status") String? status,
    @Query("search") String? search,
  );

  @GET("/api/v1/committee/tickets/{id}/details")
  Future<GetServiceRequestDetailsModel> getServiceRequestDetails(
    @Path("id") String id,
  );

  @GET("/api/v1/committee/service-requests/{id}/tracking")
  Future<GetServiceRequestStatusModel> getServiceRequestStatus({
    @Path("id") required String id,
  });

  @GET("/api/v1/committee/documents")
  Future<GetDocumentListModel> getDocumentList(
    @Query("category") String category,
    @Query("search") String search,
  );

  @GET("/api/v1/committee/documents/{id}")
  Future<DocumentDetailsModel> getDocumentDetails(@Path('id') String id);

  @GET("/api/v1/committee/maintenance/overview")
  Future<MaintananceOverviewModel> getMaintenanceOverview();

  @GET("/api/v1/committee/maintenance/pending")
  Future<PendingMaintenanceModel> getPendingMaintenance({
    @Query("priority") String? priority,
    @Query("search") String? search,
  });

  @GET("/api/v1/committee/maintenance/{id}/details")
  Future<MaintananceDetailsModel> getMaintananceDetails(@Path("id") String id);

  @GET("/api/v1/committee/charges/overview")
  Future<MaintananceChargesModel> getMaintananceCharges();

  @GET("/api/v1/committee/charges/status")
  Future<MaintananceChargeStatusModel> maintenanceChargeStatus(
    @Query('tab') String tab,
  );

  @GET("/api/v1/committee/charges/defaulters")
  Future<DefaulterListResModel> getDefaulterList(
    @Query('filter') String filter,
    @Query('search') String search,
  );

  @GET("/api/v1/committee/charges/defaulters/{id}")
  Future<DefaulterDetailsModel> getDefaulterDetails(@Path("id") String id);

  /////////////////////////
  @GET("/api/v1/committee/complaints")
  Future<AssociationComplaintResModel> getComplaintData(
    @Query("status") String? status,
    @Query("search") String? search,
  );

  @GET("/api/v1/committee/complaints/{id}")
  Future<GetComplaintDetailsResModel> getComplaintDetails(
    @Path("id") String id,
  );
  @GET("/api/v1/committee/complaints/{id}/status")
  Future<ComplaintStatusResModel> complaintStatus(@Path("id") String id);

  @GET("/api/v1/committee/charges/pending")
  Future<OutstandingPendingModel> getOutstatndingPedning(
    @Query('filter') String filter,
    @Query('search') String search,
  );
  //////////////////////////////// Resident //////////////////////////

  @GET("/api/v1/committee/units/available")
  Future<GetUnitsModel> getAvailableUnits();

  @POST("/api/v1/committee/residents")
  Future<AddResidentResModel> addResident(@Body() AddResedentBodyModel body);

  @GET("/api/v1/committee/residents")
  Future<GetResidentListModel> getResidentList();

  @GET("/api/v1/committee/residents/121")
  Future<GetResidentDetailsModel> getResidentDetails(@Path('id') String id);

  @GET("/api/v1/committee/alerts")
  Future<GetAlertModel> getAlerts(@Query('filter') String filter);

  @GET("/api/v1/notifications")
  Future<GetNotificaionListModel> getNotificaionList(
    @Query("filter") String filter,
  );

  @POST("/api/v1/association-calendar")
  Future<AssociationCalenderResModel> addAssociationCalendar(
    @Body() AssociationCalenderBodyModel body,
  );

  @GET("/api/v1/ai/property-assistant")
  Future<GetPropertyAssistantModel> getPropertyAssistant();

  @POST("/api/v1/ai/property-assistant")
  Future<GetPropertyAssistantModel> sendMessageToAi(
    @Body() AiAssistanceBodyModel body,
  );

  @GET("/api/v1/services")
  Future<ServiceManagementResModelDart> getServiceManagement(
    @Query("status") String? status,
    @Query("search") String? search,
  );

  @GET("/api/v1/services/{id}")
  Future<ServiceManagementDetailsResModel> serviceManagementDetails(
    @Path("id") String id,
  );

  @GET("/api/v1/services/{id}/provider")
  Future<ServiceManagementProviderDetailsResModel>
  serviceManagementProviderDetails(@Path("id") String id);

  @GET("/api/v1/services/{id}/performance")
  Future<ServiceManagementPerformanceResModel> serviceManagementPerformance(
    @Path("id") String id,
  );

  @GET("/api/v1/committee/reports?category=financial")
  Future<AssociationReportResModel> associationReport(
    @Query("status") String? status,
    @Query("search") String? search,
  );
}
