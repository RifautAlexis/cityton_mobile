import 'package:cityton_mobile/screens/admin/challenge/add/addChallenge.dart';
import 'package:cityton_mobile/screens/admin/challenge/adminChallenge.dart';
import 'package:cityton_mobile/screens/admin/challenge/edit/editChallenge.dart';
import 'package:cityton_mobile/screens/home/home.dart';
import 'package:cityton_mobile/screens/login/login.dart';
import 'package:cityton_mobile/screens/profile/subScreens/change_password.dart';
import 'package:cityton_mobile/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:cityton_mobile/screens/door/door.dart';
import 'package:cityton_mobile/screens/threads_list.dart';
import 'package:cityton_mobile/screens/chat/chat.dart';
import 'package:cityton_mobile/screens/profile/profile.dart';

final routes = <String, WidgetBuilder>{
  '/login':           (BuildContext context) => Login(),
  '/signup':           (BuildContext context) => Signup(),
  '/home':           (BuildContext context) => Home(),
  '/threadsList':     (BuildContext context) => ThreadsList(),
  '/chat':             (BuildContext context) => Chat(),
  '/profile':          (BuildContext context) => Profile(arguments: ModalRoute.of(context).settings.arguments),
  '/changePassword':  (BuildContext context) => ChangePassword(),
  '/admin/challenge': (BuildContext context) => AdminChallenge(),
  '/admin/challenge/add': (BuildContext context) => AddChallenge(),
  '/admin/challenge/edit': (BuildContext context) => EditChallenge(arguments: ModalRoute.of(context).settings.arguments),
  '/' :               (BuildContext context) => Door(),
};