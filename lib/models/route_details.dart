import 'package:flutter/foundation.dart';

part 'route_update_notifier.dart';

class RouteDetails extends RouteUpdateNotifier {
  void clearStack() => _routeStack.clear();

  void pushRoute(String routeName) {
    _routeStack.add(routeName);

    notifyListeners();
  }

  void popRoute() {
    _routeStack.removeLast();

    notifyListeners();
  }
}
