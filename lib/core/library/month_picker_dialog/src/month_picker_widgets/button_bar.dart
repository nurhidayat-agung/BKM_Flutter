import 'package:flutter/material.dart';

class PickerButtonBar extends StatelessWidget {
  const PickerButtonBar({
    Key? key,
    this.cancelText,
    this.confirmText,
    required this.defaultCancelButtonLabel,
    required this.defaultOkButtonLabel,
    required this.cancelFunction,
    required this.okFunction
  }) : super(key: key);

  final Text? cancelText;
  final Text? confirmText;
  final String defaultCancelButtonLabel;
  final String defaultOkButtonLabel;
  final VoidCallback cancelFunction;
  final VoidCallback okFunction;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
      color: Theme.of(context).primaryColor,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: cancelFunction,
          child: cancelText ??
              Text(
                defaultCancelButtonLabel,
                style: textStyle,
              ),
        ),
        const SizedBox(width: 8), // Jarak antar tombol
        TextButton(
          onPressed: okFunction,
          child: confirmText ??
              Text(
                defaultOkButtonLabel,
                style: textStyle,
              ),
        ),
      ],
    );
  }
}
