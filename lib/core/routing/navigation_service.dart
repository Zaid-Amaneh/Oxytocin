import 'package:go_router/go_router.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  NavigationService._internal();

  late GoRouter _router;

  void setRouter(GoRouter router) => _router = router;

  void goToNamed(String name) => _router.goNamed(name);
  void pushToNamed(String name) => _router.pushNamed(name);
  void goToNamedWithParams(
    String name, {
    required Map<String, String> queryParams,
  }) {
    _router.goNamed(name, queryParameters: queryParams);
  }

  void pushToNamedWithParams(
    String name, {
    required Map<String, String> queryParams,
  }) {
    _router.pushNamed(name, queryParameters: queryParams);
  }

  void goBack() => _router.pop();
}
