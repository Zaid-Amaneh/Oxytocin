import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';

class ProfileAvatarWithShadow extends StatefulWidget {
  final UserProfileModel? profile;

  const ProfileAvatarWithShadow({super.key, this.profile});

  @override
  State<ProfileAvatarWithShadow> createState() =>
      _ProfileAvatarWithShadowState();
}

class _ProfileAvatarWithShadowState extends State<ProfileAvatarWithShadow> {
  String? authToken;
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
      setState(() {
        authToken = token;
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
    return SizedBox(
      height: 65,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 70,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),

          Positioned(
            top: -8,
            right: 30,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 108, 107, 107),
                  width: 1.5,
                ),
              ),
              child: ClipOval(child: _buildProfileImageWidget()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImageWidget() {
    if (widget.profile?.image != null &&
        widget.profile!.image!.isNotEmpty &&
        authToken != null &&
        authToken!.isNotEmpty) {
      return Image.network(
        widget.profile!.image!,
        width: 66, // radius * 2
        height: 66,
        fit: BoxFit.cover,
        headers: {'Authorization': 'Bearer $authToken'},
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 40, 9, 144),
            ),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('❌ خطأ في تحميل صورة البروفايل: $error');
          print('📷 URL الصورة: ${widget.profile!.image}');
          return Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 40, 9, 144),
            ),
            child: Icon(FeatherIcons.user, size: 40, color: Colors.grey[400]),
          );
        },
      );
    }
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 40, 9, 144)),
      child: Icon(FeatherIcons.user, size: 40, color: Colors.grey[400]),
    );
  }
}
