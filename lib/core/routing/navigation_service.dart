import 'package:go_router/go_router.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  NavigationService._internal();

  late GoRouter _router;

  void setRouter(GoRouter router) => _router = router;

  void goToNamed(String name) => _router.goNamed(name);
  void pushToNamed(String name) => _router.pushNamed(name);
  void pushReplacementNamed(String name) => _router.pushReplacementNamed(name);
  void goToNamedWithParams(
    String name, {
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    Object? extra,
  }) {
    _router.goNamed(
      name,
      queryParameters: queryParams ?? {},
      pathParameters: pathParams ?? {},
      extra: extra,
    );
  }

  void pushToNamedWithParams(
    String name, {
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    Object? extra,
  }) {
    _router.pushNamed(
      name,
      queryParameters: queryParams ?? {},
      pathParameters: pathParams ?? {},
      extra: extra,
    );
  }

  void pushReplacementWithParams(
    String name, {
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    Object? extra,
  }) {
    _router.pushReplacementNamed(
      name,
      queryParameters: queryParams ?? {},
      pathParameters: pathParams ?? {},
      extra: extra,
    );
  }

  void goBack() => _router.pop();
}
