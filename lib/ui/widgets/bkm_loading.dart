import 'package:flutter/material.dart';

class BkmLoading {
  static bool _isShowing = false;

  static void show(BuildContext context, {String? message}) {
    if (_isShowing) return;
    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) {
        return PopScope(
          canPop: false, // ⬅️ blok tombol back
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/bkm_logo_animation.gif',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message ?? 'Mohon tunggu...',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (!_isShowing) return;

    _isShowing = false;
    Navigator.of(context, rootNavigator: true).pop();
  }
}
