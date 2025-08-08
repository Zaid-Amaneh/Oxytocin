import 'package:oxytocin/features/profile/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:oxytocin/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:oxytocin/features/profile/domain/usecases/logout_usecase.dart';
import 'package:oxytocin/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileDependencyInjection {
  static ProfileCubit getProfileCubit() {
    // Create dependencies
    final dataSource = ProfileDataSourceImpl();
    final repository = ProfileRepositoryImpl(dataSource);
    final getUserProfileUseCase = GetUserProfileUseCase(repository);
    final updateUserProfileUseCase = UpdateUserProfileUseCase(repository);
    final logoutUseCase = LogoutUseCase(repository);

    // Create and return cubit
    return ProfileCubit(
      getUserProfileUseCase: getUserProfileUseCase,
      updateUserProfileUseCase: updateUserProfileUseCase,
      logoutUseCase: logoutUseCase,
    );
  }
}
