import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/src/model/login_model/home_model.dart';
import 'package:hr_app/src/theme/app_theme.dart';
import 'package:hr_app/src/ui/main_screen/feedback/feedback_screen.dart';
import 'package:hr_app/src/ui/main_screen/holidays/holidays_screen.dart';
import 'package:hr_app/src/ui/main_screen/home/home_screen.dart';
import 'package:hr_app/src/ui/main_screen/my_leave/my_leave_screen.dart';
import 'package:hr_app/src/ui/main_screen/notice/notice_screen.dart';
import 'package:hr_app/src/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _controller = PageController(initialPage: 2);
  int currentIndex = 2;

  List<String> appTxt = [
    'Notice',
    'My Leaves',
    'Home',
    'Feedback',
    'Govt. Holidays',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 1,
        title: Center(
          child: Text(
            appTxt[currentIndex],
            textAlign: TextAlign.center,
            style: Utils.style(20, 28, Colors.black, FontWeight.w500),
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          NoticeScreen(),
          MyLeaveScreen(),
          HomeScreen(),
          FeedBackScreen(),
          HolidaysScreen(),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 2,
        top: -16,
        style: TabStyle.flip,
        backgroundColor: Colors.white,
        color: AppTheme.grey,
        activeColor: Colors.blue,
        curve: Curves.easeInOut,
        elevation: 1,
        items: const [
          TabItem(icon: Icons.notifications, title: "Notice"),
          TabItem(icon: Icons.sync_disabled, title: "My Leave"),
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.message, title: "Feedback"),
          TabItem(icon: CupertinoIcons.person_3_fill, title: "Holidays"),
        ],
        onTap: (tap) {
          setState(() {
            currentIndex = tap;
            _controller.jumpToPage(tap);
          });
        },
      ),
    );
  }
}
