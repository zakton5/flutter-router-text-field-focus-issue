import 'package:flutter/material.dart';
import 'package:router_text_field_focus_issue/routing/router.dart';
import 'package:router_text_field_focus_issue/routing/state.dart';
import 'package:router_text_field_focus_issue/screens/forgot-password.dart';
import 'package:router_text_field_focus_issue/screens/login.dart';

class AuthRouter extends StatefulWidget {
  AuthRouter({
    Key key,
    @required this.appState,
  }) : super(key: key);

  final AppState appState;

  @override
  _AuthRouterState createState() => _AuthRouterState();
}

class _AuthRouterState extends State<AuthRouter> {
  AuthRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = AuthRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(AuthRouter oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context).backButtonDispatcher.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher.takePriority();

    return Router(routerDelegate: _routerDelegate);
  }
}

class AuthRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  AppState get appState => _appState;
  AppState _appState;
  set appState(AppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  bool _forgotPassword = false;

  AuthRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('LoginScreen'),
          child: LoginScreen(
            onForgotPasswordTapped: (email) {
              _forgotPassword = true;
              notifyListeners();
            },
          ),
        ),
        if (_forgotPassword)
          MaterialPage(
            key: ValueKey('ForgotPasswordScreen'),
            child: ForgotPasswordScreen(),
          ),
      ],
      onPopPage: (route, result) {
        _forgotPassword = false;
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    assert(false);
  }
}
