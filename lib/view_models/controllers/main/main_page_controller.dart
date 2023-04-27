
import 'package:get/get.dart';
import 'package:club_house/data/response/status.dart';
import 'package:club_house/repository/home/home_repository.dart';
import '../../../models/home/user_list_model.dart';

class MainPageController extends GetxController {
   var _api = HomeRepository();

   RxString error = ''.obs;
   final rxRequestStatus = Status.LOADING.obs;
   final userList = UserListModel().obs;

   void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
   void setUserList(UserListModel _value) => userList.value = _value;
   void setError(String _value) => error.value = _value;

   void userListApi() {
     _api.userListApi().then((value){
       setRxRequestStatus(Status.COMPLETED);
       setUserList(value);
     }).onError((error, stackTrace){
       setError(error.toString());
       setRxRequestStatus(Status.ERROR);
     });
   }
   void refreshUserListApi() {
     setRxRequestStatus(Status.LOADING);
     _api.userListApi().then((value){
       setRxRequestStatus(Status.COMPLETED);
       setUserList(value);
     }).onError((error, stackTrace){
       setError(error.toString());
       setRxRequestStatus(Status.ERROR);
     });
   }
}