import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onBookTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onFavoriteTap,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;

    final cardWidth = isLargeScreen
        ? 350.0
        : isTablet
        ? 320.0
        : 280.0;
    final cardHeight = isLargeScreen
        ? 480.0
        : isTablet
        ? 450.0
        : 420.0;
    final imageWidth = isLargeScreen
        ? 160.0
        : isTablet
        ? 140.0
        : 120.0;
    final imageHeight = isLargeScreen
        ? 280.0
        : isTablet
        ? 250.0
        : 220.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: EdgeInsets.symmetric(
          horizontal: isTablet ? 8.0 : 4.0,
          vertical: isTablet ? 8.0 : 4.0,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF0A1A4A),
                borderRadius: BorderRadius.circular(isTablet ? 25.0 : 20.0),
                image: DecorationImage(
                  image: const AssetImage(AppImages.bgPattern),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    // ignore: deprecated_member_use
                    const Color(0xFF2A4A7A).withOpacity(0.8),
                    BlendMode.srcATop,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: const Color(0xFF1A2A5A).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(isTablet ? 25.0 : 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                isTablet ? 20.0 : 16.0,
                isTablet ? 20.0 : 16.0,
                imageWidth + (isTablet ? 20.0 : 16.0),
                isTablet ? 20.0 : 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.fullName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 18.0 : 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AlmaraiBold',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isTablet ? 4.0 : 2.0),
                  Text(
                    doctor.specialtyName,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isTablet ? 14.0 : 12.0,
                      fontFamily: 'AlmaraiRegular',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isTablet ? 46.0 : 16.0),
                  Text(
                    doctor.university,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isTablet ? 12.0 : 10.0,
                      fontFamily: 'AlmaraiRegular',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   'التقييم: ${doctor.rate}/5',
                  //   style: TextStyle(
                  //     color: Colors.white70,
                  //     fontSize: isTablet ? 12.0 : 10.0,
                  //     fontFamily: 'AlmaraiRegular',
                  //   ),
                  // ),
                  // Text(
                  //   'عدد التقييمات: ${doctor}',
                  //   style: TextStyle(
                  //     color: Colors.white70,
                  //     fontSize: isTablet ? 12.0 : 10.0,
                  //     fontFamily: 'AlmaraiRegular',
                  //   ),
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
            ),
            Positioned(
              top: isTablet ? 12.0 : 8.0,
              right: isTablet ? 12.0 : 8.0,
              child: GestureDetector(
                onTap: onFavoriteTap,
                child: Container(
                  width: isTablet ? 32.0 : 28.0,
                  height: isTablet ? 32.0 : 28.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1A2A5A),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: const Color(0xFF1A2A5A),
                    size: isTablet ? 18.0 : 16.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(isTablet ? 16.0 : 12.0),
                    bottomRight: Radius.circular(isTablet ? 16.0 : 12.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(isTablet ? 16.0 : 12.0),
                    bottomRight: Radius.circular(isTablet ? 16.0 : 12.0),
                  ),
                  child: doctor.imageUrl.isNotEmpty
                      ? Image.network(
                          doctor.formattedImageUrl,
                          fit: BoxFit.cover,
                          width: imageWidth,
                          height: imageHeight,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: imageWidth,
                              height: imageHeight,
                              color: Colors.grey[300],
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                          : null,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'جاري تحميل الصورة...',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.doctorCard),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          width: imageWidth,
                          height: imageHeight,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.doctorCard),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: isTablet ? 50.0 : 45.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF07123A).withOpacity(0.3),
                      const Color(0xFF07123A),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(isTablet ? 16.0 : 12.0),
                    bottomRight: Radius.circular(isTablet ? 16.0 : 12.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 16.0 : 12.0,
                  vertical: isTablet ? 4.0 : 3.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onBookTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 12.0 : 10.0,
                          vertical: isTablet ? 8.0 : 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(
                            isTablet ? 20.0 : 16.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: isTablet ? 16.0 : 14.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: isTablet ? 4.0 : 2.0),
                            Text(
                              'احجز الآن',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 12.0 : 10.0,
                                color: Colors.black,
                                fontFamily: 'AlmaraiBold',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 8.0 : 6.0,
                        vertical: isTablet ? 6.0 : 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          isTablet ? 20.0 : 16.0,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: isTablet ? 10.0 : 8.0,
                              ),
                              SizedBox(width: isTablet ? 2.0 : 1.0),
                              Text(
                                doctor.rate.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 10.0 : 8.0,
                                  fontFamily: 'AlmaraiBold',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'بناءً على ${doctor.rates} تقييمات',
                            style: TextStyle(
                              fontSize: isTablet ? 10.0 : 8.0,
                              color: Colors.black87,
                              fontFamily: 'AlmaraiRegular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
