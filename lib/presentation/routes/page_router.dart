import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/pages/pages.dart';
import 'package:fojb_election/presentation/routes/routes.dart';

class PageRouter {
  final RouteObserver<PageRoute> routeObserver;

  PageRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PagePath.splash:
        return _buildRoute(settings, SplashPage());
      case PagePath.login:
        return _buildRoute(settings, LoginPage());
      case PagePath.home:
        return _buildRoute(settings, HomePage());
      case PagePath.detail:
        return _buildRoute(settings, DetailPage());
      case PagePath.vote:
        return _buildRoute(
            settings, VotePage());
      case PagePath.afterVote:
        return _buildRoute(settings, AfterVotePage());
      default:
        return _errorRoute();
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => page,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
