import 'package:flutter/material.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/presentation/widget/profile_header_card.dart';
import 'package:oxytocin/features/profile/presentation/widget/profile_menu_section.dart';

class SimpleProfileView extends StatefulWidget {
  const SimpleProfileView({Key? key}) : super(key: key);

  @override
  State<SimpleProfileView> createState() => _SimpleProfileViewState();
}

class _SimpleProfileViewState extends State<SimpleProfileView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Mock data
  late UserProfileModel mockProfile;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeMockData();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  void _initializeMockData() {
    mockProfile = UserProfileModel(
      id: '1',
      name: 'طارق خليل',
      age: 30,
      profileImage: null,
      email: 'tariq.khalil@example.com',
      phone: '+966501234567',
      address: 'الرياض، المملكة العربية السعودية',
      medicalHistory: 'لا توجد سجلات طبية سابقة',
      favorites: ['د. أحمد محمد', 'د. فاطمة علي'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.getProportionateScreenWidth(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.getProportionateScreenHeight(20),
                        ),
                        ProfileHeaderCard(profile: mockProfile),
                        SizedBox(
                          height: SizeConfig.getProportionateScreenHeight(24),
                        ),
                        ProfileMenuSection(
                          onAccountTap: () => _handleAccountTap(),
                          onMedicalRecordsTap: () => _handleMedicalRecordsTap(),
                          onFavoritesTap: () => _handleFavoritesTap(),
                          onSettingsTap: () => _handleSettingsTap(),
                          onLogoutTap: () => _handleLogoutTap(),
                        ),
                        SizedBox(
                          height: SizeConfig.getProportionateScreenHeight(30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text(
        'الملف الشخصي',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontFamily: 'AlmaraiBold',
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.right,
      ),
      centerTitle: false,
      leading: Container(),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: SizeConfig.getProportionateScreenWidth(16),
          ),
          child: Icon(
            Icons.settings,
            color: AppColors.kPrimaryColor1,
            size: 24,
          ),
        ),
      ],
    );
  }

  void _handleAccountTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم النقر على الحساب',
          style: TextStyle(fontFamily: 'AlmaraiBold'),
        ),
        backgroundColor: AppColors.kPrimaryColor1,
      ),
    );
  }

  void _handleMedicalRecordsTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم النقر على السجلات الطبية',
          style: TextStyle(fontFamily: 'AlmaraiBold'),
        ),
        backgroundColor: AppColors.kPrimaryColor1,
      ),
    );
  }

  void _handleFavoritesTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم النقر على المفضلة',
          style: TextStyle(fontFamily: 'AlmaraiBold'),
        ),
        backgroundColor: AppColors.kPrimaryColor1,
      ),
    );
  }

  void _handleSettingsTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم النقر على الإعدادات',
          style: TextStyle(fontFamily: 'AlmaraiBold'),
        ),
        backgroundColor: AppColors.kPrimaryColor1,
      ),
    );
  }

  void _handleLogoutTap() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'تسجيل الخروج',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontFamily: 'AlmaraiBold',
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: 'AlmaraiRegular',
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'إلغاء',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: 'AlmaraiBold',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم تسجيل الخروج بنجاح',
                    style: TextStyle(fontFamily: 'AlmaraiBold'),
                  ),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'تسجيل الخروج',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'AlmaraiBold',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
