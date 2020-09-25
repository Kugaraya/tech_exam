import 'package:sailor/sailor.dart';
import 'package:tech_exam/views/home/home_view.dart';

import '../../core/base/base_service.dart';
import 'package:flutter/material.dart';

class NavigatorService extends BaseService {
  static final sailor = Sailor();
  final GlobalKey<NavigatorState> navigatorKey = sailor.navigatorKey;
  final generator = sailor.generator();

  void createRoutes() {
    sailor.addRoutes([
      // Just for good measure, we won't explicitly navigate to the InitialPage.
      SailorRoute(
        name: "/",
        builder: (context, args, params) {
          return HomeView();
        },
      ),
    ]);
  }

  void navigateTo<T>(String pageRoute, {
    NavigationType navigationType,
    Map params,
    Duration transitionDuration,
    List<SailorTransition> transition,
    Curve transitionCurve
  }) async {
    log.i('navigateTo: pageRoute - $pageRoute');

    sailor.navigate(
      pageRoute,
      params: params != null ? params : null,
      transitionDuration: transitionDuration != null ? transitionDuration : Duration(milliseconds: 600),
      navigationType: navigationType != null ? navigationType : NavigationType.push,
      transitions: transition != null ? transition : [SailorTransition.fade_in, SailorTransition.slide_from_bottom],
      transitionCurve: transitionCurve != null ? transitionCurve : Curves.ease,
      removeUntilPredicate: navigationType == NavigationType.pushAndRemoveUntil ? (route) => false : null
    );
  }
}
