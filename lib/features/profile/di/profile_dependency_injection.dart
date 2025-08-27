import 'package:oxytocin/features/profile/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_edit_cubit.dart';

class ProfileDependencyInjection {
  static ProfileCubit getProfileCubit() {
    final dataSource = ProfileDataSourceImpl();
    final repository = ProfileRepository(dataSource);
    return ProfileCubit(repository);
  }

  static ProfileEditCubit getProfileEditCubit() {
    final dataSource = ProfileDataSourceImpl();
    final repository = ProfileRepository(dataSource);
    return ProfileEditCubit(repository);
  }

  static ProfileRepository getProfileRepository() {
    final dataSource = ProfileDataSourceImpl();
    return ProfileRepository(dataSource);
  }
}
