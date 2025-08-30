import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';

class _QueueStateContainer extends StatelessWidget {
  final Widget child;

  const _QueueStateContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double baseWidth = 375.0;
        final double scale = constraints.maxWidth / baseWidth;

        return Container(
          width: constraints.maxWidth,
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight * 0.3,
            maxHeight: constraints.maxHeight * 0.7,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 15,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32 * scale,
              vertical: 24 * scale,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class QueueLoadingState extends StatelessWidget {
  const QueueLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return _QueueStateContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double baseWidth = 375.0;
          final double scale = constraints.maxWidth / baseWidth;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 80 * scale,
                    height: 80 * scale,
                    decoration: const BoxDecoration(
                      color: Color(0x1A3498DB),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 50 * scale,
                    height: 50 * scale,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF3498DB),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.access_time,
                    color: const Color(0xFF3498DB),
                    size: 24 * scale,
                  ),
                ],
              ),
              SizedBox(height: 24 * scale),
              Text(
                context.tr.queueLoading,
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              SizedBox(height: 8 * scale),
              Text(
                context.tr.pleaseWait,
                style: TextStyle(fontSize: 14 * scale, color: Colors.grey[600]),
              ),
              SizedBox(height: 32 * scale),
              const _PulsatingDots(),
            ],
          );
        },
      ),
    );
  }
}

class QueueErrorState extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;

  const QueueErrorState({super.key, this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return _QueueStateContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double baseWidth = 375.0;
          final double scale = constraints.maxWidth / baseWidth;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100 * scale,
                height: 100 * scale,
                decoration: const BoxDecoration(
                  color: Color(0x1AE74C3C),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70 * scale,
                      height: 70 * scale,
                      decoration: const BoxDecoration(
                        color: Color(0x33E74C3C),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 40 * scale,
                      color: const Color(0xFFE74C3C),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * scale),
              Text(
                context.tr.queueLoadFailed,
                style: TextStyle(
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              SizedBox(height: 12 * scale),
              Text(
                errorMessage ?? context.tr.serverError,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32 * scale),
              if (onRetry != null)
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 20),
                  label: Text(context.tr.retry),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3498DB),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24 * scale,
                      vertical: 12 * scale,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(fontSize: 14 * scale),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class QueueEmptyState extends StatelessWidget {
  final String doctorName;

  const QueueEmptyState({super.key, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return _QueueStateContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double baseWidth = 375.0;
          final double scale = constraints.maxWidth / baseWidth;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120 * scale,
                height: 120 * scale,
                decoration: const BoxDecoration(
                  color: Color(0x1A27AE60),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 90 * scale,
                      height: 90 * scale,
                      decoration: const BoxDecoration(
                        color: Color(0x3327AE60),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(
                      Icons.event_available,
                      size: 50 * scale,
                      color: const Color(0xFF27AE60),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * scale),
              Text(
                context.tr.noQueue,
                style: TextStyle(
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              SizedBox(height: 12 * scale),
              Text(
                context.tr.doctorUnavailable(doctorName),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32 * scale),
              Container(
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  color: const Color(0x0D3498DB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0x333498DB)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: const Color(0xFF3498DB),
                      size: 20 * scale,
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Text(
                        context.tr.checkLater,
                        style: TextStyle(
                          fontSize: 13 * scale,
                          color: const Color(0xCC3498DB),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class QueueUnknownState extends StatelessWidget {
  const QueueUnknownState({super.key});

  @override
  Widget build(BuildContext context) {
    return _QueueStateContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double baseWidth = 375.0;
          final double scale = constraints.maxWidth / baseWidth;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100 * scale,
                height: 100 * scale,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70 * scale,
                      height: 70 * scale,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(51),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(
                      Icons.help_outline,
                      size: 40 * scale,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * scale),
              Text(
                context.tr.unknownState,
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 12 * scale),
              Text(
                context.tr.unexpectedError,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14 * scale, color: Colors.grey[600]),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PulsatingDots extends StatefulWidget {
  const _PulsatingDots();

  @override
  State<_PulsatingDots> createState() => _PulsatingDotsState();
}

class _PulsatingDotsState extends State<_PulsatingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    const double intervalStart = 0.0;
    const double intervalEnd = 0.6;
    const double step = 0.2;

    for (int i = 0; i < 3; i++) {
      final double begin = intervalStart + (i * step);
      final double end = intervalEnd + (i * step);
      _animations.add(
        Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(begin, end, curve: Curves.easeInOut),
          ),
        ),
      );
    }

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return FadeTransition(
          opacity: _animations[index],
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xB33498DB),
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}
