import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/ui/screens/details_screen.dart';
import 'package:foxfund_alpha/ui/screens/layout_screen.dart';
import 'package:foxfund_alpha/ui/screens/search_screen.dart';
import 'package:foxfund_alpha/ui/screens/see_more_screen.dart';
import 'package:foxfund_alpha/ui/screens/splash_screen.dart';

import 'constants/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView:
      return _getPageRoute(
          routeName: settings.name, view: const SplashScreen());
    case MainLayoutView:
      return _getPageRoute(
          routeName: settings.name,
          args: settings.arguments,
          view: const LayoutScreen());
    case NewsDetailsView:
      return _getPageRoute(
          routeName: settings.name,
          args: settings.arguments,
          view: const DetailsScreen());
    case SeeMoreView:
      return _getPageRoute(
          routeName: settings.name,
          args: settings.arguments,
          view: const SeeMoreScreen());
    case SearchView:
      return _getPageRoute(
          routeName: settings.name,
          args: settings.arguments,
          view: const SearchScreen());
    default:
      return CupertinoPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute<dynamic> _getPageRoute({String routeName, Widget view, Object args}) {
  return CupertinoPageRoute<dynamic>(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view);
}
