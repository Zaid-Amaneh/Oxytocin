import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';

class ProfileMenuSection extends StatelessWidget {
  final VoidCallback onAccountTap;
  final VoidCallback onMedicalRecordsTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const ProfileMenuSection({
    Key? key,
    required this.onAccountTap,
    required this.onMedicalRecordsTap,
    required this.onFavoritesTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First menu section
        _buildMenuCard([
          _buildMenuItem(
            icon: FeatherIcons.user,
            title: 'حسابي',
            onTap: onAccountTap,
          ),
          _buildMenuItem(
            icon: FeatherIcons.fileText,
            title: 'سجلاتي الطبية',
            onTap: onMedicalRecordsTap,
          ),
          _buildMenuItem(
            icon: FeatherIcons.heart,
            title: 'المفضلة',
            onTap: onFavoritesTap,
            iconColor: AppColors.kPrimaryColor1,
          ),
        ]),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
        // Second menu section
        _buildMenuCard([
          _buildMenuItem(
            icon: FeatherIcons.settings,
            title: 'اعدادات',
            onTap: onSettingsTap,
          ),
          _buildMenuItem(
            icon: FeatherIcons.logOut,
            title: 'تسجيل خروج',
            onTap: onLogoutTap,
            isDestructive: true,
          ),
        ]),
      ],
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(20),
            vertical: SizeConfig.getProportionateScreenHeight(16),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: SizeConfig.getProportionateScreenWidth(40),
                height: SizeConfig.getProportionateScreenWidth(40),
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.textPrimary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? AppColors.textPrimary,
                  size: SizeConfig.getProportionateScreenWidth(20),
                ),
              ),
              SizedBox(width: SizeConfig.getProportionateScreenWidth(16)),
              // Title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDestructive
                        ? AppColors.error
                        : AppColors.textPrimary,
                    fontSize: 16,
                    fontFamily: 'AlmaraiBold',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Arrow
              Icon(
                FeatherIcons.chevronLeft,
                color: isDestructive
                    ? AppColors.error
                    : AppColors.textSecondary,
                size: SizeConfig.getProportionateScreenWidth(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
