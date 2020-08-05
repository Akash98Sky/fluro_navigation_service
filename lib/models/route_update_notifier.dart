part of 'route_details.dart';

abstract class RouteUpdateNotifier extends ChangeNotifier {
  final List<String> _routeStack;

  RouteUpdateNotifier() : this._routeStack = List<String>();

  String get currentRoute => _routeStack.isNotEmpty ? _routeStack.last : null;

  /// returns true currentRoute is the only pushed route
  bool get hasOneRoute => _routeStack.length == 1;
}
