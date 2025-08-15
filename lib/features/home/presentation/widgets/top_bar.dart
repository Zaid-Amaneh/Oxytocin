import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oxytocin/features/home/presentation/widgets/profile_avatar_with_shadow.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';

class TopBar extends StatelessWidget {
  final UserProfileModel? profile;

  const TopBar({super.key, this.profile});

  String _getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE، d MMMM yyyy', 'ar');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileAvatarWithShadow(profile: profile),
        const SizedBox(width: 38),
        Expanded(
          child: SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحباً، نتمنى لك يوماً سعيداً!',
                  style: TextStyle(
                    fontFamily: 'AlmaraiBold',
                    color: Colors.black,
                  ),
                ),
                Text(
                  _getCurrentDate(),
                  style: const TextStyle(
                    fontFamily: 'AlmaraiBold',
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey[600],
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
