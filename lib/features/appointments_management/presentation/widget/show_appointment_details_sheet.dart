import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/appointments_management/data/models/appointment_model.dart';

void showAppointmentDetailsSheet(
  BuildContext context,
  AppointmentModel appointment,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AppointmentDetailsModal(appointment: appointment),
  );
}

class AppointmentDetailsModal extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentDetailsModal({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    return Container(
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr.appointmentDetails,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey[200], height: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(
                    icon: Icons.person,
                    title: context.tr.doctorInfo,
                    children: [
                      _buildInfoRow(
                        context.tr.doctorName,
                        appointment.clinic.doctor.user.fullName,
                        width,
                        false,
                      ),
                      _buildInfoRow(
                        context.tr.specialization,
                        Helper.isArabic(context)
                            ? appointment
                                  .clinic
                                  .doctor
                                  .mainSpecialty
                                  .specialty
                                  .nameAr
                            : appointment
                                  .clinic
                                  .doctor
                                  .mainSpecialty
                                  .specialty
                                  .nameEn,
                        width,
                        false,
                      ),
                      _buildInfoRow(
                        context.tr.clinicNumber,
                        appointment.clinic.phone,
                        width,
                        true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildInfoSection(
                    icon: Icons.location_on,
                    title: context.tr.clinicLocation,
                    children: [
                      _buildInfoRow(
                        context.tr.address,
                        appointment.clinic.address,
                        width,
                        false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildInfoSection(
                    icon: Icons.calendar_today,
                    title: context.tr.appointmentInfo,
                    children: [
                      _buildInfoRow(
                        context.tr.date,
                        '${_getDayName(appointment.visitDate, context)} / ${appointment.visitDate}',
                        width,
                        false,
                      ),
                      _buildInfoRow(
                        context.tr.time,
                        _convertTo12Hour(appointment.visitTime, context),
                        width,
                        false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildNotesSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    double width,
    bool textDirection,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textDirection: textDirection ? TextDirection.ltr : null,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note_alt, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Text(
                context.tr.patientNotes,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          appointment.notes.isNotEmpty
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Text(
                    appointment.notes,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.grey[500],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.tr.noNotes,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  String _getDayName(String date, BuildContext context) {
    final weekdays = [
      context.tr.monday,
      context.tr.tuesday,
      context.tr.wednesday,
      context.tr.thursday,
      context.tr.friday,
      context.tr.saturday,
      context.tr.sunday,
    ];

    final parsedDate = DateTime.parse(date);

    return weekdays[parsedDate.weekday - 1];
  }

  String _convertTo12Hour(String time24, BuildContext context) {
    final parts = time24.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];

    if (hour == 0) {
      return '12:$minute ${context.tr.am}';
    } else if (hour < 12) {
      return '$hour:$minute ${context.tr.am}';
    } else if (hour == 12) {
      return '12:$minute ${context.tr.pm}';
    } else {
      return '${hour - 12}:$minute ${context.tr.pm}';
    }
  }
}
