import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import '../../data/models/doctor_model.dart';

class DoctorCard extends StatefulWidget {
  final Doctor doctor;
  final VoidCallback? onTap;
  final VoidCallback onFavoriteTap;
  final bool isFavorite;
  final bool showFavoriteButton;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onFavoriteTap,
    required this.isFavorite,
    this.onTap,
    this.showFavoriteButton = true,
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
      setState(() {
        _isFavorite = widget.isFavorite;
      });
    }
  }

  void _onFavoriteTap() {
    widget.onFavoriteTap();
  }

  String _getDefaultImage(String gender) {
    if (gender == 'female') {
      return 'assets/images/docWomen.png';
    } else {
      return 'assets/images/doc.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;

    final cardWidth = isLargeScreen
        ? 450.0
        : isTablet
        ? 420.0
        : 380.0;
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
        height: 250,
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
                image: const DecorationImage(
                  image: AssetImage(AppImages.bgPattern),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF2A4A7A),
                    BlendMode.srcATop,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2A5A).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(isTablet ? 25.0 : 20.0),
                ),
              ),
            ),
            Positioned(
              top: isTablet ? 20.0 : 16.0,
              right: isTablet ? 0.0 : 6.0,
              child: Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isTablet ? 20.0 : 16.0),
                  border: Border.all(
                    color: Colors.white,
                    width: isTablet ? 0.03 : 0.01,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isTablet ? 20.0 : 16.0),
                  child: widget.doctor.image.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.doctor.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            _getDefaultImage(widget.doctor.gender),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          _getDefaultImage(widget.doctor.gender),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),

            if (widget.showFavoriteButton)
              Positioned(
                top: isTablet ? 35.0 : 200.0,
                left: isTablet ? 45.0 : 20.0,
                child: GestureDetector(
                  onTap: widget.onFavoriteTap,
                  child: Container(
                    padding: EdgeInsets.all(isTablet ? 8.0 : 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.grey[600],
                      size: isTablet ? 30.0 : 25.0,
                    ),
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
                  if (widget.doctor.address.isNotEmpty) ...[
                    SizedBox(height: isTablet ? 8.0 : 6.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: isTablet ? 14.0 : 12.0,
                        ),
                        SizedBox(width: isTablet ? 4.0 : 2.0),
                        Expanded(
                          child: Text(
                            widget.doctor.address,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isTablet ? 10.0 : 8.0,
                              fontFamily: 'AlmaraiRegular',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
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
          ],
        ),
      ),
    );
  }
}
