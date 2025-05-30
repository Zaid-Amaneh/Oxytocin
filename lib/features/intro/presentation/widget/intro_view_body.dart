import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:oxytocin/constants/app_constants.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/features/auth/presentation/views/sign_in_view.dart';
import 'package:oxytocin/features/intro/data/models/intro_header_item.dart';
import 'package:oxytocin/features/intro/presentation/widget/custom_button.dart';
import 'package:oxytocin/features/intro/presentation/widget/custom_smooth_pageIndicator.dart';
import 'package:oxytocin/features/intro/presentation/widget/intro_header.dart';
import 'package:oxytocin/generated/l10n.dart';

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
      decoration: const BoxDecoration(gradient: kLinearGradient1),
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
                visible: true,
                data: currentPage == 2
                    ? S.of(context).startNow
                    : S.of(context).Next,
                color: Colors.black,
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
              ),
              CustomSmoothPageindicator(
                pageController: pageController,
                count: 3,
              ),
              CustomButton(
                visible: false,
                data: S.of(context).Skip,
                color: Colors.white,
                onTap: () {
                  introductionEnd();
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  void introductionEnd() async {
    LocalStorageService localStorageService = LocalStorageService();
    await localStorageService.newUser();
    Get.offAll(const SignInView(), transition: Transition.fade);
  }
}
