import 'package:flutter/material.dart';
import 'package:oxytocin/features/home/presentation/widgets/profile_avatar_with_shadow.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // أيقونة الإشعارات في أقصى اليسار
        ProfileAvatarWithShadow(),
        SizedBox(width: 38),
        Expanded(
          child: SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً، نتمنى لك يوماً سعيداً!',
                  style: TextStyle(
                    fontFamily: 'AlmaraiBold',
                    color: Colors.black,
                  ),
                ),
                Text(
                  'الثلاثاء، 17 يونيو 2025',
                  style: TextStyle(fontFamily: 'AlmaraiBold', fontSize: 13),
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
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 7,
                  offset: Offset(0, 3),
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
