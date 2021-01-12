import 'package:flutter/material.dart';
import 'package:router_text_field_focus_issue/routing/auth-router.dart';
import 'package:router_text_field_focus_issue/routing/main-router.dart';
import 'package:router_text_field_focus_issue/routing/state.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isEmpty) {
      return LoginPath();
    }

    switch (uri.pathSegments.first) {
      case 'login':
        return LoginPath();
      case 'forgot-password':
        return ForgotPasswordPath();
      case 'home':
        return HomePath();
      default:
        return LoginPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath configuration) {
    if (configuration is LoginPath) {
      return RouteInformation(location: '/login');
    } else if (configuration is ForgotPasswordPath) {
      return RouteInformation(location: '/forgot-password');
    } else if (configuration is HomePath) {
      return RouteInformation(location: '/home');
    }
    return null;
  }
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppState appState = AppState();

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  AppRoutePath get currentConfiguration {
    if (!appState.isLoggedIn) {
      return LoginPath();
    } else {
      return HomePath();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (!appState.isLoggedIn)
          MaterialPage(
            key: ValueKey('AuthRouter'),
            child: AuthRouter(appState: appState),
          )
        else
          MaterialPage(
            key: ValueKey('MainRouter'),
            child: MainRouter(appState: appState),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    if (path is LoginPath) {
      appState.isLoggedIn = false;
    } else if (path is ForgotPasswordPath) {
      appState.isLoggedIn = false;
    } else if (path is HomePath) {
      appState.isLoggedIn = true;
    }
  }
}

// Routes
abstract class AppRoutePath {}

class LoginPath extends AppRoutePath {}

class ForgotPasswordPath extends AppRoutePath {}

class HomePath extends AppRoutePath {}
