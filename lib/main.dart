import 'package:flutter/material.dart';
import 'package:router_text_field_focus_issue/routing/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Router Text Field Focus Issue',
        routeInformationParser: _routeInformationParser,
        routerDelegate: _routerDelegate,
      );
  }
}
