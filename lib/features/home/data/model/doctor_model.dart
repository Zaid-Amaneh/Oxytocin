class DoctorModel {
  final String name;
  final String specialty;
  final String clinic;
  final double distance; 
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String nextAvailableTime;

  DoctorModel({
    required this.name,
    required this.specialty,
    required this.clinic,
    required this.distance,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.nextAvailableTime,
  });
}