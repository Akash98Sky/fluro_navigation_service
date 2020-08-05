import 'package:flutter_test/flutter_test.dart';

import 'package:fluro_navigation_service/fluro_navigation_service.dart';

void main() {
  test('adds one to input values', () {
    final navigationService = NavigationService.instance;
    navigationService.printRouteTree();
  });
}
