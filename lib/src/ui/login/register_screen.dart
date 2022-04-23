import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/src/api/repository.dart';
import 'package:hr_app/src/jsons/home_jsons.dart';
import 'package:hr_app/src/model/http_result.dart';
import 'package:hr_app/src/theme/app_theme.dart';
import 'package:hr_app/src/ui/main_screen/main_screen.dart';
import 'package:hr_app/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/login_model/home_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Repository _repository = Repository();
  bool passCheck = false;
  bool idIcon = false;
  bool passIcon = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.windowHeight(context);
    double w = Utils.windowWidth(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 72,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24 * h),
                bottomRight: Radius.circular(24 * h),
              ),
            ),
            child: Center(
              child: Text(
                'HR Matters',
                style: Utils.style(24 * h, 28, AppTheme.white, FontWeight.w400),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 180 * h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16 * w),
                  child: Text(
                    "LOGIN",
                    style: Utils.style(32, 36, Colors.blue, FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 60 * h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 0 * w, vertical: 4 * h),
                  margin: EdgeInsets.symmetric(horizontal: 16 * w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Colors.blue,
                    ),
                  ),
                  child: TextFormField(
                    controller: _idController,
                    onTap: () {
                      setState(() {
                        idIcon = true;
                        passIcon = false;
                      });
                    },
                    style: Utils.style(16, 20, Colors.black, FontWeight.normal),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Id....",
                      hintStyle: Utils.style(16, 20,
                          Colors.black.withOpacity(0.3), FontWeight.normal),
                      prefixIcon: Icon(
                        Icons.perm_identity,
                        color: idIcon ? AppTheme.blue : AppTheme.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16 * h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 0 * w, vertical: 4 * h),
                  margin: EdgeInsets.symmetric(horizontal: 16 * w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Colors.blue,
                    ),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    onTap: () {
                      setState(() {
                        idIcon = false;
                        passIcon = true;
                      });
                    },
                    obscureText: passCheck,
                    keyboardType: TextInputType.visiblePassword,
                    style: Utils.style(16, 20, Colors.black, FontWeight.normal),
                    enableInteractiveSelection: passCheck,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: Utils.style(16, 20,
                          Colors.black.withOpacity(0.3), FontWeight.normal),
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: passIcon ? AppTheme.blue : AppTheme.grey,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          passCheck = !passCheck;
                        }),
                        child: Container(
                          height: 24 * h,
                          width: 24 * w,
                          color: Colors.transparent,
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            color: passCheck ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 72 * h,
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    //
                    // HttpResult result = await _repository.loginApi(
                    //     _idController.text, _passwordController.text);

                    // if (result.isSuccess) {
                    HomeModel data = HomeModel.fromJson(
                      homeJson,
                    );
                    print(data);
                    print(data.userData.userId);
                    print(data.userData.photo);
                    prefs.setString("userid", data.userData.userId);
                    prefs.setString("username", data.userData.userName);
                    prefs.setString("design", data.userData.designation);
                    prefs.setString("photo", data.userData.photo);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                    // } else {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return CupertinoAlertDialog(
                    //         title: const Text("Error"),
                    //         content: Text(result.result.toString()),
                    //         actions: [
                    //           GestureDetector(
                    //             onTap: () => Navigator.pop(context),
                    //             child: const Center(
                    //               child: Text(
                    //                 'Ok',
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       );
                    //     },
                    //   );
                    // }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0 * w, vertical: 8 * h),
                    margin: EdgeInsets.symmetric(horizontal: 16 * w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style:
                            Utils.style(24, 28, Colors.white, FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 56 * h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
