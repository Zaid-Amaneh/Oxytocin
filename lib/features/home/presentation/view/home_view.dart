import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/home/presentation/widgets/doctor_card.dart';
import 'package:oxytocin/features/home/presentation/widgets/nearby_doctor_card.dart';
import 'package:oxytocin/features/home/presentation/widgets/section_header.dart';
import 'package:oxytocin/features/home/presentation/widgets/top_bar.dart';
import 'package:oxytocin/features/search_doctors_page/data/services/doctor_search_service.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/viewmodels/doctorSearch/doctor_search_cubit.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/views/search_doctors_view.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'package:oxytocin/features/categories/presentation/widgets/category_card.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_state.dart';
import 'package:oxytocin/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/features/categories/presentation/widgets/subspecialties_bottom_sheet.dart';
import 'package:oxytocin/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/profile/presentation/view/profile_view.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_state.dart';
import 'package:oxytocin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:oxytocin/features/profile/data/datasources/profile_data_source.dart';
import 'package:oxytocin/features/medical_appointments/presentation/views/medical_appointments_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _onDoctorCardTap(int doctorIndex) {
    final cubit = context.read<HomeCubit>();
    cubit.onDoctorCardTap(doctorIndex);
  }

  void _onDoctorFavoriteTap(int doctorIndex) {
    final cubit = context.read<HomeCubit>();
    cubit.onDoctorFavoriteTap(doctorIndex);
  }

  void _onDoctorBookTap(int doctorIndex) {
    final cubit = context.read<HomeCubit>();
    cubit.onDoctorBookTap(doctorIndex);
  }

  void _onNearbyDoctorCardTap(int doctorIndex) {
    final cubit = context.read<HomeCubit>();
    cubit.onNearbyDoctorCardTap(doctorIndex);
  }

  void _onNearbyDoctorBookTap(int doctorIndex) {
    final cubit = context.read<HomeCubit>();
    cubit.onNearbyDoctorBookTap(doctorIndex);
  }

  void _onViewAllCategories() {
    NavigationService().pushToNamed(RouteNames.categories);
  }

  void _showSubspecialtiesBottomSheet(BuildContext context, category) {
    // الحصول على الـ cubit من الـ context
    final categoriesCubit = context.read<CategoriesCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          SubspecialtiesBottomSheet(category: category, cubit: categoriesCubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeContent(screenWidth, screenHeight, isTablet),

            _buildDoctorsPage(),

            _buildAppointmentsPage(),

            _buildProfilePage(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent(
    double screenWidth,
    double screenHeight,
    bool isTablet,
  ) {
    return ListView(
      children: [
        SizedBox(height: screenHeight * 0.05),
        BlocProvider.value(
          value: ProfileCubit(ProfileRepository(ProfileDataSourceImpl()))
            ..getProfile(),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              if (profileState is ProfileLoaded) {
                return TopBar(profile: profileState.profile);
              }
              return const TopBar();
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        BlocProvider(
          create: (_) {
            final cubit = CategoriesCubit(
              CategoriesRemoteDataSource(),
              LocalStorageService(),
            );
            cubit.fetchCategories();
            return cubit;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 12.0 : 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "     ما هو التخصص الذي تبحث عنه          ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 16.0 : 14.0,
                          fontFamily: 'AlmaraiBold',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onViewAllCategories,
                      child: Row(
                        children: [
                          Text(
                            "عرض الكل",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: isTablet ? 14.0 : 12.0,
                              fontFamily: 'AlmaraiBold',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.grey[700],
                            size: isTablet ? 20.0 : 16.0,
                          ),
                          SizedBox(width: isTablet ? 8.0 : 4.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              SizedBox(
                height: isTablet ? 140.0 : 110.0,
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state.status == CategoriesStatus.success) {
                      final categories = state.categories.take(13).toList();
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: isTablet ? 12.0 : 8.0),
                        itemBuilder: (context, index) {
                          final cat = categories[index];
                          return CategoryCard(
                            title: cat.nameAr,
                            iconAsset: AppImages.categoryNerves,
                            onTap: () {
                              context.read<CategoriesCubit>().selectCategory(
                                cat,
                              );
                              _showSubspecialtiesBottomSheet(context, cat);
                            },
                          );
                        },
                      );
                    } else if (state.status == CategoriesStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(
                        child: Text(
                          'حدث خطأ في تحميل الفئات',
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        const SectionHeader(title: '     أفضل الأطباء حسب تقييم المرضى'),
        SizedBox(height: screenHeight * 0.012),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: SizedBox(
                  height: isTablet ? 320.0 : 260.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(
                        doctor: state.doctors[index],
                        onTap: () => _onDoctorCardTap(index),
                        onFavoriteTap: () => _onDoctorFavoriteTap(index),
                        onBookTap: () => _onDoctorBookTap(index),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        SizedBox(width: isTablet ? 8.0 : 6.0),
                  ),
                ),
              );
            } else if (state is HomeFullyLoaded) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: SizedBox(
                  height: isTablet ? 320.0 : 260.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(
                        doctor: state.doctors[index],
                        onTap: () => _onDoctorCardTap(index),
                        onFavoriteTap: () => _onDoctorFavoriteTap(index),
                        onBookTap: () => _onDoctorBookTap(index),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        SizedBox(width: isTablet ? 8.0 : 6.0),
                  ),
                ),
              );
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ في تحميل البيانات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().loadDoctors(
                          33.5260220,
                          36.2864360,
                        );
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('لا توجد بيانات متاحة'));
            }
          },
        ),

        SizedBox(height: screenHeight * 0.01),
        const SectionHeader(title: '     أطباء بالقرب منك'),
        SizedBox(height: screenHeight * 0.010),

        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            debugPrint('Current State: ${state.runtimeType}');

            if (state is NearbyDoctorsLoaded) {
              final nearbyDoctorsWithDistance = state.nearbyDoctors
                  .where((d) => d.distance > 0)
                  .toList();

              if (nearbyDoctorsWithDistance.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
                    child: Text(
                      'لا يوجد أطباء قريبين في الوقت الحالي',
                      style: TextStyle(
                        fontSize: isTablet ? 16.0 : 14.0,
                        color: Colors.grey[600],
                        fontFamily: 'AlmaraiRegular',
                      ),
                    ),
                  ),
                );
              }

              return Column(
                children: nearbyDoctorsWithDistance.map((doctor) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 8.0 : 4.0,
                      vertical: isTablet ? 12.0 : 8.0,
                    ),
                    child: NearbyDoctorCard(
                      doctor: doctor,
                      onTap: () => _onNearbyDoctorCardTap(
                        state.nearbyDoctors.indexOf(doctor),
                      ),
                      onBookTap: () => _onNearbyDoctorBookTap(
                        state.nearbyDoctors.indexOf(doctor),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else if (state is HomeFullyLoaded) {
              final nearbyDoctorsWithDistance = state.nearbyDoctors
                  .where((d) => d.distance > 0)
                  .toList();

              if (nearbyDoctorsWithDistance.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
                    child: Text(
                      'لا يوجد أطباء قريبين في الوقت الحالي',
                      style: TextStyle(
                        fontSize: isTablet ? 16.0 : 14.0,
                        color: Colors.grey[600],
                        fontFamily: 'AlmaraiRegular',
                      ),
                    ),
                  ),
                );
              }

              return Column(
                children: nearbyDoctorsWithDistance.map((doctor) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 8.0 : 4.0,
                      vertical: isTablet ? 12.0 : 8.0,
                    ),
                    child: NearbyDoctorCard(
                      doctor: doctor,
                      onTap: () => _onNearbyDoctorCardTap(
                        state.nearbyDoctors.indexOf(doctor),
                      ),
                      onBookTap: () => _onNearbyDoctorBookTap(
                        state.nearbyDoctors.indexOf(doctor),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: isTablet ? 48.0 : 40.0,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'حدث خطأ في تحميل الأطباء القريبين',
                        style: TextStyle(
                          fontSize: isTablet ? 14.0 : 12.0,
                          color: Colors.grey[600],
                          fontFamily: 'AlmaraiRegular',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(height: screenHeight * 0.04),
      ],
    );
  }

  Widget _buildDoctorsPage() {
    final searchRepository = DoctorSearchService(http.Client());
    return BlocProvider(
      create: (_) => DoctorSearchCubit(searchRepository),
      child: const SearchDoctorsView(),
    );
  }

  Widget _buildAppointmentsPage() {
    return const MedicalAppointmentsView();
  }

  Widget _buildProfilePage() {
    return BlocProvider(
      create: (_) => ProfileCubit(ProfileRepository(ProfileDataSourceImpl())),
      child: const ProfileView(),
    );
  }
}
