import 'package:flutter/material.dart';

// حالات المرضى في الطابور
enum PatientStatus {
  completed, // تم الانتهاء من الموعد
  inProgress, // يتم فحصه الآن
  waiting, // ينتظر دوره
  absent, // غائب عن موعده
  cancelled, // ألغى موعده
}

// نموذج بيانات المريض في الطابور
class QueuePatient {
  final String appointmentTime; // وقت الموعد المحجوز
  final String? actualEntryTime; // الوقت الفعلي للدخول (null إذا لم يدخل بعد)
  final String? actualExitTime; // الوقت الفعلي للخروج (null إذا لم ينته بعد)
  final PatientStatus status;
  final int orderNumber;

  QueuePatient({
    required this.appointmentTime,
    this.actualEntryTime,
    this.actualExitTime,
    required this.status,
    required this.orderNumber,
  });

  // حساب مدة الانتظار الفعلية (بالدقائق)
  int? get actualWaitingDuration {
    if (actualEntryTime == null) return null;
    // هنا يمكن إضافة منطق حساب الفرق بين الوقت المحجوز والدخول الفعلي
    // مثال مبسط - يمكن تطويره حسب تنسيق التاريخ المستخدم
    return null; // سيتم حسابه في التطبيق الفعلي
  }

  // حساب مدة الفحص الفعلية (بالدقائق)
  int? get actualExaminationDuration {
    if (actualEntryTime == null || actualExitTime == null) return null;
    // هنا يمكن إضافة منطق حساب الفرق بين الدخول والخروج
    // مثال مبسط - يمكن تطويره حسب تنسيق التاريخ المستخدم
    return null; // سيتم حسابه في التطبيق الفعلي
  }
}

void showQueueStatusSheet(
  BuildContext context, {
  required List<QueuePatient> queuePatients,
  required int currentPatientOrder,
  required int estimatedWaitingMinutes,
  required String doctorName,
  int? averageExaminationTime, // متوسط وقت الفحص المحسوب من البيانات السابقة
  int? averageDelayTime, // متوسط التأخير المحسوب من البيانات السابقة
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => QueueStatusModal(
      queuePatients: queuePatients,
      currentPatientOrder: currentPatientOrder,
      estimatedWaitingMinutes: estimatedWaitingMinutes,
      doctorName: doctorName,
      averageExaminationTime: averageExaminationTime,
      averageDelayTime: averageDelayTime,
    ),
  );
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

    // Animation للنبضة
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    // Animation لشريط التقدم
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
          // مقبض السحب
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          // العنوان
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'طابور الانتظار',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'doctorName',
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

          // شريط التقدم والانتظار مع الإحصائيات المحسنة
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                // معلومات الانتظار مع التأثيرات
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
                            // الصف الأول - الوقت المتوقع ورقم المريض
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
                                        'الوقت المتوقع للانتظار',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${widget.estimatedWaitingMinutes} دقيقة تقريباً',
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
                                    'رقمك: ${widget.currentPatientOrder}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // الصف الثاني - إحصائيات إضافية (إذا توفرت)
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
                                              'متوسط الفحص: ${widget.averageExaminationTime}د',
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
                                              'متوسط التأخير: ${widget.averageDelayTime}د',
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

                // الشريط الزمني مع التقدم
                _buildTimelineProgress(),
              ],
            ),
          ),

          // قائمة المرضى
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

          // زر الإغلاق
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
                  'إغلاق',
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
    // حساب المرضى الذين تم الانتهاء من مواعيدهم (مكتمل + غائب + ملغى)
    final processedPatients = widget.queuePatients
        .where(
          (p) =>
              p.status == PatientStatus.completed ||
              p.status == PatientStatus.absent ||
              p.status == PatientStatus.cancelled,
        )
        .length;

    // إضافة المريض الحالي إذا كان يُفحص الآن
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
              'تقدم الطابور',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Text(
              '$effectiveProgress من $totalPatients',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // شريط التقدم المتحرك
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
                  // نقطة متحركة تشير للموقع الحالي
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

        // مؤشرات الحالة
        Row(
          children: [
            _buildStatusIndicator(Colors.green[600]!, 'مكتمل'),
            const SizedBox(width: 16),
            _buildStatusIndicator(Colors.orange[500]!, 'موقعك'),
            const SizedBox(width: 16),
            _buildStatusIndicator(Colors.grey[400]!, 'في الانتظار'),
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
                  // رقم المريض مع تأثير متحرك
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

                  // معلومات المريض
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'مريض رقم ${patient.orderNumber}',
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
                                child: const Text(
                                  'أنت',
                                  style: TextStyle(
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
                              'الموعد: ${patient.appointmentTime}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            // عرض الأوقات الفعلية للمرضى المكتملين
                            if (patient.status == PatientStatus.completed &&
                                patient.actualEntryTime != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                'دخل: ${patient.actualEntryTime}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.green[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (patient.actualExitTime != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  'خرج: ${patient.actualExitTime}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                            // عرض وقت الدخول للمريض الحالي إذا كان يُفحص
                            if (patient.status == PatientStatus.inProgress &&
                                patient.actualEntryTime != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                'دخل: ${patient.actualEntryTime}',
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

                  // حالة المريض مع تأثيرات
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
          'text': 'انتهى',
        };
      case PatientStatus.inProgress:
        return {
          'icon': Icons.medical_services,
          'color': Colors.orange[600],
          'text': 'يُفحص الآن',
        };
      case PatientStatus.waiting:
        return {
          'icon': Icons.schedule,
          'color': Colors.blue[600],
          'text': 'ينتظر',
        };
      case PatientStatus.absent:
        return {
          'icon': Icons.person_off,
          'color': Colors.red[600],
          'text': 'غائب',
        };
      case PatientStatus.cancelled:
        return {
          'icon': Icons.cancel,
          'color': Colors.grey[600],
          'text': 'ألغى',
        };
    }
  }
}
