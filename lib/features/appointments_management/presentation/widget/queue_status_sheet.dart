import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/appointments_management/data/models/queue_display_models.dart';
import 'package:oxytocin/features/appointments_management/data/services/queue_service.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/queue_cubit.dart';
import 'package:oxytocin/features/appointments_management/presentation/viewmodels/queue_state.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/queue_mapper.dart';
import 'package:oxytocin/features/appointments_management/presentation/widget/queue_states.dart';

void showQueueStatusSheet({
  required BuildContext context,
  required int appointmentId,
  required String doctorName,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BlocProvider(
        create: (context) => QueueCubit(QueueService(http.Client())),
        child: QueueStatusSheetContent(
          appointmentId: appointmentId,
          doctorName: doctorName,
        ),
      );
    },
  );
}

class QueueStatusSheetContent extends StatefulWidget {
  final int appointmentId;
  final String doctorName;

  const QueueStatusSheetContent({
    super.key,
    required this.appointmentId,
    required this.doctorName,
  });

  @override
  State<QueueStatusSheetContent> createState() =>
      _QueueStatusSheetContentState();
}

class _QueueStatusSheetContentState extends State<QueueStatusSheetContent> {
  @override
  void initState() {
    super.initState();
    context.read<QueueCubit>().fetchAppointmentQueue(
      appointmentId: widget.appointmentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueCubit, QueueState>(
      builder: (context, state) {
        if (state is QueueLoading) {
          return const QueueLoadingState();
        } else if (state is QueueError) {
          return QueueErrorState(
            errorMessage: context.tr.unexpectedError,
            onRetry: () {
              context.read<QueueCubit>().fetchAppointmentQueue(
                appointmentId: widget.appointmentId,
              );
            },
          );
        } else if (state is QueueLoaded) {
          if (state.queueResponse.queue.isEmpty) {
            return QueueEmptyState(doctorName: widget.doctorName);
          } else {
            final mapper = QueueMapper();
            final queuePatients = mapper.mapQueueItemsToQueuePatients(
              state.queueResponse.queue,
            );
            final int currentPatientOrder = queuePatients
                .firstWhere(
                  (p) => p.status == PatientStatus.waiting,
                  orElse: () => QueuePatient(
                    orderNumber: queuePatients.length + 1,
                    appointmentTime: '',
                    status: PatientStatus.waiting,
                  ),
                )
                .orderNumber;

            List<Map<String, String>> averageExaminationTimeMap = [];
            List<Map<String, String>> averageDelayTimeMap = [];

            for (var i in state.queueResponse.queue) {
              if (i.status == "completed") {
                averageDelayTimeMap.add({
                  "actual": i.actualStartTime!,
                  "expected": i.visitTime,
                });
              }
            }

            for (var i in state.queueResponse.queue) {
              if (i.status == "completed") {
                averageExaminationTimeMap.add({
                  "exit": i.actualEndTime!,
                  "enter": i.actualStartTime!,
                });
              }
            }

            final averageExaminationTime = mapper
                .calculateAverageExaminationTime(averageExaminationTimeMap);
            final averageDelayTime = mapper.calculateAverageDelay(
              averageDelayTimeMap,
            );

            return QueueStatusModal(
              queuePatients: queuePatients,
              currentPatientOrder: currentPatientOrder,
              estimatedWaitingMinutes: state.queueResponse.estimatedWaitMinutes,
              doctorName: widget.doctorName,
              averageExaminationTime: averageExaminationTime.toInt(),
              averageDelayTime: averageDelayTime.toInt(),
            );
          }
        }

        return const QueueUnknownState();
      },
    );
  }
}

class QueueStatusModal extends StatefulWidget {
  final List<QueuePatient> queuePatients;
  final int currentPatientOrder;
  final int estimatedWaitingMinutes;
  final String doctorName;
  final int? averageExaminationTime;
  final int? averageDelayTime;

  const QueueStatusModal({
    super.key,
    required this.queuePatients,
    required this.currentPatientOrder,
    required this.estimatedWaitingMinutes,
    required this.doctorName,
    this.averageExaminationTime,
    this.averageDelayTime,
  });

  @override
  State<QueueStatusModal> createState() => _QueueStatusModalState();
}

class _QueueStatusModalState extends State<QueueStatusModal>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _progressController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.waitingQueue,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      widget.doctorName,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey[200], height: 1),

          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale:
                          widget.queuePatients.any(
                            (p) =>
                                p.orderNumber == widget.currentPatientOrder &&
                                p.status == PatientStatus.inProgress,
                          )
                          ? _pulseAnimation.value
                          : 1.0,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[50]!, Colors.blue[100]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blue[200]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[600],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.tr.expectedWaitTime,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        context.tr.estimatedWait(
                                          widget.estimatedWaitingMinutes,
                                        ),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[600],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    context.tr.yourNumber(
                                      widget.currentPatientOrder,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (widget.averageExaminationTime != null ||
                                widget.averageDelayTime != null)
                              Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.blue[100]!,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        if (widget.averageExaminationTime !=
                                            null) ...[
                                          Icon(
                                            Icons.timer,
                                            color: Colors.blue[600],
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              context.tr.averageExamination(
                                                widget.averageExaminationTime!,
                                              ),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                        if (widget.averageDelayTime !=
                                            null) ...[
                                          if (widget.averageExaminationTime !=
                                              null)
                                            Container(
                                              width: 1,
                                              height: 14,
                                              color: Colors.grey[300],
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                  ),
                                            ),
                                          Icon(
                                            Icons.schedule,
                                            color: Colors.orange[600],
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              context.tr.averageDelay(
                                                widget.averageDelayTime!,
                                              ),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                _buildTimelineProgress(),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: widget.queuePatients.length,
              itemBuilder: (context, index) {
                final patient = widget.queuePatients[index];
                final isCurrentPatient =
                    patient.orderNumber == widget.currentPatientOrder;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  curve: Curves.easeOutBack,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: _buildPatientCard(patient, isCurrentPatient, index),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  context.tr.close,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineProgress() {
    final totalPatients = widget.queuePatients.length;
    final processedPatients = widget.queuePatients
        .where(
          (p) =>
              p.status == PatientStatus.completed ||
              p.status == PatientStatus.absent ||
              p.status == PatientStatus.cancelled,
        )
        .length;

    final currentPatientInProgress = widget.queuePatients.any(
      (p) =>
          p.orderNumber == widget.currentPatientOrder &&
          p.status == PatientStatus.inProgress,
    );

    final effectiveProgress =
        processedPatients + (currentPatientInProgress ? 1 : 0);

    final currentIndex = widget.queuePatients.indexWhere(
      (p) => p.orderNumber == widget.currentPatientOrder,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr.queueProgressText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Text(
              context.tr.queueProgress(effectiveProgress, totalPatients),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),

        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            final progress = effectiveProgress / totalPatients;
            final animatedProgress = progress * _progressAnimation.value;

            return Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    width:
                        MediaQuery.of(context).size.width *
                        0.8 *
                        animatedProgress,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[400]!, Colors.blue[600]!],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  if (currentIndex >= 0)
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      left:
                          (currentIndex / totalPatients) *
                              (MediaQuery.of(context).size.width * 0.8) -
                          6,
                      top: -2,
                      child: AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 + (_pulseAnimation.value - 1.0) * 0.3,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.orange[500],
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withValues(alpha: 0.4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            _buildStatusIndicator(Colors.blue[600]!, context.tr.completed),
            const SizedBox(width: 16),
            _buildStatusIndicator(Colors.orange[500]!, context.tr.yourPosition),
            const SizedBox(width: 16),
            _buildStatusIndicator(Colors.grey[400]!, context.tr.inQueue),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildPatientCard(
    QueuePatient patient,
    bool isCurrentPatient,
    int index,
  ) {
    final statusInfo = _getStatusInfo(patient.status);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isCurrentPatient ? Colors.blue[50] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCurrentPatient
                      ? Colors.blue[300]!
                      : Colors.grey[200]!,
                  width: isCurrentPatient ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCurrentPatient
                          ? Colors.blue[600]
                          : statusInfo['color'],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: patient.status == PatientStatus.inProgress
                          ? [
                              BoxShadow(
                                color: Colors.orange.withValues(alpha: 0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${patient.orderNumber}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.tr.patientNumber(patient.orderNumber),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isCurrentPatient
                                      ? Colors.blue[800]
                                      : Colors.grey[800],
                                ),
                              ),
                            ),
                            if (isCurrentPatient)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[600],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  context.tr.you,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr.appointmentAt(
                                _convertTo12Hour(
                                  patient.appointmentTime,
                                  context,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (patient.status == PatientStatus.completed &&
                                patient.actualEntryTime != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                context.tr.enteredAt(
                                  _convertTo12Hour(
                                    patient.actualEntryTime!,
                                    context,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.green[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (patient.actualExitTime != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  context.tr.exitedAt(
                                    _convertTo12Hour(
                                      patient.actualExitTime!,
                                      context,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                            if (patient.status == PatientStatus.inProgress &&
                                patient.actualEntryTime != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                context.tr.enteredAt(
                                  _convertTo12Hour(
                                    patient.actualEntryTime!,
                                    context,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.orange[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      patient.status == PatientStatus.inProgress
                          ? AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Icon(
                                    statusInfo['icon'],
                                    color: statusInfo['color'],
                                    size: 24,
                                  ),
                                );
                              },
                            )
                          : Icon(
                              statusInfo['icon'],
                              color: statusInfo['color'],
                              size: 24,
                            ),
                      const SizedBox(height: 4),
                      Text(
                        statusInfo['text'],
                        style: TextStyle(
                          fontSize: 10,
                          color: statusInfo['color'],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> _getStatusInfo(PatientStatus status) {
    switch (status) {
      case PatientStatus.completed:
        return {
          'icon': Icons.check_circle,
          'color': Colors.green[600],
          'text': context.tr.finished,
        };
      case PatientStatus.inProgress:
        return {
          'icon': Icons.medical_services,
          'color': Colors.orange[600],
          'text': context.tr.inExamination,
        };
      case PatientStatus.waiting:
        return {
          'icon': Icons.schedule,
          'color': Colors.blue[600],
          'text': context.tr.waiting,
        };
      case PatientStatus.absent:
        return {
          'icon': Icons.person_off,
          'color': Colors.red[600],
          'text': context.tr.absent,
        };
      case PatientStatus.cancelled:
        return {
          'icon': Icons.cancel,
          'color': Colors.grey[600],
          'text': context.tr.canceled,
        };
    }
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
