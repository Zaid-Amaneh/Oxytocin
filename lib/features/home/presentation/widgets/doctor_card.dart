import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/home/data/model/doctor_model.dart';

class DoctorCard extends StatefulWidget {
  final DoctorModel doctor;
  final VoidCallback? onTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback? onBookTap;
  final bool isFavorite;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    required this.onFavoriteTap,
    required this.isFavorite,
    this.onBookTap,
  });

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(DoctorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  void _onFavoriteTap() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteTap();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
      onTap: widget.onTap,
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
                    widget.doctor.fullName,
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
                    widget.doctor.specialtyName,
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
                    widget.doctor.university,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isTablet ? 12.0 : 10.0,
                      fontFamily: 'AlmaraiRegular',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.doctor.address != null &&
                      widget.doctor.address!.isNotEmpty) ...[
                    SizedBox(height: isTablet ? 4.0 : 2.0),
                    Text(
                      'العيادة:',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isTablet ? 11.0 : 9.0,
                        fontFamily: 'AlmaraiRegular',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isTablet ? 2.0 : 1.0),
                    Text(
                      widget.doctor.address!,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isTablet ? 11.0 : 9.0,
                        fontFamily: 'AlmaraiRegular',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (widget.doctor.clinicDistance != null) ...[
                    SizedBox(height: isTablet ? 4.0 : 2.0),
                    Text(
                      'يبعد عنك ${widget.doctor.formattedDistance}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isTablet ? 11.0 : 9.0,
                        fontFamily: 'AlmaraiRegular',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (widget.doctor.hasAvailableAppointment) ...[
                    SizedBox(height: isTablet ? 2.0 : 1.0),
                    Text(
                      context.tr.earliestAvailableAppointment,
                      // 'أقرب موعد متاح',
                      style: TextStyle(
                        color: Colors.green[300],
                        fontSize: isTablet ? 10.0 : 8.0,
                        fontFamily: 'AlmaraiRegular',
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
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
                  child: Container(
                    width: imageWidth,
                    height: imageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _getDefaultImage(widget.doctor.gender),
                        ),
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
                      onTap: widget.onBookTap,
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
                              // 'احجز الآن'
                              context.tr.bookNow,
                              
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
                                widget.doctor.rate.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 10.0 : 8.0,
                                  fontFamily: 'AlmaraiBold',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'بناءً على ${widget.doctor.rates} تقييمات',
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
            Positioned(
              top: isTablet ? 12.0 : 8.0,
              right: isTablet ? 12.0 : 8.0,
              child: GestureDetector(
                onTap: _onFavoriteTap,
                child: Container(
                  width: isTablet ? 42.0 : 38.0,
                  height: isTablet ? 42.0 : 38.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1A2A5A),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : const Color(0xFF1A2A5A),
                    size: isTablet ? 28.0 : 26.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultImage(String? gender) {
    if (gender == 'female') {
      return AppImages.docWomen;
    } else {
      return AppImages.doctorCard;
    }
  }
}
