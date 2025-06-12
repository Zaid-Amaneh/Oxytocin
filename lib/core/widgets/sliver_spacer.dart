import 'package:flutter/material.dart';

class SliverSpacer extends StatelessWidget {
  final double height;

  const SliverSpacer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: height));
  }
}
