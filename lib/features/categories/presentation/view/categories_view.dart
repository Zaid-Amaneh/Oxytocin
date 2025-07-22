import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import '../widgets/category_card.dart';
import '../widgets/search_bar.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit()..loadCategories(),
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
                onChanged: (value) =>
                    context.read<CategoriesCubit>().search(value),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoaded) {
                      return GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1, // عدلها حسب الشكل النهائي
                        mainAxisSpacing: 5, // المسافة العمودية بين الكاردات
                        crossAxisSpacing: 30, // المسافة الأفقية بين الكاردات
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ), // أو حسب الحاجة
                        children: state.categories
                            .map(
                              (cat) => CategoryCard(
                                title: cat.name,
                                iconAsset: "",
                                //     cat.iconAsset, // ضع المسار الصحيح للأيقونة
                                onTap: () {},
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
}
