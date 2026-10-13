import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/remote_switch_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class LicenseLockScreen extends StatefulWidget {
  const LicenseLockScreen({super.key});

  @override
  State<LicenseLockScreen> createState() => _LicenseLockScreenState();
}

class _LicenseLockScreenState extends State<LicenseLockScreen> {
  bool _isChecking = false;
  String _title = 'Dasturiy ta\'minot litsenziyasi to\'xtatilgan';
  String _message =
      'Ushbu ilovaning rasmiy litsenziya muddati to\'xtatilgan. To\'liq faollashtirish va qayta yoqish uchun dasturchi bilan bog\'laning.';
  String _phone = '+998 97 385 05 50';
  String _telegram = 'https://t.me/Islomov_Diyor';

  @override
  void initState() {
    super.initState();
    _loadStoredMessages();
  }

  Future<void> _loadStoredMessages() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _title = prefs.getString(RemoteSwitchService.keyLockTitle) ?? _title;
      _message = prefs.getString(RemoteSwitchService.keyLockMessage) ?? _message;
      _phone = prefs.getString(RemoteSwitchService.keyContactPhone) ?? _phone;
      _telegram = prefs.getString(RemoteSwitchService.keyContactTg) ?? _telegram;
    });
  }

  Future<void> _checkAgain() async {
    setState(() {
      _isChecking = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final isLocked = await RemoteSwitchService.checkAndSyncStatus(prefs);

    if (mounted) {
      setState(() {
        _isChecking = false;
      });

      if (!isLocked) {
        // Unlocked!
        context.go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Litsenziya hali faollashtirilmadi. Iltimos dasturchi bilan bog\'laning.'),
            backgroundColor: AppColors.accent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lock Icon Badge
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.accent, width: 2),
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    size: 48,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  _title,
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.accent,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                Text(
                  _message,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.text,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // Contact Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.phone_rounded,
                              size: 18, color: AppColors.woodDark),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Aloqa: $_phone',
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 18),
                      Row(
                        children: [
                          const Icon(Icons.send_rounded,
                              size: 18, color: AppColors.teal),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Telegram: $_telegram',
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Re-check button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    icon: _isChecking
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.refresh_rounded),
                    label: Text(
                      _isChecking
                          ? 'Tekshirilmoqda...'
                          : 'Qayta tekshirish (Faollashtirish)',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.woodDark,
                    ),
                    onPressed: _isChecking ? null : _checkAgain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
