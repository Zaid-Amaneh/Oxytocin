import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_state.dart';
import 'package:oxytocin/features/profile/presentation/widget/profile_header_card.dart';
import 'package:oxytocin/features/profile/presentation/widget/profile_menu_section.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadProfileData();
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

  void _loadProfileData() {
    context.read<ProfileCubit>().getUserProfile();
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
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              _showErrorSnackBar(state.message);
            } else if (state is ProfileLoggedOut) {
              _handleLogout();
            }
          },
          builder: (context, state) {
            return CustomScrollView(
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
                          horizontal: SizeConfig.getProportionateScreenWidth(
                            20,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.getProportionateScreenHeight(
                                20,
                              ),
                            ),
                            if (state is ProfileLoading)
                              _buildLoadingState()
                            else if (state is ProfileLoaded)
                              _buildProfileContent(state.profile)
                            else if (state is ProfileError)
                              _buildErrorState()
                            else
                              _buildInitialState(),
                            SizedBox(
                              height: SizeConfig.getProportionateScreenHeight(
                                30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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
          fontSize: getResponsiveFontSize(context, fontSize: 20),
          fontFamily: 'AlmaraiBold',
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.right,
      ),
      centerTitle: false,
      leading: Container(), // إزالة زر الرجوع
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: SizeConfig.getProportionateScreenWidth(16),
          ),
          child: Icon(
            FeatherIcons.settings,
            color: AppColors.kPrimaryColor1,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        _buildShimmerCard(),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
        _buildShimmerMenuSection(),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      height: SizeConfig.getProportionateScreenHeight(200),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildShimmerMenuSection() {
    return Column(
      children: List.generate(
        2,
        (index) => Container(
          margin: EdgeInsets.only(
            bottom: SizeConfig.getProportionateScreenHeight(16),
          ),
          height: SizeConfig.getProportionateScreenHeight(120),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(dynamic profile) {
    return Column(
      children: [
        ProfileHeaderCard(profile: profile),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(24)),
        ProfileMenuSection(
          onAccountTap: () => _handleAccountTap(),
          onMedicalRecordsTap: () => _handleMedicalRecordsTap(),
          onFavoritesTap: () => _handleFavoritesTap(),
          onSettingsTap: () => _handleSettingsTap(),
          onLogoutTap: () => _handleLogoutTap(),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FeatherIcons.alertCircle, size: 64, color: AppColors.error),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          Text(
            'حدث خطأ في تحميل البيانات',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontFamily: 'AlmaraiBold',
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          ElevatedButton(
            onPressed: _loadProfileData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'إعادة المحاولة',
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 14),
                fontFamily: 'AlmaraiBold',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const SizedBox.shrink();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'AlmaraiBold',
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _handleAccountTap() {
    // التنقل إلى صفحة الحساب
    print('تم النقر على الحساب');
  }

  void _handleMedicalRecordsTap() {
    // التنقل إلى صفحة السجلات الطبية
    print('تم النقر على السجلات الطبية');
  }

  void _handleFavoritesTap() {
    // التنقل إلى صفحة المفضلة
    print('تم النقر على المفضلة');
  }

  void _handleSettingsTap() {
    // التنقل إلى صفحة الإعدادات
    print('تم النقر على الإعدادات');
  }

  void _handleLogoutTap() {
    _showLogoutDialog();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'تسجيل الخروج',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: getResponsiveFontSize(context, fontSize: 18),
            fontFamily: 'AlmaraiBold',
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: getResponsiveFontSize(context, fontSize: 14),
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
                fontSize: getResponsiveFontSize(context, fontSize: 14),
                fontFamily: 'AlmaraiBold',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ProfileCubit>().logout();
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
                fontSize: getResponsiveFontSize(context, fontSize: 14),
                fontFamily: 'AlmaraiBold',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogout() {
    // التنقل إلى صفحة تسجيل الدخول
    print('تم تسجيل الخروج بنجاح');
  }
}
