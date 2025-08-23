import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_state.dart';
import 'package:oxytocin/features/profile/presentation/widget/profile_header_card.dart';

class SimpleProfileView extends StatefulWidget {
  const SimpleProfileView({super.key});

  @override
  State<SimpleProfileView> createState() => _SimpleProfileViewState();
}

class _SimpleProfileViewState extends State<SimpleProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getProfile();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(fontFamily: 'AlmaraiBold', color: Colors.white),
        ),
        backgroundColor: const Color(0xFF344CB7),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('خطأ: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ProfileHeaderCard(profile: state.profile),

                  const SizedBox(height: 24),
                  _buildInfoCard(
                    title: 'معلومات شخصية',
                    children: [
                      _buildInfoRow('الاسم الكامل', state.profile.fullName),
                      _buildInfoRow('العمر', '${state.profile.age} عاماً'),
                      _buildInfoRow(
                        'الجنس',
                        state.profile.gender ?? 'غير محدد',
                      ),
                      _buildInfoRow(
                        'رقم الهاتف',
                        state.profile.phone ?? 'غير محدد',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildInfoCard(
                    title: 'معلومات طبية',
                    children: [
                      _buildInfoRow(
                        'فصيلة الدم',
                        state.profile.bloodType ?? 'غير محدد',
                      ),
                      _buildInfoRow('المهنة', state.profile.job ?? 'غير محدد'),
                      _buildInfoRow(
                        'العنوان',
                        state.profile.address ?? 'غير محدد',
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'حدث خطأ في تحميل البيانات',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'AlmaraiBold',
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileCubit>().getProfile();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                'اضغط على زر التحميل لبدء تحميل البيانات',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'AlmaraiBold',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'AlmaraiRegular',
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'AlmaraiBold',
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
