import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:toastification/toastification.dart';

class UploadFilesWidget extends StatefulWidget {
  final Function(List<File>)? onFilesSelected;
  final int maxFiles;
  final int maxFileSizeInMB;

  const UploadFilesWidget({
    super.key,
    this.onFilesSelected,
    this.maxFiles = 5,
    this.maxFileSizeInMB = 7,
  });

  @override
  State<UploadFilesWidget> createState() => _UploadFilesWidgetState();
}

class _UploadFilesWidgetState extends State<UploadFilesWidget>
    with SingleTickerProviderStateMixin {
  List<File> selectedFiles = [];
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }

  Color _getFileTypeColor(String extension) {
    switch (extension) {
      case 'pdf':
        return const Color(0xFFE53E3E);
      case 'doc':
      case 'docx':
        return const Color(0xFF2B6CB0);
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return const Color(0xFF38A169);
      case 'txt':
        return const Color(0xFF718096);
      default:
        return AppColors.kPrimaryColor1;
    }
  }

  IconData _getFileTypeIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }

  Future<void> _pickFiles() async {
    if (selectedFiles.length >= widget.maxFiles) {
      Helper.customToastification(
        context: context,
        description: context.tr.max_files_error(widget.maxFiles),
        type: ToastificationType.warning,
        title: context.tr.error,
        seconds: 5,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        List<File> newFiles = [];

        for (PlatformFile file in result.files) {
          if (file.path != null) {
            File newFile = File(file.path!);
            int fileSizeInMB = newFile.lengthSync() ~/ (1024 * 1024);
            if (fileSizeInMB > widget.maxFileSizeInMB) {
              if (mounted) {
                Helper.customToastification(
                  context: context,
                  description: context.tr.file_size_error(
                    file.name,
                    widget.maxFileSizeInMB,
                  ),
                  type: ToastificationType.warning,
                  title: context.tr.error,
                  seconds: 5,
                );
              }
              continue;
            }
            bool fileExists = selectedFiles.any(
              (existingFile) => existingFile.path == newFile.path,
            );

            if (!fileExists) {
              newFiles.add(newFile);
            }
          }
        }
        if (selectedFiles.length + newFiles.length > widget.maxFiles) {
          int allowedCount = widget.maxFiles - selectedFiles.length;
          newFiles = newFiles.take(allowedCount).toList();
          if (mounted) {
            Helper.customToastification(
              context: context,
              description: context.tr.allowed_files_limit(
                allowedCount,
                widget.maxFiles,
              ),
              type: ToastificationType.warning,
              title: context.tr.error,
              seconds: 5,
            );
          }
        }

        setState(() {
          selectedFiles.addAll(newFiles);
        });

        widget.onFilesSelected?.call(selectedFiles);
      }
    } catch (e) {
      Logger().e(e);
      if (mounted) {
        Helper.customToastification(
          context: context,
          description: context.tr.file_pick_error,
          type: ToastificationType.warning,
          title: context.tr.error,
          seconds: 5,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
    widget.onFilesSelected?.call(selectedFiles);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) => _animationController.reverse(),
            onTapCancel: () => _animationController.reverse(),
            onTap: isLoading ? null : _pickFiles,
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.kPrimaryColor1.withValues(alpha: 0.3),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kPrimaryColor1.withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        if (isLoading)
                          Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor1.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.kPrimaryColor1,
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor1.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.cloud_upload_outlined,
                              size: 30,
                              color: AppColors.kPrimaryColor1,
                            ),
                          ),
                        const SizedBox(height: 12),
                        Text(
                          isLoading
                              ? context.tr.loading
                              : context.tr.tap_to_select_files,
                          style: AppStyles.almaraiBold(context).copyWith(
                            color: AppColors.kPrimaryColor1,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.tr.upload_hint(
                            widget.maxFiles,
                            widget.maxFileSizeInMB,
                          ),
                          style: AppStyles.almaraiBold(context).copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.tr.supported_formats,
                          style: AppStyles.almaraiBold(context).copyWith(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.7,
                            ),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (selectedFiles.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor1.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                context.tr.files_progress(
                  selectedFiles.length,
                  widget.maxFiles,
                ),
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 12),
              ),
            ),
          ],
          if (selectedFiles.isNotEmpty) ...[
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedFiles.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final file = selectedFiles[index];
                final fileName = file.path.split('/').last;
                final fileSize = _getFileSize(file.lengthSync());
                final fileExtension = _getFileExtension(fileName);
                final fileColor = _getFileTypeColor(fileExtension);
                final fileIcon = _getFileTypeIcon(fileExtension);

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: fileColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: fileColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(fileIcon, color: fileColor, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fileName,
                              style: AppStyles.almaraiBold(context).copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              fileSize,
                              style: AppStyles.almaraiBold(context).copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeFile(index),
                        icon: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFE53E3E,
                            ).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Color(0xFFE53E3E),
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
