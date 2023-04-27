
import 'package:club_house/data/network/network_api_services.dart';
import '../../models/login/user_resposne_model.dart';
import '../../res/app_url/app_url.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<LoginResponseModel> loginApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.loginUrl);
    return LoginResponseModel.fromJson(response);
  }
}