import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_state.dart';

class AccountDetailsView extends StatefulWidget {
  const AccountDetailsView({super.key});

  @override
  State<AccountDetailsView> createState() => _AccountDetailsViewState();
}

class _AccountDetailsViewState extends State<AccountDetailsView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileCubit>();
    if (cubit.state is! ProfileLoaded) {
      cubit.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'حسابي',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontFamily: 'AlmaraiBold',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return _buildLoadingState();
          } else if (state is ProfileLoaded) {
            return _buildAccountDetails(state.profile);
          } else if (state is ProfileError) {
            return _buildErrorState(state.message);
          } else {
            return _buildInitialState();
          }
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor1),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          const Text(
            'جاري تحميل البيانات...',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontFamily: 'AlmaraiRegular',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetails(UserProfileModel profile) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(profile),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(24)),
          _buildSectionTitle('المعلومات الشخصية'),
          _buildInfoCard([
            _buildInfoRow('الاسم الكامل', profile.fullName),
            _buildInfoRow('الجنس', profile.gender ?? 'غير محدد'),
            _buildInfoRow('تاريخ الميلاد', _formatDate(profile.birthDate)),
            _buildInfoRow('العمر', '${profile.age} عاماً'),
            _buildInfoRow('رقم الهاتف', profile.phone ?? 'غير محدد'),
          ]),

          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildSectionTitle('المعلومات المهنية'),
          _buildInfoCard([
            _buildInfoRow('المهنة', profile.job ?? 'غير محدد'),
            _buildInfoRow('العنوان', profile.address ?? 'غير محدد'),
          ]),

          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildSectionTitle('المعلومات الطبية'),
          _buildInfoCard([
            _buildInfoRow('فصيلة الدم', profile.bloodType ?? 'غير محدد'),
            _buildInfoRow(
              'التاريخ الطبي',
              profile.medicalHistory ?? 'غير محدد',
            ),
            _buildInfoRow(
              'التاريخ الجراحي',
              profile.surgicalHistory ?? 'غير محدد',
            ),
            _buildInfoRow('الحساسية', profile.allergies ?? 'غير محدد'),
            _buildInfoRow('الأدوية الحالية', profile.medicines ?? 'غير محدد'),
          ]),

          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildSectionTitle('نمط الحياة'),
          _buildInfoCard([
            _buildInfoRow('مدخن', profile.isSmoker == true ? 'نعم' : 'لا'),
            _buildInfoRow(
              'يشرب الكحول',
              profile.isDrinker == true ? 'نعم' : 'لا',
            ),
            _buildInfoRow('متزوج', profile.isMarried == true ? 'نعم' : 'لا'),
          ]),

          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          if (profile.latitude != null && profile.longitude != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('الموقع'),
                _buildInfoCard([
                  _buildInfoRow('خط العرض', '${profile.latitude}'),
                  _buildInfoRow('خط الطول', '${profile.longitude}'),
                ]),
              ],
            ),

          SizedBox(height: SizeConfig.getProportionateScreenHeight(40)),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(UserProfileModel profile) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor1,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor1.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: SizeConfig.getProportionateScreenWidth(80),
            height: SizeConfig.getProportionateScreenWidth(80),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: ClipOval(
              child: profile.image != null && profile.image!.isNotEmpty
                  ? Image.network(
                      profile.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildDefaultAvatar(),
                    )
                  : _buildDefaultAvatar(),
            ),
          ),
          SizedBox(width: SizeConfig.getProportionateScreenWidth(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName.isNotEmpty ? profile.fullName : 'مرحباً بك',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'AlmaraiBold',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (profile.age > 0) ...[
                  SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
                  Text(
                    '${profile.age} عاماً',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      fontFamily: 'AlmaraiRegular',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[200]!, Colors.grey[300]!],
        ),
      ),
      child: const Icon(
        Icons.person,
        size: 40,
        color: AppColors.kPrimaryColor1,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.getProportionateScreenHeight(8),
        right: SizeConfig.getProportionateScreenWidth(4),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontFamily: 'AlmaraiBold',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getProportionateScreenWidth(16),
        vertical: SizeConfig.getProportionateScreenHeight(12),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: 'AlmaraiRegular',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontFamily: 'AlmaraiBold',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'غير محدد';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppColors.error),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          const Text(
            'حدث خطأ',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontFamily: 'AlmaraiBold',
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
          Text(
            message,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: 'AlmaraiRegular',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileCubit>().getProfile();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'إعادة المحاولة',
              style: TextStyle(color: Colors.white, fontFamily: 'AlmaraiBold'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Text(
        'لا توجد بيانات',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16,
          fontFamily: 'AlmaraiRegular',
        ),
      ),
    );
  }
}
