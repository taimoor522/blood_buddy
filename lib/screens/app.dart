import 'package:blood_buddy/constants.dart';
import 'package:blood_buddy/screens/home.dart';
import 'package:blood_buddy/screens/requests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  var _auth = FirebaseAuth.instance;

  late User _loggedinUser;

  late TabController tabController;

  bool loading = true;

  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedinUser = user;
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GFTabBarView(controller: tabController, children: <Widget>[
        Home(),
        Requests(),
      ]),
      bottomNavigationBar: GFTabBar(
        length: 2,
        controller: tabController,
        tabBarColor: Colors.grey.shade300,
        indicatorColor: myRed,
        indicatorWeight: 4,
        tabBarHeight: 65,
        tabs: [
          Tab(
            icon: ImageIcon(
              AssetImage("assets/images/h.png"),
              color: myRed,
              size: 30,
            ),
            child: const Text(
              'Home',
              style: TextStyle(color: myRed, fontWeight: FontWeight.bold),
            ),
          ),
          Tab(
            icon: ImageIcon(
              AssetImage("assets/images/r.png"),
              color: myRed,
              size: 30,
            ),
            child: const Text(
              'Your Request',
              style: TextStyle(color: myRed, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
