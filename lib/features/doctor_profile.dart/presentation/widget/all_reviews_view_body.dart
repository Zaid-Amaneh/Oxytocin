import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/evaluations_cubit.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/viewmodels/evaluations_state.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/review_card.dart';

class AllReviewsViewBody extends StatefulWidget {
  const AllReviewsViewBody({super.key});
  @override
  State<AllReviewsViewBody> createState() => _AllReviewsViewBodyState();
}

class _AllReviewsViewBodyState extends State<AllReviewsViewBody> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isBottom) return;

    final currentState = context.read<EvaluationsCubit>().state;

    if (currentState is EvaluationsLoaded && !currentState.hasReachedMax) {
      final clinicId = int.parse(
        GoRouterState.of(context).pathParameters['clinicId']!,
      );
      context.read<EvaluationsCubit>().fetchEvaluations(clinicId);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 50);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvaluationsCubit, EvaluationsState>(
      builder: (context, state) {
        switch (state) {
          case EvaluationsError():
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 36, 36, 8),
                  child: Image.asset(AppImages.unexpectedError),
                ),
                Text(
                  context.tr.server_error,
                  textAlign: TextAlign.center,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 14),
                ),
              ],
            );
          case EvaluationsLoaded():
            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: state.hasReachedMax
                  ? state.evaluations.length
                  : state.evaluations.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.evaluations.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    ReviewCard(evaluation: state.evaluations[index]),
                    const Divider(
                      color: AppColors.textSecondary,
                      thickness: 0.4,
                    ),
                  ],
                );
              },
            );
          case EvaluationsLoading():
            return const Center(child: CircularProgressIndicator());
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
