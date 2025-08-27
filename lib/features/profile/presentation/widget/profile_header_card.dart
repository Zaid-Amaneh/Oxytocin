import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';

class ProfileHeaderCard extends StatefulWidget {
  final UserProfileModel profile;

  const ProfileHeaderCard({super.key, required this.profile});

  @override
  State<ProfileHeaderCard> createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends State<ProfileHeaderCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: SizeConfig.getProportionateScreenHeight(60),
          left: SizeConfig.getProportionateScreenWidth(20),
          right: SizeConfig.getProportionateScreenWidth(20),
          child: Container(
            height: SizeConfig.getProportionateScreenHeight(180),
            decoration: BoxDecoration(
              color: const Color(0xFF344CB7),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF344CB7).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
        ),
        // Main blue card with plus pattern
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(
            width: double.infinity,
            height: SizeConfig.getProportionateScreenHeight(200),
            margin: EdgeInsets.only(
              top: SizeConfig.getProportionateScreenHeight(40),
            ),
            decoration: BoxDecoration(
              color: AppColors.profileCardBlue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.profileCardBlue.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Plus pattern background
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      AppImages.plusImage,
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.1),
                      colorBlendMode: BlendMode.overlay,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.profileCardBlue.withOpacity(0.8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    SizeConfig.getProportionateScreenWidth(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.getProportionateScreenHeight(60),
                      ),
                      _buildUserInfo(),
                      SizedBox(
                        height: SizeConfig.getProportionateScreenHeight(20),
                      ),
                      _buildMotivationalMessage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 100,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: SizeConfig.getProportionateScreenWidth(145),
              height: SizeConfig.getProportionateScreenWidth(145),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipOval(
                child:
                    widget.profile.image != null &&
                        widget.profile.image!.isNotEmpty
                    ? _AuthenticatedImage(
                        imageUrl: widget.profile.image!,
                        width: SizeConfig.getProportionateScreenWidth(145),
                        height: SizeConfig.getProportionateScreenWidth(145),
                        fit: BoxFit.cover,
                      )
                    : _buildDefaultAvatar(),
              ),
            ),
          ),
        ),
      ],
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
      child: Icon(
        FeatherIcons.user,
        size: SizeConfig.getProportionateScreenWidth(40),
        color: AppColors.kPrimaryColor1,
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.profile.fullName.isNotEmpty)
          Text(
            widget.profile.fullName,
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 17),
              fontFamily: 'AlmaraiBold',
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        if (widget.profile.fullName.isNotEmpty && widget.profile.age > 0)
          SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
        if (widget.profile.age > 0)
          Text(
            ' , ${widget.profile.age} عاماً',
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 17),
              fontFamily: 'AlmaraiBold',
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        if (widget.profile.fullName.isEmpty && widget.profile.age <= 0)
          Text(
            'مرحباً بك',
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 17),
              fontFamily: 'AlmaraiBold',
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  Widget _buildMotivationalMessage() {
    return Text(
      '“ 10 دقائق من المشي يومياً تصنع فرقاً كبيراً في صحتك ونشاطك. ابدأ الآن! ”',
      style: TextStyle(
        color: const Color(0xffCCCCCC),
        fontSize: getResponsiveFontSize(context, fontSize: 12),
        fontFamily: 'AlmaraiRegular',
        fontWeight: FontWeight.w500,
        height: 1.4,
        shadows: [
          Shadow(
            offset: const Offset(0, 1),
            blurRadius: 2,
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _AuthenticatedImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const _AuthenticatedImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  });

  @override
  State<_AuthenticatedImage> createState() => _AuthenticatedImageState();
}

class _AuthenticatedImageState extends State<_AuthenticatedImage> {
  String? authToken;
  String? refreshToken;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
  }

  Future<void> _loadAuthToken() async {
    try {
      final secureStorage = SecureStorageService();
      final token = await secureStorage.getAccessToken();
      final refreshTokenValue = await secureStorage.getRefreshToken();
      setState(() {
        authToken = token;
        refreshToken = refreshTokenValue;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[200]!, Colors.grey[300]!],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor1),
          ),
        ),
      );
    }

    if (authToken == null || authToken!.isEmpty) {
      return _buildDefaultAvatar();
    }

    return Image.network(
      widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey[200]!, Colors.grey[300]!],
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.kPrimaryColor1,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildDefaultAvatar();
      },
      headers: {
        'Authorization': 'Bearer $authToken',
        'Refresh': 'Bearer $refreshToken',
      },
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[200]!, Colors.grey[300]!],
        ),
      ),
      child: Icon(
        FeatherIcons.user,
        size: widget.width * 0.4,
        color: AppColors.kPrimaryColor1,
      ),
    );
  }
}
