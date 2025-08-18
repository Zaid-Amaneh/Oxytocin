import 'package:flutter/material.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/search_doctors_view_body.dart';

class SearchDoctorsView extends StatelessWidget {
  const SearchDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AllDoctorsViewBody());
  }
}
