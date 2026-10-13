import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class RulesScreen extends ConsumerWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final repo = ref.watch(contentRepositoryProvider);
    final l10n = AppLocalizations.of(context)!;
    final readSections = ref.watch(readSectionsProvider);
    final isRulesRead = readSections.contains('rules');
    final safetyChecklist = ref.watch(safetyChecklistProvider);

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: repo.getRulesData(lang),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
              ),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline_rounded,
                        size: 48, color: AppColors.accent),
                    const SizedBox(height: 12),
                    Text(l10n.errorOccurred, style: AppTypography.titleSmall),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = snapshot.data!;
          final coverImage = data['cover_image'] as String? ??
              'assets/images/09_lunge_pose.webp';
          final title = data['title'] as String? ?? 'Правила пользования';
          final corePrinciple = data['core_principle'] as String? ?? '';
          final fourQuestions =
              (data['four_questions'] as List<dynamic>?) ?? [];
          final exampleBox =
              (data['example_box'] as Map<String, dynamic>?) ?? {};
          final sections = (data['sections'] as List<dynamic>?) ?? [];
          final checklist = (data['checklist'] as List<dynamic>?) ?? [];

          final isAllSafetyChecked = checklist.isNotEmpty &&
              checklist.every((c) =>
                  safetyChecklist.contains(checklist.indexOf(c)));

          return CustomScrollView(
            slivers: [
              // Cover
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.15),
                            Colors.black.withOpacity(0.75),
                          ],
                        ),
                      ),
                      child: Image.asset(
                        coverImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: AppColors.successLight),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'XAVFSIZLIK VA SAMARADORLIK',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            title,
                            style: AppTypography.titleLarge.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Mark as read banner
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isRulesRead
                            ? AppColors.successLight
                            : AppColors.woodLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isRulesRead
                              ? AppColors.success
                              : AppColors.wood,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isRulesRead
                                ? Icons.check_circle_rounded
                                : Icons.rule_rounded,
                            color: isRulesRead
                                ? AppColors.success
                                : AppColors.woodDark,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isRulesRead ? l10n.alreadyRead : l10n.markAsRead,
                              style: AppTypography.labelLarge.copyWith(
                                color: isRulesRead
                                    ? AppColors.success
                                    : AppColors.woodDark,
                              ),
                            ),
                          ),
                          if (!isRulesRead)
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(readSectionsProvider.notifier)
                                    .markRead('rules');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.woodDark,
                              ),
                              child: const Icon(Icons.check_rounded),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Core Principle Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.favorite_rounded,
                                color: AppColors.success, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ключевой педагогический принцип:',
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  corePrinciple,
                                  style: AppTypography.titleSmall.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 4 Key Questions Block
                    Text(
                      '4 ключевых вопроса эффективного использования',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 12),

                    ...List.generate(fourQuestions.length, (index) {
                      final q = fourQuestions[index];
                      final qTitle = q['question'] as String? ?? '';
                      final qDesc = q['desc'] as String? ?? '';

                      final colors = [
                        AppColors.teal,
                        AppColors.accent,
                        AppColors.woodDark,
                        AppColors.success,
                      ];
                      final c = colors[index % colors.length];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color: c.withOpacity(0.3), width: 1.2),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: c,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      qTitle,
                                      style: AppTypography.labelLarge.copyWith(
                                        color: c,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(qDesc,
                                        style: AppTypography.bodyMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    // Example box
                    if (exampleBox.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.woodLight,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.wood),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exampleBox['title'] as String? ?? 'Пример',
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.woodDark,
                              ),
                            ),
                            const Divider(height: 16),
                            _buildExampleLine('Цель', exampleBox['goal']),
                            _buildExampleLine('Элемент', exampleBox['element']),
                            _buildExampleLine('Задание', exampleBox['task']),
                            _buildExampleLine(
                                'Сопровождение', exampleBox['speech']),
                            _buildExampleLine(
                                'Результат', exampleBox['result']),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Safety Checklist Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            l10n.safetyChecklistTitle,
                            style: AppTypography.titleMedium,
                          ),
                        ),
                        if (safetyChecklist.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(safetyChecklistProvider.notifier)
                                  .clear();
                            },
                            child: Text(l10n.clearChecklist),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    if (isAllSafetyChecked) ...[
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.successLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.success, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                color: AppColors.success, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                l10n.safetyAllChecked,
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    ...List.generate(checklist.length, (index) {
                      final item = checklist[index].toString();
                      final isChecked = safetyChecklist.contains(index);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(safetyChecklistProvider.notifier)
                                .toggle(index);
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: isChecked
                                  ? AppColors.successLight.withOpacity(0.5)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isChecked
                                    ? AppColors.success
                                    : AppColors.divider,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isChecked
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                  color: isChecked
                                      ? AppColors.success
                                      : AppColors.textSoft,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: isChecked
                                          ? AppColors.text
                                          : AppColors.textSoft,
                                      fontWeight: isChecked
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 28),

                    // 6 Accordions
                    Text(
                      'Подробные методические правила',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 14),

                    ...sections.map((sec) {
                      final sTitle = sec['title'] as String? ?? '';
                      final sItems = (sec['items'] as List<dynamic>?) ?? [];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            title: Text(
                              sTitle,
                              style: AppTypography.titleSmall.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.successLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.verified_user_rounded,
                                color: AppColors.success,
                                size: 20,
                              ),
                            ),
                            childrenPadding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 20),
                            children: sItems.map((it) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Icon(
                                        Icons.arrow_right_rounded,
                                        size: 18,
                                        color: AppColors.success,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        it.toString(),
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                          color: AppColors.text,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExampleLine(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: AppColors.woodDark,
          ),
          children: [
            TextSpan(
              text: value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
