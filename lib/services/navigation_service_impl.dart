part of 'navigation_service.dart';

abstract class _NavigationServiceImpl {
  /// [Router] object associated with this NavigationService
  final Router fluroRouter;
  final RouteDetails _routeDetails;

  _NavigationServiceImpl(this.fluroRouter, this._routeDetails);

  NavigatorState get _currentState;

  BuildContext get _currentContext;

  /// T is the template for object to be returned here on pop and
  /// R is the template for object to be passed as replacementResult
  ///
  /// Use [replacementResult] only when [replace] is true
  Future<T> navigateTo<T extends Object, R extends Object>(
    String routeName, {
    Map<String, List<String>> queryParams,
    Object arguments,
    bool replace = false,
    R replacementResult,
  }) {
    assert(routeName != null && replace != null);

    if (queryParams != null)
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();

    if (_routeDetails.currentRoute?.compareTo(routeName) == 0) replace = true;

    if (replace) {
      _routeDetails.popRoute();

      return _currentState.pushReplacementNamed<T, R>(
        routeName,
        arguments: arguments,
        result: replacementResult,
      );
    } else
      return _currentState.pushNamed<T>(
        routeName,
        arguments: arguments,
      );
  }

  void goBack<T extends Object>([T result]) {
    _currentState.pop<T>(result);
    _routeDetails.popRoute();
  }

  /// Finds a defined [AppRoute] for the path value. If no [AppRoute] definition was found
  /// then function will return null.
  AppRouteMatch match(String path) => fluroRouter.match(path);

  ///
  RouteMatch matchRoute(String path,
          {RouteSettings routeSettings,
          TransitionType transitionType,
          Duration transitionDuration = const Duration(milliseconds: 250),
          RouteTransitionsBuilder transitionsBuilder}) =>
      fluroRouter.matchRoute(
        _currentContext,
        path,
        routeSettings: routeSettings,
        transitionType: transitionType,
        transitionDuration: transitionDuration,
        transitionsBuilder: transitionsBuilder,
      );
}
