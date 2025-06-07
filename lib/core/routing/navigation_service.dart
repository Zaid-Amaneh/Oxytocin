import 'package:go_router/go_router.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  NavigationService._internal();

  late GoRouter _router;

  void setRouter(GoRouter router) => _router = router;

  void goToNamed(String name) => _router.goNamed(name);
  void pushToNamed(String name) => _router.pushNamed(name);
  void goBack() => _router.pop();
}
