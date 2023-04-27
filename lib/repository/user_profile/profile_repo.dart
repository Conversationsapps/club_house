import 'package:club_house/models/location/AddLocationModel.dart';
import 'package:club_house/models/user_profile/delete_user_response.dart';
import 'package:club_house/models/user_profile/update_user_profile_response_model.dart';

import '../../data/network/network_api_services.dart';
import '../../models/user_profile/get_user_profile_response.dart';
import '../../res/app_url/app_url.dart';

class ProfileRepository{
  final _apiService = NetworkApiServices();

  Future<AddLocationResponseModel> addUserLocationApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.addUserLocationUrl);
    return AddLocationResponseModel.fromJson(response);
  }

  Future<UpdateUserProfileResponseModel> updateUserProfileApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.updateProfileUrl);
    print('printing response from UpdateUserProfileResponseModel  $response');
    return UpdateUserProfileResponseModel.fromJson(response);
  }

  // Future<GetUserResponseModel> getUserProfileApi(var userId) async{
  //   dynamic response = await _apiService.getApi(AppUrl.getUserProfileUrl+userId);
  //   print("getUserProfileApi Response $response");
  //   return GetUserResponseModel.fromJson(response);
  // }

  Future<dynamic> getUserProfileApi2(var userId) async{
    dynamic response = await _apiService.getApi(AppUrl.getUserProfileUrl+userId);
    print("getUserProfileApi Response $response");
    return response;
  }

  Future<DeleteUserResponseModel> deleteUserProfileApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.deleteUserProfileUrl);
    return DeleteUserResponseModel.fromJson(response);
  }
}
