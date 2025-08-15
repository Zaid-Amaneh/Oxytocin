import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/features/categories/data/datasources/categories_remote_data_source.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import '../widgets/category_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/subspecialties_bottom_sheet.dart';
import 'package:oxytocin/core/Utils/app_images.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = CategoriesCubit(
          CategoriesRemoteDataSource(),
          LocalStorageService(),
        );
        cubit.fetchCategories();
        return cubit;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 96,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            children: [
              CategorySearchBar(
                onChanged: (value) {
                  // يمكن إضافة البحث هنا لاحقاً
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocConsumer<CategoriesCubit, CategoriesState>(
                  listener: (context, state) {
                    if (state.status == CategoriesStatus.success) {
                      context.read<CategoriesCubit>().loadSavedSelection();
                    }
                  },
                  builder: (context, state) {
                    if (state.status == CategoriesStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == CategoriesStatus.failure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'حدث خطأ في تحميل الفئات',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'AlmaraiRegular',
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<CategoriesCubit>()
                                    .fetchCategories();
                              },
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state.status == CategoriesStatus.success) {
                      return GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 30,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        children: state.categories
                            .map(
                              (cat) => CategoryCard(
                                title: cat.nameAr,
                                iconAsset: AppImages.categoryDefault,
                                onTap: () {
                                  context
                                      .read<CategoriesCubit>()
                                      .selectCategory(cat);
                                  _showSubspecialtiesBottomSheet(context, cat);
                                },
                              ),
                            )
                            .toList(),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubspecialtiesBottomSheet(BuildContext context, category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SubspecialtiesBottomSheet(category: category),
    );
  }
}
