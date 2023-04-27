import 'package:club_house/res/colors/app_color.dart';
import 'package:club_house/view/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:club_house/utils/utils.dart';
import 'package:club_house/view_models/controllers/login/login_controller.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../res/components/input_field.dart';
import '../../res/components/round_button.dart';
import '../../res/dimensions.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('login'.tr),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text("Please enter all  fields", style: TextStyle(color: AppColor.primaryColor),),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IntlPhoneField(
              pickerDialogStyle: PickerDialogStyle(backgroundColor: AppColor.whiteColor),
              keyboardType: TextInputType.phone,
              cursorColor: AppColor.primaryColor,
              dropdownIcon: const Icon(Icons.arrow_drop_down, color: AppColor.primaryColor,),
              style: TextStyle(color: AppColor.primaryColor),
              decoration: InputDecoration(
                labelStyle:  TextStyle(fontSize: 18, color: AppColor.primaryColor),
                suffixIcon: Icon(Icons.check_circle, color: Colors.green,size: 30,),
                enabled: true,
                // label: Text("phone Number"),
                hintText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(30) ,
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(30) ,
                    borderSide: BorderSide(color: AppColor.primaryColor)),
              ),
              initialCountryCode: "India",
              onChanged: (phone) {
                //when phone number country code is changed
                print(phone.completeNumber); //get complete number
                print(phone.countryCode); // get country code only
                print(phone.number); // only phone number
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField(
                    controller: loginController.emailController.value,
                    hint: 'email_hint'.tr,
                    title: 'email'.tr,
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: Dimensions.getHeight * 0.04,
                  ),
                  Obx(
                    () => RoundButton(
                      width: Dimensions.getWidth,
                      height: Dimensions.getHeight * 0.06,
                      loading: loginController.isLoading.value,
                      title: 'login'.tr,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          loginController.loginApi();
                        }
                      },
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterView()));
                  }, child: Text("Don't have account? Register"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
