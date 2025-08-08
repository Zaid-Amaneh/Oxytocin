import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/profile/di/profile_dependency_injection.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:oxytocin/features/profile/presentation/view/profile_view.dart';

class ProfileTestView extends StatelessWidget {
  const ProfileTestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDependencyInjection.getProfileCubit(),
      child: const ProfileView(),
    );
  }
}
