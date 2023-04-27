import 'package:club_house/models/clubs/join_clubs/join_clubs_response_model.dart';

import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class JoinClubResponseRepository{
  final _apiService = NetworkApiServices();

  Future<JoinClubResponseModel> joinClubResponseApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.joinClubsUrl);
    print('join club response $response');
    return JoinClubResponseModel.fromJson(response);
  }
}