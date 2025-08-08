import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';

class NearbyDoctorCard extends StatelessWidget {
  final DoctorModel doctor;
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
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;

    final cardWidth = isLargeScreen
        ? 380.0
        : isTablet
        ? 350.0
        : 320.0;
    final cardHeight = isLargeScreen
        ? 140.0
        : isTablet
        ? 120.0
        : 100.0;
    final imageWidth = isLargeScreen
        ? 130.0
        : isTablet
        ? 110.0
        : 90.0;
    final imageHeight = isLargeScreen
        ? 170.0
        : isTablet
        ? 150.0
        : 130.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
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
                    182,
                    178,
                    178,
                  ).withOpacity(0.6),
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
                      AppImages.doctor,
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
                          doctor.name,
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
                        Text(
                          doctor.specialty,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isTablet ? 12.0 : 10.0,
                            fontFamily: 'AlmaraiRegular',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isTablet ? 4.0 : 2.0),
                        Text(
                          'طريق الأمير تركي الأول',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isTablet ? 11.0 : 9.0,
                            fontFamily: 'AlmaraiRegular',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isTablet ? 35.0 : 30.0),
                        Padding(
                          padding: EdgeInsets.only(
                            right: isTablet ? 60.0 : 55.0,
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
                                  '${doctor.distance} كيلومتر  \n    ',
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
                          'احجزالآن',
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
}
