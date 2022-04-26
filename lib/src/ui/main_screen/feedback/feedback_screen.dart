import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/src/bloc/feedback_bloc.dart';
import 'package:hr_app/src/model/feedback_model/feedback_model.dart';
import 'package:hr_app/src/theme/app_theme.dart';
import 'package:hr_app/src/ui/main_screen/feedback/my_feedback_screen.dart';
import 'package:hr_app/src/utils/utils.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  void initState() {
    feedbackBloc.getFeedback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: StreamBuilder(
        stream: feedbackBloc.getAllFeedback,
        builder: (context, AsyncSnapshot<FeedbackModel> snapshot) {
          if (snapshot.hasData) {
            FeedbackModel data = snapshot.data!;
            return ListView.builder(
              itemCount: data.feedbackData.length,
              itemBuilder: (context, index) {
                var feekData = data.feedbackData;
                return ListView.builder(
                  itemCount: feekData[index].feedbackDetails.length,
                  itemBuilder: (context, index1) {
                    return feedbackWidget(
                      context,
                      feekData[index].feedbackDetails[index1].message,
                      feekData[index].feedbackDetails[index1].message,
                      feekData[index].feedbackDetails[index1].entryDate,
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const MyFeedbackScreen(),
            ),
          );
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppTheme.blue,
          ),
          child: Center(
            child: Text(
              "+",
              style: Utils.style(36, 40, AppTheme.white, FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}

Widget feedbackWidget(
    BuildContext context, String title, String name, DateTime dateTima) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(name),
            content: Text(
              title,
              maxLines: 3,
              style: Utils.style(
                  18, 24, Colors.black.withOpacity(0.5), FontWeight.normal),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      "OK",
                      style: Utils.style(18, 24, Colors.blue, FontWeight.bold),
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
      padding: const EdgeInsets.only(top: 16, left: 16, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Utils.style(18, 22, Colors.black, FontWeight.w500),
          ),
          Text(
            getDate(dateTima.month) +
                " " +
                dateTima.day.toString() +
                " " +
                dateTima.year.toString(),
            style: Utils.style(14, 18, Colors.grey, FontWeight.bold),
          ),
          Text(
            title,
            style: Utils.style(
                18, 24, Colors.black.withOpacity(0.5), FontWeight.normal),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    ),
  );
}
