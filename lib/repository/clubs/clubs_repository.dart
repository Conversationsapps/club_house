import 'package:club_house/data/network/network_api_services.dart';

import '../../models/clubs/dumm_clubs/dummyclub_list1_model.dart';
import '../../res/app_url/app_url.dart';

class ClubRepository{
  final _apiService = NetworkApiServices();

  Future<DummyDataResponse > club1List()async{
    dynamic response = await _apiService.getApi(AppUrl.dummyClubs);
    return DummyDataResponse.fromJson(response);

  }
}