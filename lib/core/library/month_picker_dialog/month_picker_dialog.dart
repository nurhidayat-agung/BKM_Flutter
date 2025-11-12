import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'src/helpers/common.dart';
import 'src/helpers/locale_utils.dart';
import 'src/month_picker_widgets/button_bar.dart';
import 'src/month_picker_widgets/header.dart';
import 'src/month_picker_widgets/pager.dart';
import 'src/month_selector/month_selector.dart';
import 'src/year_selector/year_selector.dart';

/// Show a Material 3–friendly month picker dialog.
Future<DateTime?> showMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Locale? locale,
  bool Function(DateTime)? selectableMonthPredicate,
  bool capitalizeFirstLetter = true,
  Color? headerColor,
  Color? headerTextColor,
  Color? selectedMonthBackgroundColor,
  Color? selectedMonthTextColor,
  Color? unselectedMonthTextColor,
  Text? confirmText,
  Text? cancelText,
  double? customHeight,
  double? customWidth,
  bool yearFirst = false,
  bool dismissible = false,
  double roundedCornersRadius = 16.0, // default Material 3 corner
}) async {
  return await showDialog<DateTime>(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) => _MonthPickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: locale,
      selectableMonthPredicate: selectableMonthPredicate,
      capitalizeFirstLetter: capitalizeFirstLetter,
      headerColor: headerColor,
      headerTextColor: headerTextColor,
      selectedMonthBackgroundColor: selectedMonthBackgroundColor,
      selectedMonthTextColor: selectedMonthTextColor,
      unselectedMonthTextColor: unselectedMonthTextColor,
      confirmText: confirmText,
      cancelText: cancelText,
      customHeight: customHeight,
      customWidth: customWidth,
      yearFirst: yearFirst,
      roundedCornersRadius: roundedCornersRadius,
    ),
  );
}

class _MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? firstDate, lastDate;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter, yearFirst;
  final Color? headerColor,
      headerTextColor,
      selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;
  final Text? confirmText, cancelText;
  final double? customHeight, customWidth;
  final double roundedCornersRadius;

  const _MonthPickerDialog({
    super.key,
    required this.initialDate,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.selectableMonthPredicate,
    required this.capitalizeFirstLetter,
    this.headerColor,
    this.headerTextColor,
    this.selectedMonthBackgroundColor,
    this.selectedMonthTextColor,
    this.unselectedMonthTextColor,
    this.confirmText,
    this.cancelText,
    this.customHeight,
    this.customWidth,
    required this.yearFirst,
    required this.roundedCornersRadius,
  });

  @override
  State<_MonthPickerDialog> createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  final GlobalKey<YearSelectorState> _yearSelectorKey =
  GlobalKey<YearSelectorState>();
  final GlobalKey<MonthSelectorState> _monthSelectorKey =
  GlobalKey<MonthSelectorState>();

  final PublishSubject<UpDownPageLimit> _upDownPageLimitSubject =
  PublishSubject();
  final PublishSubject<UpDownButtonEnableState> _upDownButtonStateSubject =
  PublishSubject();

  late Widget _selector;
  late DateTime selectedDate;
  DateTime? _firstDate, _lastDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(widget.initialDate.year, widget.initialDate.month);

    if (widget.firstDate != null) {
      _firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month);
    }
    if (widget.lastDate != null) {
      _lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month);
    }

    _selector = widget.yearFirst
        ? YearSelector(
      key: _yearSelectorKey,
      initialDate: selectedDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
      onYearSelected: _onYearSelected,
      upDownPageLimitPublishSubject: _upDownPageLimitSubject,
      upDownButtonEnableStatePublishSubject: _upDownButtonStateSubject,
      selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
      selectedMonthTextColor: widget.selectedMonthTextColor,
      unselectedMonthTextColor: widget.unselectedMonthTextColor,
    )
        : MonthSelector(
      key: _monthSelectorKey,
      openDate: selectedDate,
      selectedDate: selectedDate,
      selectableMonthPredicate: widget.selectableMonthPredicate,
      upDownPageLimitPublishSubject: _upDownPageLimitSubject,
      upDownButtonEnableStatePublishSubject: _upDownButtonStateSubject,
      firstDate: _firstDate,
      lastDate: _lastDate,
      onMonthSelected: _onMonthSelected,
      locale: widget.locale,
      capitalizeFirstLetter: widget.capitalizeFirstLetter,
      selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
      selectedMonthTextColor: widget.selectedMonthTextColor,
      unselectedMonthTextColor: widget.unselectedMonthTextColor,
    );
  }

  @override
  void dispose() {
    _upDownPageLimitSubject.close();
    _upDownButtonStateSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String locale = getLocale(context, selectedLocale: widget.locale);

    final Material content = Material(
      color: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      elevation: 2,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(widget.roundedCornersRadius),
        bottomRight: Radius.circular(widget.roundedCornersRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PickerPager(
            selector: _selector,
            theme: theme,
            customHeight: widget.customHeight,
            customWidth: widget.customWidth,
          ),
          PickerButtonBar(
            cancelText: widget.cancelText,
            confirmText: widget.confirmText,
            defaultCancelButtonLabel: 'Cancel',
            defaultOkButtonLabel: 'OK',
            cancelFunction: () => Navigator.pop(context, null),
            okFunction: () => Navigator.pop(context, selectedDate)
          ),
        ],
      ),
    );

    final PickerHeader header = PickerHeader(
      theme: theme,
      locale: locale,
      headerColor:
      widget.headerColor ?? theme.colorScheme.primaryContainer,
      headerTextColor:
      widget.headerTextColor ?? theme.colorScheme.onPrimaryContainer,
      capitalizeFirstLetter: widget.capitalizeFirstLetter,
      selectedDate: selectedDate,
      isMonthSelector: _selector is MonthSelector,
      onDownButtonPressed: _onDownButtonPressed,
      onSelectYear: _onSelectYear,
      onUpButtonPressed: _onUpButtonPressed,
      upDownButtonEnableStatePublishSubject: _upDownButtonStateSubject,
      upDownPageLimitPublishSubject: _upDownPageLimitSubject,
      roundedCornersRadius: widget.roundedCornersRadius,
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.roundedCornersRadius),
      ),
      backgroundColor: Colors.transparent,
      child: Theme(
        data: theme.copyWith(
          dialogBackgroundColor: Colors.transparent,
          useMaterial3: true,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (BuildContext context) {
                if (MediaQuery.of(context).orientation ==
                    Orientation.portrait) {
                  return IntrinsicWidth(
                    child: Column(
                      children: [header, content],
                    ),
                  );
                }
                return IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [header, content],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectYear() {
    setState(() {
      _selector = YearSelector(
        key: _yearSelectorKey,
        initialDate: selectedDate,
        firstDate: _firstDate,
        lastDate: _lastDate,
        onYearSelected: _onYearSelected,
        upDownPageLimitPublishSubject: _upDownPageLimitSubject,
        upDownButtonEnableStatePublishSubject: _upDownButtonStateSubject,
        selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
        selectedMonthTextColor: widget.selectedMonthTextColor,
        unselectedMonthTextColor: widget.unselectedMonthTextColor,
      );
    });
  }

  void _onYearSelected(int year) {
    setState(() {
      _selector = MonthSelector(
        key: _monthSelectorKey,
        openDate: DateTime(year),
        selectedDate: selectedDate,
        selectableMonthPredicate: widget.selectableMonthPredicate,
        upDownPageLimitPublishSubject: _upDownPageLimitSubject,
        upDownButtonEnableStatePublishSubject: _upDownButtonStateSubject,
        firstDate: _firstDate,
        lastDate: _lastDate,
        onMonthSelected: _onMonthSelected,
        locale: widget.locale,
        capitalizeFirstLetter: widget.capitalizeFirstLetter,
        selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
        selectedMonthTextColor: widget.selectedMonthTextColor,
        unselectedMonthTextColor: widget.unselectedMonthTextColor,
      );
    });
  }

  void _onMonthSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      _selector = MonthSelector(
        key: _monthSelectorKey,
        openDate: selectedDate,
        selectedDate: selectedDate,
        selectableMonthPredicate: widget.selectableMonthPredicate,
        upDownPageLimitPublishSubject: _upDownPageLimitSubject,
        upDownButtonEnableStatePublishSubject: _upDownButtonStateSubject,
        firstDate: _firstDate,
        lastDate: _lastDate,
        onMonthSelected: _onMonthSelected,
        locale: widget.locale,
        capitalizeFirstLetter: widget.capitalizeFirstLetter,
        selectedMonthBackgroundColor: widget.selectedMonthBackgroundColor,
        selectedMonthTextColor: widget.selectedMonthTextColor,
        unselectedMonthTextColor: widget.unselectedMonthTextColor,
      );
    });
  }

  void _onUpButtonPressed() {
    _yearSelectorKey.currentState?.goUp();
    _monthSelectorKey.currentState?.goUp();
  }

  void _onDownButtonPressed() {
    _yearSelectorKey.currentState?.goDown();
    _monthSelectorKey.currentState?.goDown();
  }
}
