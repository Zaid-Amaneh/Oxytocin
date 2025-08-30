import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/home/data/model/nearby_doctor_model.dart';

class NearbyDoctorCard extends StatelessWidget {
  final NearbyDoctorModel doctor;
  final VoidCallback? onTap;
  final VoidCallback? onBookTap;

  const NearbyDoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final info = doctor.doctor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: isTablet ? 145.0 : 130.0,
        margin: EdgeInsets.symmetric(
          horizontal: isTablet ? 8.0 : 4.0,
          vertical: isTablet ? 4.0 : 2.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isTablet ? 30.0 : 25.0),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 109, 131, 231),
              Color.fromARGB(255, 91, 120, 237),
            ],
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: isTablet ? 8.0 : 6.0,
              offset: Offset(0, isTablet ? 4.0 : 3.0),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isTablet ? 30.0 : 25.0),
                child: Image.asset(
                  AppImages.bg2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          isTablet ? 16.0 : 12.0,
                        ),
                        color: const Color(0xFF344CB7),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isTablet ? 30.0 : 25.0),
                  color: const Color.fromARGB(
                    255,
                    165,
                    171,
                    244,
                    // ignore: deprecated_member_use
                  ).withOpacity(0.9),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(isTablet ? 30.0 : 25.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(isTablet ? 30.0 : 25.0),
                    ),
                    child: Image.asset(
                      _getDefaultImageNearby(info.gender),

                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 60, 106, 235),
                            borderRadius: BorderRadius.all(
                              Radius.circular(isTablet ? 30.0 : 25.0),
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            size: isTablet ? 60.0 : 50.0,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 16.0 : 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          info.fullName.isNotEmpty ? info.fullName : 'طبيب',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 16.0 : 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AlmaraiBold',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isTablet ? 4.0 : 2.0),
                        if (info.specialtyName.isNotEmpty) ...[
                          SizedBox(height: isTablet ? 4.0 : 2.0),
                          Text(
                            info.specialtyName,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isTablet ? 14.0 : 10.0,
                              fontFamily: 'AlmaraiRegular',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (info.university.isNotEmpty) ...[
                          SizedBox(height: isTablet ? 4.0 : 2.0),
                          Text(
                            info.university,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isTablet ? 11.0 : 9.0,
                              fontFamily: 'AlmaraiRegular',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (doctor.address.isNotEmpty) ...[
                          SizedBox(height: isTablet ? 4.0 : 2.0),
                          Text(
                            doctor.address,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: isTablet ? 10.0 : 8.0,
                              fontFamily: 'AlmaraiRegular',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        SizedBox(height: isTablet ? 10.0 : 5.0),
                        Padding(
                          padding: EdgeInsets.only(
                            right: isTablet ? 90.0 : 80.0,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 8.0 : 6.0,
                              vertical: isTablet ? 4.0 : 3.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(
                                isTablet ? 12.0 : 10.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${(doctor.distance / 1000).toStringAsFixed(1)} كم',

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: isTablet ? 10.0 : 8.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'AlmaraiBold',
                                  ),
                                ),
                                SizedBox(width: isTablet ? 4.0 : 2.0),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: isTablet ? 12.0 : 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (info.rate > 0) ...[
                          SizedBox(height: isTablet ? 4.0 : 2.0),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: isTablet ? 14.0 : 12.0,
                              ),
                              const SizedBox(width: 2.0),
                              Text(
                                info.rates > 0
                                    ? '${info.rate.toStringAsFixed(1)} (${info.rates})'
                                    : info.rate.toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: isTablet ? 10.0 : 8.0,
                                  fontFamily: 'AlmaraiRegular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onBookTap,
                  child: Container(
                    width: isTablet ? 82.0 : 70.0,
                    height: isTablet ? 145.0 : 130.0,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF2E3A87).withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isTablet ? 30.0 : 25.0),
                        bottomLeft: Radius.circular(isTablet ? 30.0 : 25.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: const Color(0xFF5B7BFF),
                              size: isTablet ? 16.0 : 14.0,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: const Color(0xFF5B7BFF),
                              size: isTablet ? 16.0 : 14.0,
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 4.0 : 2.0),
                        Text(
                          context.tr.bookNow,
                          // 'احجزالآن',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 10.0 : 8.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AlmaraiBold',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultImageNearby(String? gender) {
    if (gender == 'female') {
      return AppImages.doctor;
    } else {
      return AppImages.doctor;
    }
  }
}
