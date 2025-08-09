class DoctorSearchRequest {
  final String? query;
  final int? specialties;
  final String? gender;
  final double? distance;
  final double? latitude;
  final double? longitude;
  final String? ordering;
  final int? page;
  final int? pageSize;

  DoctorSearchRequest({
    this.query,
    this.specialties,
    this.gender,
    this.distance,
    this.latitude,
    this.longitude,
    this.ordering,
    this.page,
    this.pageSize,
  });

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (query != null) params['query'] = query!;
    if (specialties != null) params['specialties'] = specialties.toString();
    if (gender != null) params['gender'] = gender!;
    if (distance != null) params['distance'] = distance.toString();
    if (latitude != null) params['latitude'] = latitude.toString();
    if (longitude != null) params['longitude'] = longitude.toString();
    if (ordering != null) params['ordering'] = ordering!;
    if (page != null) params['page'] = page.toString();
    if (pageSize != null) params['page_size'] = pageSize.toString();
    return params;
  }

  DoctorSearchRequest copyWith({
    String? query,
    int? specialties,
    String? gender,
    double? distance,
    double? latitude,
    double? longitude,
    String? ordering,
    int? page,
    int? pageSize,
  }) {
    return DoctorSearchRequest(
      query: query ?? this.query,
      specialties: specialties ?? this.specialties,
      gender: gender ?? this.gender,
      distance: distance ?? this.distance,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      ordering: ordering ?? this.ordering,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
