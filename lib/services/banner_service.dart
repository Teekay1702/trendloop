import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class BannerService {
  static void showError(BuildContext context, String message) {
    _showBanner(
      context: context,
      message: message,
      icon: Icons.error_outline,
      backgroundColor: Colors.red.shade800,
      textColor: Colors.white,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showBanner(
      context: context,
      message: message,
      icon: Icons.check_circle_outline,
      backgroundColor: AppTheme.ink,
      textColor: Colors.white,
    );
  }

  static void showWarning(BuildContext context, String message) {
    _showBanner(
      context: context,
      message: message,
      icon: Icons.warning_amber_outlined,
      backgroundColor: Colors.amber.shade900,
      textColor: Colors.white,
    );
  }

  static void _showBanner({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    // ScaffoldMessenger's showMaterialBanner is great for a sliding banner at the top of the screen!
    final messenger = ScaffoldMessenger.of(context);
    
    // Clear any active banners before showing a new one
    messenger.clearMaterialBanners();
    
    messenger.showMaterialBanner(
      MaterialBanner(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Icon(icon, color: textColor, size: 28),
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: textColor),
            onPressed: () => messenger.clearMaterialBanners(),
          ),
        ],
      ),
    );

    // Auto-dismiss the top banner after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      try {
        messenger.clearMaterialBanners();
      } catch (_) {}
    });
  }
}
