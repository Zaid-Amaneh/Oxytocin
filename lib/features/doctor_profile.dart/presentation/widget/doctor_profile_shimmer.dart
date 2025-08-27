import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DoctorProfileShimmer extends StatelessWidget {
  const DoctorProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            _buildShimmerBox(
              width: double.infinity,
              height: screenHeight * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShimmerBox(
                  width: screenWidth * 0.27,
                  height: screenHeight * 0.17,
                ),
                _buildShimmerBox(
                  width: screenWidth * 0.27,
                  height: screenHeight * 0.17,
                ),
                _buildShimmerBox(
                  width: screenWidth * 0.27,
                  height: screenHeight * 0.17,
                ),
              ],
            ),
            _buildShimmerBox(
              width: screenHeight * 0.6,
              height: screenWidth * 0.7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShimmerBox(
                  width: screenHeight * 0.13,
                  height: screenHeight * 0.13,
                ),
                _buildShimmerBox(
                  width: screenHeight * 0.13,
                  height: screenHeight * 0.13,
                ),
                _buildShimmerBox(
                  width: screenHeight * 0.13,
                  height: screenHeight * 0.13,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
