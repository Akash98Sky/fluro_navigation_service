import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import '../models/route_details.dart';

part 'navigation_service_impl.dart';

typedef Widget RouteFunc(String route, Map<String, List<String>> params);

class NavigationService extends _NavigationServiceImpl {
  static NavigationService _instance;

  static NavigationService get instance =>
      _instance = _instance ?? NavigationService();

  final GlobalKey<NavigatorState> navigatorKey;

  RouteUpdateNotifier get routeUpdateNotifier => _routeDetails;

  NavigationService()
      : this.navigatorKey = GlobalKey<NavigatorState>(),
        super(
          Router(),
          RouteDetails(),
        );

  NavigationServiceWithContext of(BuildContext context) =>
      NavigationServiceWithContext(context, this);

  void defineRoutes(
    List<String> routeNames, {
    @required RouteFunc routeScreen,
    HandlerType handlerType = HandlerType.route,
    TransitionType transitionType,
  }) =>
      routeNames.forEach(
        (path) => _router.define(
          path,
          handler: Handler(
            type: handlerType,
            handlerFunc: (_, params) => routeScreen?.call(path, params),
          ),
          transitionType: transitionType,
        ),
      );

  Route<dynamic> generator(RouteSettings routeSettings) {
    _routeDetails.pushRoute(routeSettings.name);

    return _router.generator(routeSettings);
  }

  /// Prints the route tree so you can analyze it.
  void printRouteTree() => _router.printTree();

  @override
  NavigatorState get _currentState {
    assert(navigatorKey.currentState != null,
        'Pass navigatorKey to MaterialApp or use navigatorService.of(context)');
    return navigatorKey.currentState;
  }

  @override
  BuildContext get _currentContext {
    assert(navigatorKey.currentContext != null,
        'Pass navigatorKey to MaterialApp or use navigatorService.of(context)');
    return navigatorKey.currentContext;
  }
}

class NavigationServiceWithContext extends _NavigationServiceImpl {
  final BuildContext _context;

  NavigationServiceWithContext(
    this._context,
    NavigationService service,
  )   : assert(_context != null, "Context can't be  null !"),
        super(service._router, service._routeDetails);

  @override
  NavigatorState get _currentState => Navigator.of(_context);

  @override
  BuildContext get _currentContext => _context;
}
