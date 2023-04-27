import 'dart:async';
import 'package:club_house/view_models/controllers/otp/verification_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/otp_input.dart';
import '../../res/dimensions.dart';
import '../../view_models/controllers/otp/otp_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  static const _timerDuration = 30;
  final StreamController _timerStream = StreamController<int>();
  late int timerCounter;
  late Timer _resendCodeTimer;
  //OTPController controller = Get.put(OTPController());
  VerificationController controller = Get.put(VerificationController());

  // 6 text editing controllers that associate with the 6 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  String message = '';
  String user_id = '';
  String errorMsg = '';

  @override
  void initState() {
    getMsg();
    activeCounter();
    super.initState();
  }

  @override
  void dispose() {
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    _fieldFive.dispose();
    _fieldSix.dispose();
    _timerStream.close();
    _resendCodeTimer.cancel();

    super.dispose();
  }

  activeCounter() {
    _resendCodeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
          if (_timerDuration - timer.tick > 0) {
            _timerStream.sink.add(_timerDuration - timer.tick);
          } else {
            _timerStream.sink.add(0);
            _resendCodeTimer.cancel();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.greyColor,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OTPInput(controller: _fieldOne, autoFocus: true),
                          const SizedBox(
                            width: 4,
                          ), // auto focus
                          OTPInput(controller: _fieldTwo, autoFocus: false),
                          const SizedBox(
                            width: 4,
                          ),
                          OTPInput(controller: _fieldThree, autoFocus: false),
                          const SizedBox(
                            width: 4,
                          ),
                          OTPInput(controller: _fieldFour, autoFocus: false),
                          const SizedBox(
                            width: 4,
                          ),
                          OTPInput(controller: _fieldFive, autoFocus: false),
                          const SizedBox(
                            width: 4,
                          ),
                          OTPInput(controller: _fieldSix, autoFocus: false),
                        ],
                      ),
                      const SizedBox(height: 22,),
                      Obx(() => controller.isLoading.value ? const SizedBox(height: 40, width: 40, child: CircularProgressIndicator(color: AppColor.primaryColor,),
                      ):
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_fieldOne.text.isNotEmpty &&
                                  _fieldTwo.text.isNotEmpty &&
                                  _fieldThree.text.isNotEmpty &&
                                  _fieldFour.text.isNotEmpty &&
                                  _fieldFive.text.isNotEmpty &&
                                  _fieldSix.text.isNotEmpty) {
                                setState(() {
                                  errorMsg.toString();
                                  //controller.userId = user_id.toString();
                                  controller.vCode.text = _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text + _fieldFive.text +
                                      _fieldSix.text;
                                });
                                controller.verificationApi();
                              } else {
                                Get.snackbar('Empty Field', "please enter all Fields",backgroundColor: AppColor.primaryColor, colorText: AppColor.whiteColor,);
                              }

                              // controller.v_code.text = _otp.toString();
                            },
                            style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    AppColor.primaryColor),
                                foregroundColor:
                                const MaterialStatePropertyAll(AppColor.whiteColor),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            25)))),
                            child: const Padding(
                              padding: EdgeInsets.all(14),
                              child: Text('Verify'),
                            )),
                      )
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(() => Text(controller.controllerText.value.toString() /*style: getBoldTextStyle(
                                  fontSize: 14, color: AppColor.redColor)*/,
                      ),
                      ),
                      //deisplay the entered otp
                      // Text(_otp ?? "Enter Text", style: TextStyle(fontSize: 30),),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text("Didn't your receive any code?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColor.whiteColor),
                  /*style: getBoldTextStyle(
                      fontSize: AppSize.s14, color: Colors.black38),*/
                ),
                const SizedBox(
                  height: 18,
                ),
                StreamBuilder(
                  stream: _timerStream.stream,
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    return SizedBox(
                      //width: 300,
                      child: TextButton(
                        //textColor: Theme.of(context).accentColor,
                        onPressed: snapshot.data == 0 ? () {
                          controller.resendOtpApi();
                          _timerStream.sink.add(30);
                          activeCounter();} : null,
                        //textColor: Theme.of(context).accentColor,
                        child: Center(
                            child: snapshot.data == 0 ? Text("Resend Code",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                              /*style: getBoldTextStyle(
                                    fontSize: AppSize.s18,
                                    color: AppColor.primaryColor),*/
                            )
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Resend code after ${snapshot.hasData ? snapshot.data.toString() : 30} seconds '),
                              ],
                            )),
                      ),
                    );
                  },
                )
              ],
            )),
      ),
    );
  }

  Future getMsg() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      message = _prefs.getString("message").toString();
      user_id = _prefs.getString('user_id').toString();
      errorMsg = _prefs.getString("errorMsg").toString();
    });
  }

  _textfieldOTP({required bool first, last}) {
    String texteEntered = "";
    return Expanded(
      child: Container(
        height: 70,
        child: AspectRatio(
            aspectRatio: 0.7,
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  texteEntered = value;
                  if (value.length == 1 && last == false) {
                    FocusScope.of(context).nextFocus();
                    texteEntered = value.toString();
                  }
                  if (value.length == 0 && first == false) {
                    FocusScope.of(context).previousFocus();
                  }
                });
                print("texteEntered textEntered $texteEntered");
                print("texteEntered textEntered $texteEntered");
              },
              showCursor: false,
              readOnly: false,
              textAlign: TextAlign.center,
              /*style: getBoldTextStyle(
                  fontSize: 25, color: AppColor.blackColor),*/
              keyboardType: TextInputType.text,
              maxLength: 1,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 2, color: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            )),
      ),
    );
  }
}
