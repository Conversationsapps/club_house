
import 'package:club_house/data/network/network_api_services.dart';
import 'package:club_house/models/login/user_resposne_model.dart';
import 'package:club_house/models/register/register_response_model.dart';
import '../../res/app_url/app_url.dart';

class RegisterRepository {
  final _apiService = NetworkApiServices();

  Future<RegisterResponseModel> registerApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.registerUrl);
    return RegisterResponseModel.fromJson(response);
  }
}