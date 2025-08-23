import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_back_button.dart';

class AllAppointmentMonthAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const AllAppointmentMonthAppBar({
    super.key,
    this.backgroundColor = AppColors.kPrimaryColor1,
    this.textColor = Colors.black,
    this.onMonthSelected,
  });

  final Color backgroundColor;
  final Color textColor;
  final Function(DateTime)? onMonthSelected;

  @override
  State<AllAppointmentMonthAppBar> createState() =>
      _AllAppointmentMonthAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _AllAppointmentMonthAppBarState extends State<AllAppointmentMonthAppBar> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  String getLocalizedMonthName(BuildContext context, int month) {
    switch (month) {
      case 1:
        return context.tr.january;
      case 2:
        return context.tr.february;
      case 3:
        return context.tr.march;
      case 4:
        return context.tr.april;
      case 5:
        return context.tr.may;
      case 6:
        return context.tr.june;
      case 7:
        return context.tr.july;
      case 8:
        return context.tr.august;
      case 9:
        return context.tr.september;
      case 10:
        return context.tr.october;
      case 11:
        return context.tr.november;
      case 12:
        return context.tr.december;
      default:
        return '';
    }
  }

  List<String> getLocalizedMonths(BuildContext context) {
    return [
      context.tr.january,
      context.tr.february,
      context.tr.march,
      context.tr.april,
      context.tr.may,
      context.tr.june,
      context.tr.july,
      context.tr.august,
      context.tr.september,
      context.tr.october,
      context.tr.november,
      context.tr.december,
    ];
  }

  String getSelectedMonthText() {
    if (selectedDate == null) return '';
    return '${getLocalizedMonthName(context, selectedDate!.month)} ${selectedDate!.year}';
  }

  Future<void> showMonthPicker(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = selectedDate ?? now;
    final DateTime safeInitialDate =
        initialDate.isBefore(DateTime(now.year, now.month))
        ? DateTime(now.year, now.month)
        : initialDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: safeInitialDate,
      firstDate: DateTime(now.year, now.month),
      lastDate: DateTime(now.year + 2, 12),
      selectableDayPredicate: (DateTime date) {
        final DateTime monthStart = DateTime(date.year, date.month);
        final DateTime currentMonth = DateTime(now.year, now.month);
        return !monthStart.isBefore(currentMonth);
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.kPrimaryColor1,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.kPrimaryColor1,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month);
      });

      if (widget.onMonthSelected != null) {
        widget.onMonthSelected!(selectedDate!);
      }
    }
  }

  Future<void> _showCustomMonthPicker(BuildContext context) async {
    final DateTime now = DateTime.now();
    DateTime? tempSelectedDate = selectedDate ?? now;
    final List<String> localizedMonths = getLocalizedMonths(context);

    await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                context.tr.choose_month,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(fontSize: 18, color: AppColors.kPrimaryColor1),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: tempSelectedDate!.year > now.year
                              ? () {
                                  setState(() {
                                    int newYear = tempSelectedDate!.year - 1;
                                    int newMonth = tempSelectedDate!.month;
                                    if (newYear < now.year) {
                                      newYear = now.year;
                                    }
                                    DateTime newDate = DateTime(
                                      newYear,
                                      newMonth,
                                    );
                                    DateTime currentMonth = DateTime(
                                      now.year,
                                      now.month,
                                    );

                                    if (newDate.isBefore(currentMonth)) {
                                      newMonth = currentMonth.month;
                                      newYear = currentMonth.year;
                                    }

                                    tempSelectedDate = DateTime(
                                      newYear,
                                      newMonth,
                                    );
                                  });
                                }
                              : null,
                          icon: Icon(
                            Icons.chevron_left,
                            color: tempSelectedDate!.year > now.year
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                        ),
                        Text(
                          '${tempSelectedDate!.year}',
                          style: AppStyles.almaraiBold(
                            context,
                          ).copyWith(fontSize: 20, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: tempSelectedDate!.year < (now.year + 2)
                              ? () {
                                  setState(() {
                                    int newYear = tempSelectedDate!.year + 1;
                                    int newMonth = tempSelectedDate!.month;
                                    if (newYear > (now.year + 2)) {
                                      newYear = now.year + 2;
                                    }
                                    DateTime newDate = DateTime(
                                      newYear,
                                      newMonth,
                                    );
                                    DateTime maxAllowedDate = DateTime(
                                      now.year + 2,
                                      12,
                                    );

                                    if (newDate.isAfter(maxAllowedDate)) {
                                      newMonth = maxAllowedDate.month;
                                      newYear = maxAllowedDate.year;
                                    }

                                    tempSelectedDate = DateTime(
                                      newYear,
                                      newMonth,
                                    );
                                  });
                                }
                              : null,
                          icon: Icon(
                            Icons.chevron_right,
                            color: tempSelectedDate!.year < (now.year + 2)
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 2.5,
                            ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          final int month = index + 1;
                          final DateTime monthDate = DateTime(
                            tempSelectedDate!.year,
                            month,
                          );
                          final DateTime currentMonth = DateTime(
                            now.year,
                            now.month,
                          );
                          final DateTime maxAllowedDate = DateTime(
                            now.year + 2,
                            12,
                          );
                          final bool isSelectable =
                              !monthDate.isBefore(currentMonth) &&
                              !monthDate.isAfter(maxAllowedDate);
                          final bool isSelected =
                              tempSelectedDate!.month == month &&
                              tempSelectedDate!.year >= now.year;
                          return InkWell(
                            onTap: isSelectable
                                ? () {
                                    setState(() {
                                      final DateTime newDate = DateTime(
                                        tempSelectedDate!.year,
                                        month,
                                      );
                                      final DateTime currentMonth = DateTime(
                                        now.year,
                                        now.month,
                                      );
                                      final DateTime maxAllowedDate = DateTime(
                                        now.year + 2,
                                        12,
                                      );
                                      if (newDate.isBefore(currentMonth)) {
                                        tempSelectedDate = currentMonth;
                                      } else if (newDate.isAfter(
                                        maxAllowedDate,
                                      )) {
                                        tempSelectedDate = maxAllowedDate;
                                      } else {
                                        tempSelectedDate = newDate;
                                      }
                                    });
                                  }
                                : null,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.kPrimaryColor1
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.kPrimaryColor1
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  localizedMonths[index],
                                  style: TextStyle(
                                    color: !isSelectable
                                        ? Colors.grey.shade400
                                        : isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    context.tr.cancel,
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(tempSelectedDate);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor1,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    context.tr.select,
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.containerBorder, fontSize: 12),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((DateTime? picked) {
      if (picked != null) {
        setState(() {
          selectedDate = picked;
        });

        if (widget.onMonthSelected != null) {
          widget.onMonthSelected!(selectedDate!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      leading: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimaryColor1.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: const CustomeBackButton(),
      ),
      title: Text(
        context.tr.appointments_calendar,
        style: AppStyles.almaraiBold(context).copyWith(fontSize: 16),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor1.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showCustomMonthPicker(context),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: AppColors.kPrimaryColor1,
                      size: 18,
                    ),
                    if (selectedDate != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        getSelectedMonthText(),
                        style: AppStyles.almaraiBold(context).copyWith(
                          fontSize: 12,
                          color: AppColors.kPrimaryColor1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
