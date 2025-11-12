import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/core/library/month_picker_dialog/src/helpers/common.dart';
import 'package:newbkmmobile/core/library/month_picker_dialog/src/helpers/locale_utils.dart';
import 'package:rxdart/rxdart.dart';

class YearSelector extends StatefulWidget {
  final ValueChanged<int> onYearSelected;
  final DateTime? initialDate, firstDate, lastDate;
  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>
  upDownButtonEnableStatePublishSubject;
  final Locale? locale;
  final Color? selectedMonthBackgroundColor;
  final Color? selectedMonthTextColor;
  final Color? unselectedMonthTextColor;

  const YearSelector({
    Key? key,
    required this.initialDate,
    required this.onYearSelected,
    required this.upDownPageLimitPublishSubject,
    required this.upDownButtonEnableStatePublishSubject,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.selectedMonthBackgroundColor,
    this.selectedMonthTextColor,
    this.unselectedMonthTextColor,
  }) : super(key: key);

  @override
  State<YearSelector> createState() => YearSelectorState();
}

class YearSelectorState extends State<YearSelector> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.firstDate == null
          ? (widget.initialDate!.year / 12).floor()
          : ((widget.initialDate!.year - widget.firstDate!.year) / 12).floor(),
    );

    // Sinkronisasi awal state tombol & batas halaman
    Future.microtask(() {
      final currentPage = _pageController.page?.toInt() ?? 0;
      widget.upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          widget.firstDate == null
              ? currentPage * 12
              : widget.firstDate!.year + currentPage * 12,
          widget.firstDate == null
              ? currentPage * 12 + 11
              : widget.firstDate!.year + currentPage * 12 + 11,
        ),
      );
      widget.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
          currentPage > 0,
          currentPage < _getPageCount() - 1,
        ),
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChange,
      itemCount: _getPageCount(),
      itemBuilder: _yearGridBuilder,
    );
  }

  // Build grid 4 kolom × 3 baris
  Widget _yearGridBuilder(BuildContext context, int page) {
    final localeName = getLocale(context, selectedLocale: widget.locale);
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      crossAxisCount: 4,
      children: List.generate(
        12,
            (index) => _buildYearButton(page, index, localeName),
      ),
    );
  }

  Widget _buildYearButton(int page, int index, String locale) {
    final theme = Theme.of(context);
    final startYear = widget.firstDate?.year ?? 0;
    final year = startYear + (page * 12) + index;

    final bool isEnabled = _isEnabled(year);
    final bool isSelected = year == widget.initialDate?.year;
    final bool isCurrentYear = year == DateTime.now().year;

    final Color backgroundColor = isSelected
        ? (widget.selectedMonthBackgroundColor ?? theme.colorScheme.primary)
        : Colors.transparent;

    final Color foregroundColor = isSelected
        ? (widget.selectedMonthTextColor ?? theme.colorScheme.onPrimary)
        : isCurrentYear
        ? (widget.selectedMonthTextColor ??
        theme.colorScheme.primary.withOpacity(0.9))
        : (widget.unselectedMonthTextColor ??
        theme.colorScheme.onSurface.withOpacity(0.8));

    final TextStyle textStyle =
        theme.textTheme.labelLarge?.copyWith(color: foregroundColor) ??
            TextStyle(color: foregroundColor);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: isEnabled ? () => widget.onYearSelected(year) : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
          shape: MaterialStateProperty.all(const CircleBorder()),
          overlayColor:
          MaterialStateProperty.all(theme.colorScheme.primaryContainer),
        ),
        child: Text(
          DateFormat.y(locale).format(DateTime(year)),
          style: textStyle,
        ),
      ),
    );
  }

  void _onPageChange(int page) {
    widget.upDownPageLimitPublishSubject.add(
      UpDownPageLimit(
        widget.firstDate == null
            ? page * 12
            : widget.firstDate!.year + page * 12,
        widget.firstDate == null
            ? page * 12 + 11
            : widget.firstDate!.year + page * 12 + 11,
      ),
    );
    widget.upDownButtonEnableStatePublishSubject.add(
      UpDownButtonEnableState(
        page > 0,
        page < _getPageCount() - 1,
      ),
    );
  }

  int _getPageCount() {
    if (widget.firstDate != null && widget.lastDate != null) {
      final diff = widget.lastDate!.year - widget.firstDate!.year + 1;
      return (diff / 12).ceil();
    } else if (widget.firstDate != null && widget.lastDate == null) {
      return ((9999 - widget.firstDate!.year) / 12).ceil();
    } else if (widget.firstDate == null && widget.lastDate != null) {
      return (widget.lastDate!.year / 12).ceil();
    } else {
      return (9999 / 12).ceil();
    }
  }

  bool _isEnabled(int year) {
    if (widget.firstDate == null && widget.lastDate == null) return true;
    if (widget.firstDate != null &&
        widget.lastDate != null &&
        year >= widget.firstDate!.year &&
        year <= widget.lastDate!.year) return true;
    if (widget.firstDate != null &&
        widget.lastDate == null &&
        year >= widget.firstDate!.year) return true;
    if (widget.firstDate == null &&
        widget.lastDate != null &&
        year <= widget.lastDate!.year) return true;
    return false;
  }

  // Navigasi manual ke halaman berikut / sebelumnya
  void goDown() {
    final next = (_pageController.page ?? 0).toInt() + 1;
    if (next < _getPageCount()) {
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void goUp() {
    final prev = (_pageController.page ?? 0).toInt() - 1;
    if (prev >= 0) {
      _pageController.animateToPage(
        prev,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
