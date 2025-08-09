import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/viewmodels/search_view_model.dart';
import 'package:oxytocin/core/widgets/search_field.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/viewmodels/doctorSearch/doctor_search_cubit.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/filter_icon.dart';
import 'package:provider/provider.dart';

class SearchDoctorsViewBodyHeader extends StatefulWidget {
  const SearchDoctorsViewBodyHeader({
    super.key,
    required this.serachController,
  });
  final SearchViewModel serachController;

  @override
  State<SearchDoctorsViewBodyHeader> createState() =>
      _SearchDoctorsViewBodyHeaderState();
}

class _SearchDoctorsViewBodyHeaderState
    extends State<SearchDoctorsViewBodyHeader> {
  @override
  void dispose() {
    widget.serachController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // final width = size.width;
    final height = size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.07),
        Row(
          children: [
            // FilterIcon(
            //   onTap: () {
            //     showFilterSheet(context, context.read<DoctorSearchCubit>());
            //   },
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ChangeNotifierProvider<SearchViewModel>(
                  create: (_) => widget.serachController,
                  child: SearchField(
                    onSubmitted: (p0) async {
                      LocalStorageService().saveUserQuery(p0);
                      context.read<DoctorSearchCubit>().updateAndSearch(
                        query: p0,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 15, 10, 6),
          child: Text(
            context.tr.explore_and_choose_doctor,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 0, 10, 10),
          child: Text(
            context.tr.browse_specialties_and_book,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textSecondary, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
