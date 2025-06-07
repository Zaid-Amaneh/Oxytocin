import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/theme/app_gradients.dart';
import 'package:oxytocin/features/intro/data/models/intro_header_item.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/features/intro/presentation/widget/custom_smooth_pageIndicator.dart';
import 'package:oxytocin/features/intro/presentation/widget/intro_header.dart';

class IntroViewBody extends StatefulWidget {
  const IntroViewBody({super.key, required this.intro});
  final List<IntroHeaderItem> intro;

  @override
  State<IntroViewBody> createState() => _IntroViewBodyState();
}

class _IntroViewBodyState extends State<IntroViewBody> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.getBackgroundGradient(context),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              controller: pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                return IntroHeader(introHeaderItem: widget.intro[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                borderRadius: 29,
                visible: true,
                data: currentPage == 2 ? context.tr.StartNow : context.tr.Next,
                onTap: () {
                  if (currentPage == 2) {
                    introductionEnd();
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                borderColor: AppColors.kPrimaryColor4,
                style: AppStyles.almaraiExtraBold(
                  context,
                ).copyWith(color: Colors.black),
              ),
              CustomSmoothPageindicator(
                pageController: pageController,
                count: widget.intro.length,
              ),
              CustomButton(
                borderRadius: 29,
                visible: false,
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                data: context.tr.Skip,
                onTap: () {
                  introductionEnd();
                },
                style: AppStyles.almaraiExtraBold(
                  context,
                ).copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  void introductionEnd() {
    LocalStorageService localStorageService = LocalStorageService();
    localStorageService.newUser();
    NavigationService nav = NavigationService();
    nav.goToNamed(RouteNames.signIn);
  }
}
