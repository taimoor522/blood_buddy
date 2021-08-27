import 'package:blood_buddy/constants.dart';
import 'package:blood_buddy/screens/sign-up.dart';
import 'package:blood_buddy/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: GFTabBarView(
            controller: tabController,
            children: <Widget>[
              SignIn(),
              SignUp(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GFTabBar(
        indicatorColor: myRed,
        tabBarColor: Colors.white,
        length: 2,
        controller: tabController,
        tabs: [
          Tab(
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 25,
                color: myRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Tab(
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 25,
                color: myRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
