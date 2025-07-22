import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/home/presentation/widgets/doctor_card.dart';
import 'package:oxytocin/features/home/presentation/widgets/section_header.dart';
import 'package:oxytocin/features/home/presentation/widgets/top_bar.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'package:oxytocin/features/categories/presentation/widgets/category_card.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadDoctors(),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'الرسائل',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'الملف الشخصي',
              ),
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(height: 40),
              TopBar(),
              const SizedBox(height: 10),
              BlocProvider(
                create: (_) => CategoriesCubit()..loadCategories(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "ما هو التخصص الذي تبحث عنه",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'AlmaraiBold',
                            ),
                          ),
                          Spacer(),
                          Text(
                            "عرض الكل",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: 'AlmaraiBold',
                            ),
                          ),
                          Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.grey[700],
                          ),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 110,
                      child: BlocBuilder<CategoriesCubit, CategoriesState>(
                        builder: (context, state) {
                          if (state is CategoriesLoaded) {
                            // يمكنك عرض أول 4 فقط أو الكل
                            final categories = state.categories
                                .take(4)
                                .toList();
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              separatorBuilder: (_, __) => SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final cat = categories[index];
                                return CategoryCard(
                                  title: cat.name,
                                  // iconData: cat.icon, // من CategoryModel
                                  onTap: () {},
                                  iconAsset: '',
                                );
                              },
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // قسم الفئات/الاختصاصات (يمكنك إضافة Widget هنا)
              const SectionHeader(title: 'أفضل الأطباء حسب تقييم المرضى'),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    return SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          return DoctorCard(doctor: state.doctors[index]);
                        },
                        separatorBuilder: (_, __) => SizedBox(width: 12),
                      ),
                    );
                  } else {
                    return Center(child: Text('حدث خطأ'));
                  }
                },
              ),
              // أضف باقي الأقسام هنا
            ],
          ),
        ),
      ),
    );
  }
}
