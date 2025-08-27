import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/profile/data/model/user_profile_model.dart';
import 'package:oxytocin/features/profile/presentation/cubit/profile_edit_cubit.dart';

class ProfileEditForm extends StatefulWidget {
  final UserProfileModel profile;
  final Function(UserProfileModel) onSave;
  final VoidCallback onCancel;
  final bool isLoading;

  const ProfileEditForm({
    super.key,
    required this.profile,
    required this.onSave,
    required this.onCancel,
    required this.isLoading,
  });

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _jobController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _medicalHistoryController;
  late TextEditingController _surgicalHistoryController;
  late TextEditingController _allergiesController;
  late TextEditingController _medicinesController;
  String? _selectedGender;
  DateTime? _selectedBirthDate;
  bool _isSmoker = false;
  bool _isDrinker = false;
  bool _isMarried = false;
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _selectedImage = imageFile;
      });

      context.read<ProfileEditCubit>().setSelectedImage(imageFile);
    }
  }

  Future<void> _takePhotoWithCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _selectedImage = imageFile;
      });

      // ✅ صحح: تحديث الـ Cubit بالصورة
      context.read<ProfileEditCubit>().setSelectedImage(imageFile);
    }
  }

  void _removeProfileImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.profile.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.profile.lastName ?? '',
    );
    _phoneController = TextEditingController(text: widget.profile.phone ?? '');
    _addressController = TextEditingController(
      text: widget.profile.address ?? '',
    );
    _jobController = TextEditingController(text: widget.profile.job ?? '');
    _bloodTypeController = TextEditingController(
      text: widget.profile.bloodType ?? '',
    );
    _medicalHistoryController = TextEditingController(
      text: widget.profile.medicalHistory ?? '',
    );
    _surgicalHistoryController = TextEditingController(
      text: widget.profile.surgicalHistory ?? '',
    );
    _allergiesController = TextEditingController(
      text: widget.profile.allergies ?? '',
    );
    _medicinesController = TextEditingController(
      text: widget.profile.medicines ?? '',
    );
    _selectedGender = widget.profile.gender;
    _selectedBirthDate = widget.profile.birthDate;
    _isSmoker = widget.profile.isSmoker ?? false;
    _isDrinker = widget.profile.isDrinker ?? false;
    _isMarried = widget.profile.isMarried ?? false;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _jobController.dispose();
    _bloodTypeController.dispose();
    _medicalHistoryController.dispose();
    _surgicalHistoryController.dispose();
    _allergiesController.dispose();
    _medicinesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
          _buildEditHeader(),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(24)),
          _buildTextField('الاسم الأول', _firstNameController),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField('الاسم الأخير', _lastNameController),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField(
            'رقم الهاتف',
            _phoneController,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildBirthDatePicker(),

          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField('العنوان', _addressController, maxLines: 2),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField('المهنة', _jobController),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField('فصيلة الدم', _bloodTypeController),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField(
            'التاريخ الطبي',
            _medicalHistoryController,
            maxLines: 3,
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField(
            'التاريخ الجراحي',
            _surgicalHistoryController,
            maxLines: 3,
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField('الحساسية', _allergiesController, maxLines: 2),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildTextField('الأدوية الحالية', _medicinesController, maxLines: 2),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildGenderDropdown(),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          _buildLifestyleSection(),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(32)),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildEditHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: SizeConfig.getProportionateScreenWidth(200),
              height: SizeConfig.getProportionateScreenWidth(200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                    : (widget.profile.image != null &&
                              widget.profile.image!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(widget.profile.image!),
                              fit: BoxFit.cover,
                            )
                          : null),
              ),
              child:
                  _selectedImage == null &&
                      (widget.profile.image == null ||
                          widget.profile.image!.isEmpty)
                  ? Icon(
                      Icons.person,
                      size: SizeConfig.getProportionateScreenWidth(40),
                      color: Colors.grey[600],
                    )
                  : null,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.photo_library,
                            color: AppColors.kPrimaryColor1,
                          ),
                          title: Text('اختر من المعرض'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImageFromGallery();
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.camera_alt,
                            color: AppColors.kPrimaryColor1,
                          ),
                          title: Text('التقاط صورة'),
                          onTap: () {
                            Navigator.pop(context);
                            _takePhotoWithCamera();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: SizeConfig.getProportionateScreenWidth(52),
                height: SizeConfig.getProportionateScreenWidth(52),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor1,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: SizeConfig.getProportionateScreenWidth(16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: 'AlmaraiRegular',
          ),
        ),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : _handleSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor1,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'تاكيد',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'AlmaraiBold',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الجنس',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: 'AlmaraiRegular',
          ),
        ),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.white,
          ),
          items: [
            DropdownMenuItem(value: 'male', child: Text('ذكر')),
            DropdownMenuItem(value: 'female', child: Text('أنثى')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBirthDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تاريخ الميلاد',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: 'AlmaraiRegular',
          ),
        ),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedBirthDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() {
                _selectedBirthDate = date;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.textSecondary),
                SizedBox(width: 8),
                Text(
                  _selectedBirthDate != null
                      ? '${_selectedBirthDate!.year}-${_selectedBirthDate!.month.toString().padLeft(2, '0')}-${_selectedBirthDate!.day.toString().padLeft(2, '0')}'
                      : 'اختر تاريخ الميلاد',
                  style: TextStyle(
                    color: _selectedBirthDate != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLifestyleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نمط الحياة',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: 'AlmaraiRegular',
          ),
        ),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        CheckboxListTile(
          title: Text(
            'مدخن',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: 'AlmaraiRegular',
            ),
          ),
          value: _isSmoker,
          onChanged: (value) {
            setState(() {
              _isSmoker = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: Text(
            'يشرب الكحول',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: 'AlmaraiRegular',
            ),
          ),
          value: _isDrinker,
          onChanged: (value) {
            setState(() {
              _isDrinker = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: Text(
            'متزوج',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: 'AlmaraiRegular',
            ),
          ),
          value: _isMarried,
          onChanged: (value) {
            setState(() {
              _isMarried = value ?? false;
            });
          },
        ),
      ],
    );
  }

  // void _handleSave() {
  //   final updatedProfile = UserProfileModel(
  //     firstName: _firstNameController.text.trim(),
  //     lastName: _lastNameController.text.trim(),
  //     phone: _phoneController.text.trim(),
  //     address: _addressController.text.trim(),
  //     job: _jobController.text.trim(),
  //     bloodType: _bloodTypeController.text.trim(),
  //     medicalHistory: _medicalHistoryController.text.trim(),
  //     surgicalHistory: _surgicalHistoryController.text.trim(),
  //     allergies: _allergiesController.text.trim(),
  //     medicines: _medicinesController.text.trim(),
  //     gender: _selectedGender,
  //     birthDate: widget.profile.birthDate,
  //     isSmoker: _isSmoker,
  //     isDrinker: _isDrinker,
  //     isMarried: _isMarried,
  //     longitude: widget.profile.longitude,
  //     latitude: widget.profile.latitude,
  //     image: widget.profile.image,
  //   );
  //   final Map<String, dynamic> dataToSend = {};
  //   if (_selectedImage != null) {
  //     dataToSend['image'] = _selectedImage;
  //   }
  //   context.read<ProfileEditCubit>().updateProfileWithImage(_selectedImage!);
  //   widget.onSave(updatedProfile);
  // }

  void _handleSave() {
    final cubit = context.read<ProfileEditCubit>();

    final updatedProfile = UserProfileModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      job: _jobController.text.trim(),
      bloodType: _bloodTypeController.text.trim(),
      medicalHistory: _medicalHistoryController.text.trim(),
      surgicalHistory: _surgicalHistoryController.text.trim(),
      allergies: _allergiesController.text.trim(),
      medicines: _medicinesController.text.trim(),
      gender: _selectedGender,
      birthDate:
          _selectedBirthDate, // ✅ صحح: استخدم _selectedBirthDate بدل widget.profile.birthDate
      isSmoker: _isSmoker,
      isDrinker: _isDrinker,
      isMarried: _isMarried,
      longitude: widget.profile.longitude,
      latitude: widget.profile.latitude,
      image: null,
    );
    if (_selectedImage != null) {
      cubit.setSelectedImage(_selectedImage!);
    }
    // ✅ أرسل الملف الشخصي المحدث إلى الـ Cubit
    context.read<ProfileEditCubit>().updateProfile(updatedProfile);
  }
}
