import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/profile/presentation/widget/settings_sheet.dart';

class ProfileMenuSection extends StatefulWidget {
  final VoidCallback onAccountTap;
  final VoidCallback onMedicalRecordsTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const ProfileMenuSection({
    super.key,
    required this.onAccountTap,
    required this.onMedicalRecordsTap,
    required this.onFavoritesTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  @override
  State<ProfileMenuSection> createState() => _ProfileMenuSectionState();
}

class _ProfileMenuSectionState extends State<ProfileMenuSection> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMenuCard([
          _buildMenuItem(
            icon: Icons.person,
            title: context.tr.account,
            onTap: widget.onAccountTap,
          ),
          _buildMenuItem(
            icon: Icons.snippet_folder_sharp,
            title: context.tr.medicalRecords,
            onTap: widget.onMedicalRecordsTap,
          ),
          _buildMenuItem(
            icon: Icons.favorite,
            title: context.tr.favorites,
            onTap: widget.onFavoritesTap,
            iconColor: AppColors.kPrimaryColor1,
          ),
        ]),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
        _buildMenuCard([
          _buildMenuItem(
            icon: Icons.archive,
            title: context.tr.manageAttachments,
            onTap: () => NavigationService().pushToNamed(
              RouteNames.manageMedicalRecords,
            ),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            title: context.tr.settings,
            onTap: () => SettingsSheet.open(context),
          ),
          _buildMenuItem(
            icon: Icons.logout_sharp,
            title: context.tr.logout,
            onTap: widget.onLogoutTap,
            isDestructive: true,
          ),
        ]),
      ],
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(
          SizeConfig.getProportionateScreenWidth(16),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: SizeConfig.getProportionateScreenWidth(10),
            offset: Offset(0, SizeConfig.getProportionateScreenHeight(2)),
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
        borderRadius: BorderRadius.circular(
          SizeConfig.getProportionateScreenWidth(16),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(20),
            vertical: SizeConfig.getProportionateScreenHeight(16),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.profileCardBlue,
                size: SizeConfig.getProportionateScreenWidth(24),
              ),
              SizedBox(width: SizeConfig.getProportionateScreenWidth(16)),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: SizeConfig.getProportionateScreenWidth(14),
                    fontFamily: 'AlmaraiBold',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.profileCardBlue,
                size: SizeConfig.getProportionateScreenWidth(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
