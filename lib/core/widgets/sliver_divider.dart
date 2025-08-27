import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  const SliverDivider({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Divider(color: color));
  }
}
