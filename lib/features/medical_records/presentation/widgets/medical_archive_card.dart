import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class MedicalArchiveCard extends StatefulWidget {
  final String visitDate;
  final String visitTime;
  final String caseHistory;
  final String mainComplaint;
  final String? recommendations;
  final Map<String, String>? vitalSigns;
  final double paid;
  final double cost;
  final double remaining;

  const MedicalArchiveCard({
    super.key,
    required this.visitDate,
    required this.visitTime,
    required this.caseHistory,
    required this.mainComplaint,
    this.recommendations,
    this.vitalSigns,
    required this.paid,
    required this.cost,
    required this.remaining,
  });

  @override
  State<MedicalArchiveCard> createState() => _MedicalArchiveCardState();
}

class _MedicalArchiveCardState extends State<MedicalArchiveCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: _toggleExpansion,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.blue[600],
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.visitDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        color: Colors.blue[600],
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _convertTo12Hour(widget.visitTime, context),
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.expand_more, color: Colors.blue[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildInfoSection(
                title: context.tr.mainComplaint,
                content: widget.mainComplaint,
                icon: Icons.medical_services,
              ),

              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    _buildInfoSection(
                      title: context.tr.medicalSummary,
                      content: widget.caseHistory,
                      icon: Icons.history,
                    ),

                    const SizedBox(height: 16),

                    if (widget.vitalSigns != null &&
                        widget.vitalSigns!.isNotEmpty)
                      _buildVitalSignsSection(),

                    const SizedBox(height: 16),

                    if (widget.recommendations != null &&
                        widget.recommendations!.isNotEmpty)
                      _buildInfoSection(
                        title: context.tr.doctorRecommendations,
                        content: widget.recommendations!,
                        icon: Icons.assignment,
                      ),

                    const SizedBox(height: 16),

                    _buildFinancialSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue[600], size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          width: double.infinity,
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVitalSignsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.favorite, color: Colors.red[600], size: 20),
            const SizedBox(width: 8),
            Text(
              context.tr.vitalSigns,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red[200]!),
          ),
          child: Column(
            children: widget.vitalSigns!.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: Colors.green[600],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              context.tr.financialInfo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Column(
            children: [
              _buildFinancialRow(
                context.tr.sessionCost,
                widget.cost,
                Colors.blue[700]!,
              ),
              const SizedBox(height: 8),
              _buildFinancialRow(
                context.tr.paidAmount,
                widget.paid,
                Colors.green[700]!,
              ),
              const SizedBox(height: 8),
              _buildFinancialRow(
                context.tr.remainingAmount,
                widget.remaining,
                widget.remaining > 0 ? Colors.red[700]! : Colors.green[700]!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialRow(String label, double amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        Text(
          amount.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
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
