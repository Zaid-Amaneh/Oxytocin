import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/viewmodels/search_view_model.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/search_doctors_view_body_header.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/all_doctors_list.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/search_history.dart';
import 'package:provider/provider.dart';

class AllDoctorsViewBody extends StatefulWidget {
  const AllDoctorsViewBody({super.key});

  @override
  State<AllDoctorsViewBody> createState() => _AllDoctorsViewBodyState();
}

class _AllDoctorsViewBodyState extends State<AllDoctorsViewBody> {
  final _scrollController = ScrollController();
  late final SearchViewModel searchViewModel;
  @override
  void initState() {
    super.initState();
    searchViewModel = SearchViewModel();
  }

  @override
  void dispose() {
    searchViewModel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: searchViewModel,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SearchDoctorsViewBodyHeader(
              serachController: searchViewModel,
            ),
          ),
          Selector<SearchViewModel, bool>(
            selector: (context, vm) => vm.isFieldEmpty,
            builder: (context, isFieldEmpty, child) {
              return isFieldEmpty
                  ? const SliverToBoxAdapter(child: SearchHistory())
                  : AllDoctorsList(scrollController: _scrollController);
            },
          ),
        ],
      ),
    );
  }
}
