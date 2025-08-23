import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:oxytocin/features/profile/presentation/view/profile_view.dart';
import 'package:oxytocin/features/profile/di/profile_dependency_injection.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';

class ProfileWithNavView extends StatefulWidget {
  const ProfileWithNavView({super.key});

  @override
  State<ProfileWithNavView> createState() => _ProfileWithNavViewState();
}

class _ProfileWithNavViewState extends State<ProfileWithNavView> {
  int _currentIndex = 3;

  void _onNavItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pop();
    } else if (index == 1) {
      Navigator.of(context).pop();
      NavigationService().pushToNamed(RouteNames.searchDoctorsView);
    } else if (index == 2) {
      Navigator.of(context).pop();
      NavigationService().pushToNamed(RouteNames.medicalAppointmentsView);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ProfileDependencyInjection.getProfileCubit(),
        child: const ProfileView(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}
