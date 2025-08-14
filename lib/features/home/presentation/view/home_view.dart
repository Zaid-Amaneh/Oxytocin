import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/home/presentation/widgets/doctor_card.dart';
import 'package:oxytocin/features/home/presentation/widgets/nearby_doctor_card.dart';
import 'package:oxytocin/features/home/presentation/widgets/section_header.dart';
import 'package:oxytocin/features/home/presentation/widgets/top_bar.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'package:oxytocin/features/categories/presentation/widgets/category_card.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_state.dart';
import 'package:oxytocin/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return BlocProvider(
      create: (_) => HomeCubit()..loadDoctors(),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onNavItemTapped,
          ),
          body: ListView(
            children: [
              SizedBox(height: screenHeight * 0.05),
              const TopBar(),
              SizedBox(height: screenHeight * 0.02),
              BlocProvider(
                create: (_) {
                  final cubit = CategoriesCubit();
                  cubit.loadCategories();
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
                          if (state is CategoriesLoaded) {
                            final categories = state.categories
                                .take(13)
                                .toList();
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: isTablet ? 12.0 : 8.0),
                              itemBuilder: (context, index) {
                                final cat = categories[index];
                                return CategoryCard(
                                  title: cat.name,
                                  iconAsset: cat.iconAsset,
                                  onTap: () {},
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              const SectionHeader(title: '     أفضل الأطباء حسب تقييم المرضى'),
              SizedBox(height: screenHeight * 0.015),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: SizedBox(
                        height: isTablet ? 280.0 : 220.0,
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
                              SizedBox(width: isTablet ? 16.0 : 12.0),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'حدث خطأ',
                        style: TextStyle(fontSize: isTablet ? 16.0 : 14.0),
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: screenHeight * 0.03),
              const SectionHeader(title: '     أطباء بالقرب منك'),
              SizedBox(height: screenHeight * 0.015),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    return SizedBox(
                      height: isTablet ? 180.0 : 140.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          return NearbyDoctorCard(
                            doctor: state.doctors[index],
                            onTap: () => _onNearbyDoctorCardTap(index),
                            onBookTap: () => _onNearbyDoctorBookTap(index),
                          );
                        },
                        separatorBuilder: (_, __) =>
                            SizedBox(width: isTablet ? 12.0 : 8.0),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'حدث خطأ',
                        style: TextStyle(fontSize: isTablet ? 16.0 : 14.0),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
