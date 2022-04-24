import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/src/bloc/notice_bloc.dart';
import 'package:hr_app/src/model/notice_model.dart';
import 'package:hr_app/src/theme/app_theme.dart';
import 'package:hr_app/src/utils/utils.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  void initState() {
    super.initState();
    noticeBloc.getAllNotice();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.windowHeight(context);
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: StreamBuilder(
        stream: noticeBloc.allNotice,
        builder: (context, AsyncSnapshot<NoticeModel> snapshot) {
          if (snapshot.hasData) {
            NoticeModel data = snapshot.data!;
            return Column(
              children: [
                SizedBox(
                  height: 16 * h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.noticeData.length,
                    itemBuilder: (_, index) {
                      return noticeWidget(
                          context,
                          data.noticeData[index].title,
                          data.noticeData[index].subject,
                          data.noticeData[index].entryDate);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget noticeWidget(
    BuildContext context, String title, String name, DateTime dateTima) {
  double h = Utils.windowHeight(context);
  double w = Utils.windowWidth(context);
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: Utils.style(18 * h, 24, AppTheme.black, FontWeight.normal),
            ),
            content: Text(
              name,
              maxLines: 3,
              style: Utils.style(
                  16 * h, 24, AppTheme.black.withOpacity(0.5), FontWeight.w300),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8 * h),
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "OK",
                      style: Utils.style(
                          18 * h, 24, AppTheme.blue, FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 16 * h, left: 16 * w, right: 8 * w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8 * h),
        color: AppTheme.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Utils.style(18 * h, 22, AppTheme.black, FontWeight.w500),
          ),
          Text(
            getDate(dateTima.month) +
                " " +
                dateTima.day.toString() +
                " " +
                dateTima.year.toString(),
            style: Utils.style(14 * h, 18, AppTheme.grey, FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.only(right: 8 * w),
            child: Text(
              name,
              style: Utils.style(
                  16 * h, 24, AppTheme.black.withOpacity(0.5), FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 16 * h,
          ),
          Container(
            height: 2,
            color: AppTheme.grey.withOpacity(0.5),
          )
        ],
      ),
    ),
  );
}
