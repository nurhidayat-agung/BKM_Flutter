import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/core/library/month_picker_dialog/src/helpers/common.dart';
import 'package:rxdart/rxdart.dart';

class PickerHeader extends StatelessWidget {
  const PickerHeader({
    Key? key,
    required this.theme,
    required this.locale,
    this.headerColor,
    this.headerTextColor,
    required this.capitalizeFirstLetter,
    required this.selectedDate,
    required this.isMonthSelector,
    required this.onDownButtonPressed,
    required this.onSelectYear,
    required this.onUpButtonPressed,
    required this.upDownButtonEnableStatePublishSubject,
    required this.upDownPageLimitPublishSubject,
    required this.roundedCornersRadius,
  }) : super(key: key);

  final ThemeData theme;
  final String locale;
  final Color? headerTextColor, headerColor;
  final bool capitalizeFirstLetter;
  final DateTime selectedDate;
  final bool isMonthSelector;
  final VoidCallback onSelectYear, onUpButtonPressed, onDownButtonPressed;
  final PublishSubject<UpDownPageLimit>? upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>?
  upDownButtonEnableStatePublishSubject;
  final double roundedCornersRadius;

  @override
  Widget build(BuildContext context) {
    final TextStyle? headlineStyle = headerTextColor == null
        ? theme.primaryTextTheme.headlineSmall
        : theme.primaryTextTheme.headlineSmall!.copyWith(color: headerTextColor);

    final Color? arrowColor =
        headerTextColor ?? theme.primaryIconTheme.color;

    return Material(
      color: headerColor ?? theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(roundedCornersRadius),
          topRight: Radius.circular(roundedCornersRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              capitalizeFirstLetter
                  ? toBeginningOfSentenceCase(DateFormat.yMMM(locale).format(selectedDate)) ?? ''
                  : DateFormat.yMMM(locale).format(selectedDate).toLowerCase(),
              style: headerTextColor == null
                  ? theme.primaryTextTheme.titleMedium
                  : theme.primaryTextTheme.titleMedium!.copyWith(color: headerTextColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isMonthSelector
                    ? GestureDetector(
                  onTap: onSelectYear,
                  child: StreamBuilder<UpDownPageLimit>(
                    stream: upDownPageLimitPublishSubject,
                    initialData: const UpDownPageLimit(0, 0),
                    builder: (_, snapshot) => Text(
                      DateFormat.y(locale).format(
                        DateTime(snapshot.data!.upLimit),
                      ),
                      style: headlineStyle,
                    ),
                  ),
                )
                    : StreamBuilder<UpDownPageLimit>(
                  stream: upDownPageLimitPublishSubject,
                  initialData: const UpDownPageLimit(0, 0),
                  builder: (_, snapshot) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        DateFormat.y(locale).format(
                            DateTime(snapshot.data!.upLimit)),
                        style: headlineStyle,
                      ),
                      Text(
                        ' - ',
                        style: headlineStyle,
                      ),
                      Text(
                        DateFormat.y(locale).format(
                            DateTime(snapshot.data!.downLimit)),
                        style: headlineStyle,
                      ),
                    ],
                  ),
                ),
                StreamBuilder<UpDownButtonEnableState>(
                  stream: upDownButtonEnableStatePublishSubject,
                  initialData: const UpDownButtonEnableState(true, true),
                  builder: (_, snapshot) => Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          color: snapshot.data!.upState
                              ? arrowColor
                              : arrowColor!.withOpacity(0.5),
                        ),
                        onPressed: snapshot.data!.upState
                            ? onUpButtonPressed
                            : null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: snapshot.data!.downState
                              ? arrowColor
                              : arrowColor!.withOpacity(0.5),
                        ),
                        onPressed: snapshot.data!.downState
                            ? onDownButtonPressed
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
