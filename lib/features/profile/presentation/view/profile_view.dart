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
import 'package:oxytocin/features/profile/presentation/view/account_details_view.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
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
    context.read<ProfileCubit>().getProfile();
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
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'خطأ: ${state.message}',
                    style: const TextStyle(
                      fontFamily: 'AlmaraiBold',
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            } else if (state is ProfileLoaded) {}
          },
          builder: (context, state) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
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
                                24,
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
                                40,
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

  Widget _buildLoadingState() {
    return Column(
      children: [
        _buildShimmerCard(),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(24)),
        _buildShimmerMenuSection(),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      height: SizeConfig.getProportionateScreenHeight(280),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(24),
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
          height: SizeConfig.getProportionateScreenHeight(160),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(UserProfileModel profile) {
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
          Container(
            width: SizeConfig.getProportionateScreenWidth(80),
            height: SizeConfig.getProportionateScreenWidth(80),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              FeatherIcons.alertCircle,
              size: SizeConfig.getProportionateScreenWidth(40),
              color: AppColors.error,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          Text(
            'حدث خطأ في تحميل البيانات',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: getResponsiveFontSize(context, fontSize: 16),
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
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(24),
                vertical: SizeConfig.getProportionateScreenHeight(12),
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

  void _handleAccountTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<ProfileCubit>(),
          child: const AccountDetailsView(),
        ),
      ),
    );
  }

  void _handleMedicalRecordsTap() {
    print('تم النقر على السجلات الطبية');
  }

  void _handleFavoritesTap() {
    print('تم النقر على المفضلة');
  }

  void _handleSettingsTap() {
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
              _handleLogout();
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
    print('تم تسجيل الخروج بنجاح');
  }
}
