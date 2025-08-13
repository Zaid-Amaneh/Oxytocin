import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/viewmodels/doctorSearch/doctor_search_cubit.dart';
import 'package:toastification/toastification.dart';

class FilterIcon extends StatelessWidget {
  final VoidCallback onTap;

  const FilterIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        width: 50,
        height: 50,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(
            side: BorderSide(width: 1, color: Color(0xFFE7E7E7)),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Image.asset(AppImages.setting),
      ),
    );
  }
}

Future<Position?> _handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Location location = Location();
    await location.requestService();
    serviceEnabled = await location.serviceEnabled();

    if (context.mounted && !serviceEnabled) {
      Helper.customToastification(
        context: context,
        type: ToastificationType.info,
        title: context.tr.permissions_error_title,
        description: context.tr.location_services_disabled,
        seconds: 5,
      );
    }
    if (!serviceEnabled) {
      return null;
    }
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    while (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    if (context.mounted) {
      Helper.customToastification(
        context: context,
        type: ToastificationType.error,
        title: context.tr.permissions_error_title,
        description: context.tr.location_permission_denied_forever,
        seconds: 5,
      );
    }
    return null;
  }

  return await Geolocator.getCurrentPosition();
}

void showFilterSheet(BuildContext context, DoctorSearchCubit cubit) {
  final secureStorageService = SecureStorageService();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final currentParams = cubit.currentRequest;

      final Map<String, String?> units = {
        context.tr.km: 'km',
        context.tr.m: 'm',
      };
      final Map<String, String?> genders = {
        context.tr.undefined: '',
        context.tr.male: 'male',
        context.tr.female: 'female',
      };
      final Map<String, int?> specialties = {
        'غير محدد': 0,
        'الطب الباطني': 1,
        'طب الأسرة': 2,
        'طب الأطفال': 3,
        'التوليد وأمراض النساء': 4,
      };
      final Map<String, String?> sortOptions = {
        context.tr.undefined: '',
        context.tr.experience: 'experience',
        context.tr.rate: 'rate',
        context.tr.distance: 'distance',
      };
      final List<String> orderOptions = [
        context.tr.ascending,
        context.tr.descending,
      ];

      String selectedGender = genders.entries
          .firstWhere(
            (e) => e.value == currentParams.gender,
            orElse: () => genders.entries.first,
          )
          .key;
      String unit = units.entries
          .firstWhere(
            (e) => e.value == currentParams.unit,
            orElse: () => units.entries.first,
          )
          .key;
      double selectedDistance =
          currentParams.distance ?? (unit == context.tr.km ? 10 : 1000);
      String selectedSpecialty = specialties.entries
          .firstWhere(
            (e) => e.value == currentParams.specialties,
            orElse: () => specialties.entries.first,
          )
          .key;
      String selectedLocationType = currentParams.useCurrentLocation
          ? context.tr.registeredLocation
          : context.tr.currentLocationHint;
      String? rawOrdering = currentParams.ordering;
      String sortOrder = (rawOrdering != null && rawOrdering.startsWith('-'))
          ? context.tr.descending
          : context.tr.ascending;
      String sortBy = (rawOrdering != null)
          ? sortOptions.entries
                .firstWhere(
                  (e) => e.value == rawOrdering.replaceAll('-', ''),
                  orElse: () => sortOptions.entries.first,
                )
                .key
          : context.tr.undefined;

      return FutureBuilder<bool>(
        future: secureStorageService.hasAccessToken(),
        builder: (context, snapshot) {
          bool isLoggedIn = snapshot.data ?? false;
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  runSpacing: 8,
                  children: [
                    Text(
                      context.tr.filterGender,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: genders.entries
                          .map(
                            (entry) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ChoiceChip(
                                label: Text(entry.key),
                                selected: selectedGender == entry.key,
                                onSelected: (_) =>
                                    setState(() => selectedGender = entry.key),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    Text(
                      context.tr.filterSpecialty,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedSpecialty,
                      isExpanded: true,
                      onChanged: (value) =>
                          setState(() => selectedSpecialty = value!),
                      items: specialties.entries
                          .map(
                            (label) => DropdownMenuItem<String>(
                              value: label.key,
                              child: Text(label.key),
                            ),
                          )
                          .toList(),
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        ChoiceChip(
                          label: Text(context.tr.km),
                          selected: unit == context.tr.km,
                          onSelected: (_) {
                            setState(() {
                              unit = context.tr.km;
                              selectedDistance = 10;
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text(context.tr.m),
                          selected: unit == context.tr.m,
                          onSelected: (_) {
                            setState(() {
                              unit = context.tr.m;
                              selectedDistance = 1000;
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      '$unit: ${selectedDistance.toInt()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      padding: const EdgeInsets.all(8),
                      min: unit == context.tr.km ? 1 : 1000,
                      max: unit == context.tr.km ? 50 : 10000,
                      divisions: unit == context.tr.km ? 49 : 45,
                      value: selectedDistance,
                      label: '${selectedDistance.toInt()} $unit',
                      onChanged: (value) =>
                          setState(() => selectedDistance = value),
                    ),
                    Text(
                      context.tr.locate,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(context.tr.currentLocationHint),
                            selected:
                                selectedLocationType ==
                                context.tr.currentLocationHint,
                            onSelected: (_) => setState(
                              () => selectedLocationType =
                                  context.tr.currentLocationHint,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(context.tr.registeredLocation),
                            selected:
                                selectedLocationType ==
                                context.tr.registeredLocation,
                            onSelected: isLoggedIn
                                ? (_) => setState(
                                    () => selectedLocationType =
                                        context.tr.registeredLocation,
                                  )
                                : null,
                            disabledColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      context.tr.sortBy,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: sortBy,
                      isExpanded: true,
                      onChanged: (value) => setState(() => sortBy = value!),
                      items: sortOptions.entries
                          .map(
                            (label) => DropdownMenuItem<String>(
                              value: label.key,
                              child: Text(label.key),
                            ),
                          )
                          .toList(),
                    ),
                    Text(
                      context.tr.sortBy,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: orderOptions
                          .map(
                            (order) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: ChoiceChip(
                                label: Text(order),
                                selected: sortOrder == order,
                                onSelected: (_) =>
                                    setState(() => sortOrder = order),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final String? genderValue = genders[selectedGender];
                        final int? specialtyValue =
                            specialties[selectedSpecialty];

                        String? finalOrderingParam;
                        final String? sortValue = sortOptions[sortBy];
                        if (sortValue != null) {
                          finalOrderingParam =
                              (sortOrder == context.tr.descending)
                              ? '-$sortValue'
                              : sortValue;
                        }

                        double? latitude;
                        double? longitude;

                        if (selectedLocationType ==
                            context.tr.currentLocationHint) {
                          Helper.showCircularProgressIndicator(context);
                          final Position? position =
                              await _handleLocationPermission(context);
                          if (position != null) {
                            latitude = position.latitude;
                            longitude = position.longitude;
                            cubit.updateAndSearch(
                              useCurrentLocation: false,
                              gender: genderValue,
                              specialties: specialtyValue,
                              distance: selectedDistance,
                              ordering: finalOrderingParam,
                              latitude: latitude,
                              longitude: longitude,
                              unit: units[unit],
                            );
                          }
                          if (context.mounted) {
                            context.pop();
                          }
                        } else {
                          cubit.updateAndSearch(
                            useCurrentLocation: true,
                            gender: genderValue,
                            specialties: specialtyValue,
                            distance: selectedDistance,
                            ordering: finalOrderingParam,
                            unit: units[unit],
                          );
                        }

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.filter_alt),
                      label: Text(context.tr.apply),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
