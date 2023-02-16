import 'package:flutter/material.dart';

import '../../ui/pages/home_page/home_page.dart';
import '../../ui/pages/login_page/login_page.dart';
import '../../ui/pages/tflite_test/test_page.dart';

//Stores screen route names. e.g.) RouteNames.home.path
enum RouteNames {
  home('/home'),
  login('/login'),
  test('/test');
  
  const RouteNames(this.path);    
  final String path;
}

Map<String, Widget Function(BuildContext)> mainRoutes = {
  RouteNames.home.path: (context) => HomePage(),
  RouteNames.login.path: (context) => LoginPage(),
  RouteNames.test.path: (context) => TestPage(),
};