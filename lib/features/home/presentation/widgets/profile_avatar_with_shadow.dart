import 'package:flutter/material.dart';

class ProfileAvatarWithShadow extends StatelessWidget {
  const ProfileAvatarWithShadow({super.key});

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
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: Offset(0, 4),
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
              child: CircleAvatar(
                radius: 33,
                backgroundColor: const Color.fromARGB(255, 40, 9, 144),
                backgroundImage: const AssetImage(''),
                child: Icon(Icons.person, size: 40, color: Colors.grey[400]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
