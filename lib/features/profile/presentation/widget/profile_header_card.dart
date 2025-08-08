import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';

class ProfileHeaderCard extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileHeaderCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.kPrimaryColor1, AppColors.kPrimaryColor2],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor1.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(child: CustomPaint(painter: PlusPatternPainter())),
          // Content
          Padding(
            padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(24)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
                _buildProfileImage(),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
                _buildUserInfo(),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(12)),
                _buildMotivationalMessage(),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: SizeConfig.getProportionateScreenWidth(80),
      height: SizeConfig.getProportionateScreenWidth(80),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: profile.profileImage != null
            ? Image.network(
                profile.profileImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildDefaultAvatar(),
              )
            : _buildDefaultAvatar(),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
      ),
      child: Icon(
        FeatherIcons.user,
        size: SizeConfig.getProportionateScreenWidth(40),
        color: AppColors.kPrimaryColor1,
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          profile.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'AlmaraiBold',
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
        Text(
          '${profile.age} عاماً',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            fontFamily: 'AlmaraiRegular',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMotivationalMessage() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getProportionateScreenWidth(16),
        vertical: SizeConfig.getProportionateScreenHeight(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            FeatherIcons.droplet,
            color: Colors.white.withOpacity(0.8),
            size: SizeConfig.getProportionateScreenWidth(16),
          ),
          SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
          Expanded(
            child: Text(
              'هل شربت ما يكفي من الماء اليوم؟ تذكر. الترطيب سر النشاط والصحة!',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
                fontFamily: 'AlmaraiRegular',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PlusPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const spacing = 30.0;
    const plusSize = 8.0;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        // Vertical line
        canvas.drawLine(
          Offset(x, y - plusSize),
          Offset(x, y + plusSize),
          paint,
        );
        // Horizontal line
        canvas.drawLine(
          Offset(x - plusSize, y),
          Offset(x + plusSize, y),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
