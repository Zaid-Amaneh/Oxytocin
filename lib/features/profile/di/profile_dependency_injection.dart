import 'package:oxytocin/features/profile/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileDependencyInjection {
  static ProfileCubit getProfileCubit() {
    final dataSource = ProfileDataSourceImpl();
    final repository = ProfileRepository(dataSource);
    return ProfileCubit(repository);
  }
}
