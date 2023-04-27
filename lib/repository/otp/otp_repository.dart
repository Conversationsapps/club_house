
import 'package:club_house/data/network/network_api_services.dart';
import 'package:club_house/models/login/user_resposne_model.dart';
import 'package:club_house/models/otp/otp_response_model.dart';
import 'package:club_house/models/otp/verification_response_model.dart';
import 'package:club_house/models/register/register_response_model.dart';
import '../../res/app_url/app_url.dart';

class OTPRepository {
  final _apiService = NetworkApiServices();

  Future<OTPResponseModel> otpApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.otpUrl);
    return OTPResponseModel.fromJson(response);
  }
  Future<VerificationResponseModel> verificationApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.verification);
    return VerificationResponseModel.fromJson(response);
  }

  Future<OTPResponseModel> resendOtpApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.resendOtpUrl);
    return OTPResponseModel.fromJson(response);
  }
}