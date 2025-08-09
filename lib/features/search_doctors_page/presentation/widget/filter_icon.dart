// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:oxytocin/core/Utils/app_images.dart';
// import 'package:oxytocin/core/Utils/helpers/helper.dart';
// import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
// import 'package:oxytocin/features/search_doctors_page/presentation/viewmodels/doctorSearch/doctor_search_cubit.dart';

// class FilterIcon extends StatelessWidget {
//   final VoidCallback onTap;

//   const FilterIcon({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(left: 8, right: 8),
//         width: 50,
//         height: 50,
//         decoration: const ShapeDecoration(
//           color: Colors.white,
//           shape: OvalBorder(
//             side: BorderSide(width: 1, color: Color(0xFFE7E7E7)),
//           ),
//           shadows: [
//             BoxShadow(
//               color: Color(0x3F000000),
//               blurRadius: 2,
//               offset: Offset(0, 2),
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Image.asset(AppImages.setting),
//       ),
//     );
//   }
// }

// // 2. دالة مساعدة للتعامل مع أذونات وجلب الموقع
// /// Handles location permission checks and requests.
// /// Returns a [Position] object on success, or null on failure.
// Future<Position?> _handleLocationPermission(BuildContext context) async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // تحقق مما إذا كانت خدمات الموقع مفعلة
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('خدمات الموقع معطلة. الرجاء تفعيلها للمتابعة.'),
//         ),
//       );
//     }
//     return null;
//   }

//   // تحقق من حالة الإذن
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('تم رفض إذن الوصول للموقع.')),
//         );
//       }
//       return null;
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // الأذونات مرفوضة بشكل دائم، لا يمكننا طلبها مجدداً
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'تم رفض إذن الموقع بشكل دائم. يرجى تفعيله من إعدادات التطبيق.',
//           ),
//         ),
//       );
//     }
//     return null;
//   }

//   // إذا تم منح الأذونات، قم بإرجاع الموقع الحالي
//   return await Geolocator.getCurrentPosition();
// }

// // --- دالة عرض شاشة الفلترة ---
// void showFilterSheet(BuildContext context, DoctorSearchCubit cubit) {
//   final secureStorageService = SecureStorageService();

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       final currentParams = cubit.currentRequest;

//       final Map<String, String?> genders = {
//         context.tr.undefined: null,
//         context.tr.male: 'male',
//         context.tr.female: 'female',
//       };
//       final Map<String, int?> specialties = {
//         'غير محدد': null,
//         'الطب الباطني': 1,
//         'طب الأسرة': 2,
//         'طب الأطفال': 3,
//         'التوليد وأمراض النساء': 4,
//       };
//       final Map<String, String?> sortOptions = {
//         context.tr.undefined: null,
//         context.tr.experience: 'experience',
//         context.tr.rate: 'rate',
//         context.tr.distance: 'distance',
//       };
//       final List<String> orderOptions = [
//         context.tr.ascending,
//         context.tr.descending,
//       ];

//       String selectedGender = genders.entries
//           .firstWhere(
//             (e) => e.value == currentParams.gender,
//             orElse: () => genders.entries.first,
//           )
//           .key;
//       double selectedDistance = currentParams.distance ?? 10.0;
//       String selectedSpecialty = specialties.entries
//           .firstWhere(
//             (e) => e.value == currentParams.specialties,
//             orElse: () => specialties.entries.first,
//           )
//           .key;
//       String selectedLocationType =
//           (currentParams.latitude != null && currentParams.longitude != null)
//           ? context.tr.currentLocationHint
//           : context.tr.registeredLocation;
//       String? rawOrdering = currentParams.ordering;
//       String sortOrder = (rawOrdering != null && rawOrdering.startsWith('-'))
//           ? context.tr.descending
//           : context.tr.ascending;
//       String sortBy = (rawOrdering != null)
//           ? sortOptions.entries
//                 .firstWhere(
//                   (e) => e.value == rawOrdering.replaceAll('-', ''),
//                   orElse: () => sortOptions.entries.first,
//                 )
//                 .key
//           : context.tr.undefined;

//       return FutureBuilder<bool>(
//         future: secureStorageService.hasAccessToken(),
//         builder: (context, snapshot) {
//           bool isLoggedIn = snapshot.data ?? false;
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Wrap(
//                   runSpacing: 16,
//                   children: [
//                     // ... (نفس واجهات الفلاتر كما في الرد السابق)
//                     // Gender, Specialty, Distance, Location Type, Sort By, Sort Order
//                     Text(
//                       context.tr.filterGender,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Row(
//                       children: genders.entries
//                           .map(
//                             (entry) => Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 4.0,
//                               ),
//                               child: ChoiceChip(
//                                 label: Text(entry.key),
//                                 selected: selectedGender == entry.key,
//                                 onSelected: (_) =>
//                                     setState(() => selectedGender = entry.key),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     Text(
//                       context.tr.filterSpecialty,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     DropdownButton<String>(
//                       value: selectedSpecialty,
//                       isExpanded: true,
//                       onChanged: (value) =>
//                           setState(() => selectedSpecialty = value!),
//                       items: specialties.entries
//                           .map(
//                             (label) => DropdownMenuItem<String>(
//                               value: label.key,
//                               child: Text(label.key),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     Text(
//                       '${context.tr.distanceKm}: ${selectedDistance.toInt()}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Slider(
//                       min: 1,
//                       max: 50,
//                       value: selectedDistance,
//                       divisions: 49,
//                       label: '${selectedDistance.toInt()} ${context.tr.km}',
//                       onChanged: (value) =>
//                           setState(() => selectedDistance = value),
//                     ),
//                     Text(
//                       context.tr.locate,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                           child: ChoiceChip(
//                             label: Text(context.tr.currentLocationHint),
//                             selected:
//                                 selectedLocationType ==
//                                 context.tr.currentLocationHint,
//                             onSelected: (_) => setState(
//                               () => selectedLocationType =
//                                   context.tr.currentLocationHint,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                           child: ChoiceChip(
//                             label: Text(context.tr.registeredLocation),
//                             selected:
//                                 selectedLocationType ==
//                                 context.tr.registeredLocation,
//                             onSelected: isLoggedIn
//                                 ? (_) => setState(
//                                     () => selectedLocationType =
//                                         context.tr.registeredLocation,
//                                   )
//                                 : null,
//                             disabledColor: Colors.grey[300],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       context.tr.sortBy,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     DropdownButton<String>(
//                       value: sortBy,
//                       isExpanded: true,
//                       onChanged: (value) => setState(() => sortBy = value!),
//                       items: sortOptions.entries
//                           .map(
//                             (label) => DropdownMenuItem<String>(
//                               value: label.key,
//                               child: Text(label.key),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     Text(
//                       context.tr.sortBy,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Row(
//                       children: orderOptions
//                           .map(
//                             (order) => Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 4.0,
//                               ),
//                               child: ChoiceChip(
//                                 label: Text(order),
//                                 selected: sortOrder == order,
//                                 onSelected: (_) =>
//                                     setState(() => sortOrder = order),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     const SizedBox(height: 10),

//                     // --- زر التطبيق المحدث ---
//                     ElevatedButton.icon(
//                       onPressed: () async {
//                         final String? genderValue = genders[selectedGender];
//                         final int? specialtyValue =
//                             specialties[selectedSpecialty];

//                         String? finalOrderingParam;
//                         final String? sortValue = sortOptions[sortBy];
//                         if (sortValue != null) {
//                           finalOrderingParam =
//                               (sortOrder == context.tr.descending)
//                               ? '-$sortValue'
//                               : sortValue;
//                         }

//                         double? latitude;
//                         double? longitude;

//                         // 3. استخدام الدالة المساعدة لجلب الموقع
//                         if (selectedLocationType ==
//                             context.tr.currentLocationHint) {
//                           final Position? position =
//                               await _handleLocationPermission(context);
//                           if (position != null) {
//                             latitude = position.latitude;
//                             longitude = position.longitude;
//                           }
//                         }

//                         // استدعاء دالة التحديث في الـ Cubit
//                         // سيتم تمرير الإحداثيات إذا تم الحصول عليها، أو null إذا لم يتم
//                         cubit.updateAndSearch(
//                           gender: genderValue,
//                           specialties: specialtyValue,
//                           distance: selectedDistance,
//                           ordering: finalOrderingParam,
//                           latitude: latitude,
//                           longitude: longitude,
//                         );

//                         if (context.mounted) Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.filter_alt),
//                       label: Text(context.tr.apply),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(50),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }
