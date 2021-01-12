import 'package:flutter/material.dart';
import 'package:router_text_field_focus_issue/routing/router.dart';
import 'package:router_text_field_focus_issue/routing/state.dart';
import 'package:router_text_field_focus_issue/screens/home.dart';

class MainRouter extends StatefulWidget {
  MainRouter({
    Key key,
    @required this.appState,
  }) : super(key: key);

  final AppState appState;

  @override
  _MainRouterState createState() => _MainRouterState();
}

class _MainRouterState extends State<MainRouter> {
  MainRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = MainRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(MainRouter oldWidget) {
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

class MainRouterDelegate extends RouterDelegate<AppRoutePath>
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

  MainRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('HomeScreen'),
          child: HomeScreen()
        ),
      ],
      onPopPage: (route, result) {
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    assert(false);
  }
}
