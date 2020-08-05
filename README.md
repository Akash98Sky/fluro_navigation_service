# fluro_navigation_service

An advanced naviration service implementation using [fluro](https://pub.dev/packages/fluro).

## Getting Started

### Installation
```
dependencies:
  ...
  fluro_navigation_service: ^0.0.1
```

### Using this package

Initializing NavigationService
``` dart
import 'package:fluro_navigation_service/fluro_navigation_service.dart';

MaterialApp(
	title: 'App',
	theme: ThemeData(
		primarySwatch: Colors.blue,
		visualDensity: VisualDensity.adaptivePlatformDensity,
	),
	onGenerateRoute: NavigationService.instance.generator,
	navigatorKey: NavigationService.instance.navigatorKey,
);
```

Defining routes
``` dart
NavigationService.instance.defineRoutes(
    ['/home', '/search', '/profile'],
    routeScreen: (route, params) {
      switch (route) {
        case '/home':
          return HomeScreen();
        case '/search':
          return SearchScreen();
        case '/profile':
          return ProfileScreen();
        default:
          return HomeScreen();
      }
    },
    transitionType: TransitionType.fadeIn,
  );
```

Using NavigationService to navigate
``` dart
// Navigate to next page
NavigationService.instance.navigateTo(routeName, replace: false);

// Go back to previous page
NavigationService.instance.goBack();
```