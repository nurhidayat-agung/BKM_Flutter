import 'package:flutter/material.dart';

enum AlertType { error, warning, info, success }

class BkmAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final AlertType type;
  final VoidCallback? onButtonPressed;

  const BkmAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText = "Tutup",
    this.type = AlertType.error,
    this.onButtonPressed,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    String title = "Pemberitahuan",
    required String message,
    String buttonText = "Tutup",
    AlertType type = AlertType.error,
    VoidCallback? onButtonPressed,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => BkmAlertDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        type: type,
        onButtonPressed: onButtonPressed,
      ),
    );
  }

  static Future<void> showError(
    BuildContext context, {
    String title = "Gagal Masuk",
    required String message,
    String buttonText = "Coba Lagi",
    VoidCallback? onButtonPressed,
  }) {
    return show(
      context,
      title: title,
      message: message,
      buttonText: buttonText,
      type: AlertType.error,
      onButtonPressed: onButtonPressed,
    );
  }

  Color _getIconColor() {
    switch (type) {
      case AlertType.error:
        return const Color(0xFFD32F2F);
      case AlertType.warning:
        return const Color(0xFFF57C00);
      case AlertType.info:
        return const Color(0xFF023E73);
      case AlertType.success:
        return const Color(0xFF388E3C);
    }
  }

  Color _getIconBackgroundColor() {
    switch (type) {
      case AlertType.error:
        return const Color(0xFFFFEBEE);
      case AlertType.warning:
        return const Color(0xFFFFF3E0);
      case AlertType.info:
        return const Color(0xFFE3F2FD);
      case AlertType.success:
        return const Color(0xFFE8F5E9);
    }
  }

  IconData _getIcon() {
    switch (type) {
      case AlertType.error:
        return Icons.error_outline_rounded;
      case AlertType.warning:
        return Icons.warning_amber_rounded;
      case AlertType.info:
        return Icons.info_outline_rounded;
      case AlertType.success:
        return Icons.check_circle_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Icon Bulat
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(),
                color: _getIconColor(),
                size: 36,
              ),
            ),
            const SizedBox(height: 18),

            // 🔹 Judul Dialog
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF001F3F),
              ),
            ),
            const SizedBox(height: 10),

            // 🔹 Pesan Pesan Error / Notifikasi
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // 🔹 Tombol Aksi
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  if (onButtonPressed != null) {
                    onButtonPressed!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F3F),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
