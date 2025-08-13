class DoctorSearchRequest {
  final bool useCurrentLocation;
  final String? query;
  final int? specialties;
  final String? gender;
  final double? distance;
  final double? latitude;
  final double? longitude;
  final String? unit;
  final String? ordering;
  final int? page;
  final int? pageSize;

  DoctorSearchRequest({
    required this.useCurrentLocation,
    this.query,
    this.specialties,
    this.gender,
    this.distance,
    this.latitude,
    this.longitude,
    this.unit,
    this.ordering,
    this.page,
    this.pageSize,
  });

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (query != null) params['query'] = query!;
    if (specialties != null && specialties != 0) {
      params['specialties'] = specialties.toString();
    }
    if (gender != null && gender!.isNotEmpty) {
      params['gender'] = gender!;
    }
    if (distance != null) params['distance'] = distance.toString();
    if (!useCurrentLocation) {
      if (latitude != null) params['latitude'] = latitude.toString();
      if (longitude != null) params['longitude'] = longitude.toString();
    }
    if (unit != null) params['unit'] = unit!;
    if (ordering != null && ordering!.isNotEmpty) {
      params['ordering'] = ordering!;
    }
    if (page != null) params['page'] = page.toString();
    if (pageSize != null) params['page_size'] = pageSize.toString();
    return params;
  }

  DoctorSearchRequest copyWith({
    bool? useCurrentLocation,
    String? query,
    int? specialties,
    String? gender,
    double? distance,
    double? latitude,
    double? longitude,
    String? ordering,
    String? unit,
    int? page,
    int? pageSize,
  }) {
    return DoctorSearchRequest(
      useCurrentLocation: useCurrentLocation ?? this.useCurrentLocation,
      query: query ?? this.query,
      specialties: specialties ?? this.specialties,
      gender: gender ?? this.gender,
      distance: distance ?? this.distance,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      unit: unit ?? this.unit,
      ordering: ordering ?? this.ordering,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
