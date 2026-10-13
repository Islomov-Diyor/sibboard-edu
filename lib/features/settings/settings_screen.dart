import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final currentScale = ref.watch(textScaleProvider);
    final readSections = ref.watch(readSectionsProvider);

    // Total main sections: home, goals, capabilities, work, rules = 5
    final totalSections = 5;
    final readCount = readSections.length;
    final progressPercent = (readCount / totalSections).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings, style: AppTypography.titleSmall),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Reading Progress Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.woodLight, width: 1.5),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: progressPercent,
                        strokeWidth: 6,
                        backgroundColor: AppColors.woodLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accent),
                      ),
                      Center(
                        child: Text(
                          '${(progressPercent * 100).toInt()}%',
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.readingProgress,
                        style: AppTypography.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$readCount из $totalSections разделов изучено',
                        style: AppTypography.caption,
                      ),
                      if (readCount > 0) ...[
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            ref.read(readSectionsProvider.notifier).resetAll();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.progressResetSuccess),
                                backgroundColor: AppColors.woodDark,
                              ),
                            );
                          },
                          child: Text(
                            l10n.resetProgress,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Language Selector
          Text(l10n.language, style: AppTypography.titleSmall),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                _buildLanguageOption(
                  title: 'Русский язык (Оригинал)',
                  langCode: 'ru',
                  current: currentLocale,
                  onSelect: () =>
                      ref.read(localeProvider.notifier).setLocale('ru'),
                ),
                const Divider(height: 1),
                _buildLanguageOption(
                  title: 'O\'zbek tili (Lotin yozuvi)',
                  langCode: 'uz',
                  current: currentLocale,
                  onSelect: () =>
                      ref.read(localeProvider.notifier).setLocale('uz'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Font Size Selector
          Text(l10n.fontSize, style: AppTypography.titleSmall),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                _buildScaleOption(
                  title: l10n.fontStandard,
                  scale: 1.0,
                  current: currentScale,
                  onSelect: () =>
                      ref.read(textScaleProvider.notifier).setScale(1.0),
                ),
                _buildScaleOption(
                  title: l10n.fontMedium,
                  scale: 1.15,
                  current: currentScale,
                  onSelect: () =>
                      ref.read(textScaleProvider.notifier).setScale(1.15),
                ),
                _buildScaleOption(
                  title: l10n.fontLarge,
                  scale: 1.3,
                  current: currentScale,
                  onSelect: () =>
                      ref.read(textScaleProvider.notifier).setScale(1.3),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // About App Section
          Text(l10n.aboutApp, style: AppTypography.titleSmall),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.woodLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/11_child_on_board.webp',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.school,
                                  color: AppColors.woodDark),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SIBBOARD EDU',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: AppColors.text,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            '${l10n.appVersion} 1.0.0 (Offline-first)',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text(
                  l10n.projectAuthor,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSoft,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => context.push('/author'),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.woodLight.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.woodDark.withOpacity(0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.wood, width: 1.5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/author_farangiz.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person, color: AppColors.woodDark),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.authorFullName,
                                style: const TextStyle(
                                  fontFamily: AppTypography.fontFamily,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: AppColors.text,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                l10n.authorPosition,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.authorWorkplace,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSoft,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: AppColors.woodDark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/author'),
                    icon: const Icon(Icons.badge_outlined, size: 18),
                    label: Text(l10n.viewAuthorProfile),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.woodDark,
                      side: const BorderSide(color: AppColors.woodDark),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  currentLocale == 'ru'
                      ? 'Электронное научно-методическое пособие для будущих педагогов дошкольного образования по изучению технологии Сибборд и проектированию развивающих заданий.'
                      : 'Bo\'lajak maktabgacha ta\'lim pedagoglarini Sibboard texnologiyasi bilan tanishtirish va ular uchun o\'quv topshiriqlarini loyihalashni o\'rgatishga mo\'ljallangan ilmiy-metodik mobil qo\'llanma.',
                  style: AppTypography.caption.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required String langCode,
    required String current,
    required VoidCallback onSelect,
  }) {
    final isSelected = current == langCode;
    return InkWell(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTypography.labelLarge.copyWith(
                  color: isSelected ? AppColors.accent : AppColors.text,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.accent, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildScaleOption({
    required String title,
    required double scale,
    required double current,
    required VoidCallback onSelect,
  }) {
    final isSelected = (current - scale).abs() < 0.05;
    return Expanded(
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.woodLight : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                fontSize: 13,
                color: isSelected ? AppColors.woodDark : AppColors.textSoft,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
