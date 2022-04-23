import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hr_app/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  String design = "";
  String photo = "";
  Uint8List? bytes;

  @override
  void initState() {
    get();
    super.initState();
  }

  get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userName = preferences.getString("username") ?? "JM";
    design = preferences.getString("design") ?? "FD";
    photo = preferences.getString("photo") ?? "";
    var list = <int>[];
    for (var rune in photo.runes) {
      if (rune >= 0x10000) {
        rune -= 0x10000;
        int firstWord = (rune >> 10) + 0xD800;
        list.add(firstWord >> 8);
        list.add(firstWord & 0xFF);
        int secondWord = (rune & 0x3FF) + 0xDC00;
        list.add(secondWord >> 8);
        list.add(secondWord & 0xFF);
      } else {
        list.add(rune >> 8);
        list.add(rune & 0xFF);
      }
    }
    bytes = Uint8List.fromList(list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.windowHeight(context);
    double w = Utils.windowWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 24 * h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16 * h),
            margin: EdgeInsets.symmetric(horizontal: 16 * w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16 * h),
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60 * h,
                      width: 60 * w,
                      color: Colors.transparent,
                      child: photo == ""
                          ? Image.asset(
                              'assets/images/defoult_img.png',
                            )
                          : Image.memory(
                              base64Decode(photo),
                            ),
                    ),
                    SizedBox(
                      width: 16 * w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 230 * h,
                          child: Text(
                            userName,
                            textAlign: TextAlign.start,
                            style: Utils.style(
                                20 * h, 24, Colors.white, FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 230 * h,
                          child: Text(
                            design,
                            textAlign: TextAlign.start,
                            style: Utils.style(
                                16 * h, 20, Colors.white, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          margin: const EdgeInsets.only(left: 48),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/images/defoult_img.png',
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 45,
                          margin: const EdgeInsets.only(left: 24),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/images/defoult_img.png',
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 45,
                          margin: const EdgeInsets.only(left: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/images/defoult_img.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      '6466 Collega in Brain',
                      style:
                          Utils.style(16, 20, Colors.white, FontWeight.normal),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
