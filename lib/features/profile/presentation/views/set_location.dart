import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_info_cubit.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  final TextEditingController _locationController = TextEditingController();
  String _locationName = "";
  double? _latitude;
  double? _longitude;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void sendLocation() async {
    if (_locationName.isEmpty || _latitude == null || _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال الموقع وتحديده على الخريطة')),
      );
      return;
    }

    // خزّن القيم في Cubit
    context.read<ProfileInfoCubit>().setLocation(_locationName);
    context.read<ProfileInfoCubit>().setLatitude(_latitude.toString());
    context.read<ProfileInfoCubit>().setLongitude(_longitude.toString());

    await context.read<ProfileInfoCubit>().submitMedicalInfo();
    context.read<ProfileInfoCubit>();

    final state = context.read<ProfileInfoCubit>().state;
    if (state.isSuccess) {
      context.pushNamed(RouteNames.upload);
    } else if (state.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              "لنكن أقرب إليك",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "أدخل موقعك وحدده على الخريطة.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1A237E),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _locationController,
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {
                      _locationName = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF1A237E),
                    ),
                    hintText: "موقعك الحالي",
                    hintStyle: const TextStyle(
                      color: Color(0xFF1A237E),
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "اكتب عنوانك أو اسم منطقتك (مثال: شارع بغداد).",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Icon(Icons.map, size: 60, color: Colors.grey[400]),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "حرّك الخريطة أو استخدم الموقع الحالي لتحديد موقعك بدقة",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/${RouteNames.congratView}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "ابدأ الآن",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1A237E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "عودة",
                      style: TextStyle(fontSize: 16, color: Color(0xFF1A237E)),
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
