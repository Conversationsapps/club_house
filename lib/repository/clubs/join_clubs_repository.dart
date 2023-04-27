import 'package:club_house/models/clubs/join_clubs/join_club_models.dart';

import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class JoinClubRepository{
  final _apiService = NetworkApiServices();

  Future<JoinClubModel> joinClubApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.joinClubsUrl);
    return JoinClubModel.fromJson(response);
  }
}