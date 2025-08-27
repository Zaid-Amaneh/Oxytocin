import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/file_downloader.dart';
import 'package:oxytocin/features/appointments_management/data/models/attachment_model.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/attachments_manager_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/attachments_manager_state.dart';

class AttachmentsManagerScreenBody extends StatefulWidget {
  const AttachmentsManagerScreenBody({super.key, required this.appointmentId});
  final int appointmentId;

  @override
  State<AttachmentsManagerScreenBody> createState() =>
      _AttachmentsManagerScreenBodyState();
}

class _AttachmentsManagerScreenBodyState
    extends State<AttachmentsManagerScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<AttachmentsManagerCubit>().fetchAttachments(
      appointmentId: widget.appointmentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentsManagerCubit, AttachmentsManagerState>(
      listener: (context, state) {
        if (state.status == AttachmentStatus.error) {
          _showErrorSnackBar(state.errorMessage ?? context.tr.errorUnknown);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            _buildHeader(state),
            Expanded(child: _buildBody(state)),
          ],
        );
      },
    );
  }

  Widget _buildHeader(AttachmentsManagerState state) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF3498DB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.folder_outlined,
              color: Color(0xFF3498DB),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.attachments,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  context.tr.attachmentsCount(state.attachments.length),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          _buildAddButton(state),
        ],
      ),
    );
  }

  Widget _buildAddButton(AttachmentsManagerState state) {
    final canAddMore = state.attachments.length < 5;
    final isLoading = state.status == AttachmentStatus.uploading;

    return ElevatedButton.icon(
      onPressed: (canAddMore && !isLoading) ? _pickFiles : null,
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.add),
      label: Text(isLoading ? context.tr.uploading : context.tr.addFile),
      style: ElevatedButton.styleFrom(
        backgroundColor: canAddMore ? const Color(0xFF27AE60) : Colors.grey,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildBody(AttachmentsManagerState state) {
    if (state.status == AttachmentStatus.loading) {
      return _buildLoadingState();
    }

    if (state.attachments.isEmpty) {
      return _buildEmptyState();
    }

    return _buildAttachmentsList(state);
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3498DB)),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.loadingFiles,
            style: const TextStyle(fontSize: 16, color: Color(0xFF7F8C8D)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.folder_open, size: 64, color: Colors.grey[400]),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.noAttachments,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.addFileHint,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsList(AttachmentsManagerState state) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.attachments.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildAttachmentCard(state.attachments[index], state);
      },
    );
  }

  Widget _buildAttachmentCard(
    AttachmentModel attachment,
    AttachmentsManagerState state,
  ) {
    final isDeleting = state.status == AttachmentStatus.deleting;
    final fileName = _getFileNameFromPath(attachment.document);
    final fileExtension = _getFileExtension(fileName);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Logger().f(attachment.document);
            downloadAndOpenFile(context, attachment.document);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildFileIcon(fileExtension),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2C3E50),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(attachment.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: isDeleting
                      ? null
                      : () => _deleteAttachment(attachment.id),
                  icon: isDeleting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(
                          Icons.delete_outline,
                          color: Color(0xFFE74C3C),
                        ),
                  tooltip: context.tr.deleteFile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileIcon(String extension) {
    IconData iconData;
    Color iconColor;

    switch (extension.toLowerCase()) {
      case 'pdf':
        iconData = Icons.picture_as_pdf;
        iconColor = const Color(0xFFE74C3C);
        break;
      case 'doc':
      case 'docx':
        iconData = Icons.description;
        iconColor = const Color(0xFF2980B9);
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        iconData = Icons.image;
        iconColor = const Color(0xFF27AE60);
        break;
      case 'mp4':
      case 'avi':
      case 'mov':
        iconData = Icons.video_file;
        iconColor = const Color(0xFF8E44AD);
        break;
      default:
        iconData = Icons.insert_drive_file;
        iconColor = const Color(0xFF7F8C8D);
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        List<String> validFiles = [];
        List<String> errors = [];

        final currentState = context.read<AttachmentsManagerCubit>().state;
        final currentFilesCount = currentState.attachments.length;

        for (PlatformFile file in result.files) {
          if (file.size > 7 * 1024 * 1024) {
            errors.add(context.tr.file_size_error(file.name, 7));
            continue;
          }

          if (currentFilesCount + validFiles.length >= 5) {
            errors.add(context.tr.maxFilesError);
            break;
          }

          if (file.path != null) {
            validFiles.add(file.path!);
          }
        }

        if (errors.isNotEmpty) {
          _showErrorDialog(context.tr.uploadAlerts, errors.join('\n'));
        }

        if (validFiles.isNotEmpty) {
          await context.read<AttachmentsManagerCubit>().uploadNewAttachments(
            appointmentId: widget.appointmentId,
            filePaths: validFiles,
          );
        }
      }
    } catch (e) {
      _showErrorSnackBar(context.tr.fileSelectionError);
    }
  }

  Future<void> _deleteAttachment(int attachmentId) async {
    final confirmed = await _showDeleteConfirmation();
    if (confirmed == true) {
      await context.read<AttachmentsManagerCubit>().deleteAttachment(
        appointmentId: widget.appointmentId,
        attachmentId: attachmentId,
      );
    }
  }

  String _getFileNameFromPath(String path) {
    return path.split('/').last;
  }

  String _getFileExtension(String fileName) {
    return fileName.contains('.') ? fileName.split('.').last : '';
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFE74C3C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr.ok),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.tr.deleteConfirmation),
        content: Text(context.tr.deleteConfirmationQuestion),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.tr.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              foregroundColor: Colors.white,
            ),
            child: Text(context.tr.delete),
          ),
        ],
      ),
    );
  }
}
