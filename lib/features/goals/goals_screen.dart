import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final repo = ref.watch(contentRepositoryProvider);
    final l10n = AppLocalizations.of(context)!;
    final readSections = ref.watch(readSectionsProvider);
    final isGoalsRead = readSections.contains('goals');

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: repo.getGoalsData(lang),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.teal),
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
                      onPressed: () => setState(() {}),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = snapshot.data!;
          final coverImage = data['cover_image'] as String? ??
              'assets/images/05_group_lesson_hall.webp';
          final mainGoal = (data['main_goal'] as Map<String, dynamic>?) ?? {};
          final appGoal = (data['app_goal'] as Map<String, dynamic>?) ?? {};
          final childrenTasks =
              (data['children_tasks'] as List<dynamic>?) ?? [];
          final pedagogueTasks =
              (data['pedagogue_tasks'] as List<dynamic>?) ?? [];

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
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
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Image.asset(
                          coverImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: AppColors.tealLight),
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
                                color: AppColors.teal,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'STRATEGIYA VA METODIKA',
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
                              data['title'] as String? ?? 'Цель и задачи',
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

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mark as read banner
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isGoalsRead
                                ? AppColors.successLight
                                : AppColors.tealLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isGoalsRead
                                  ? AppColors.success
                                  : AppColors.teal,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isGoalsRead
                                    ? Icons.check_circle_rounded
                                    : Icons.bookmark_add_rounded,
                                color: isGoalsRead
                                    ? AppColors.success
                                    : AppColors.teal,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  isGoalsRead
                                      ? l10n.alreadyRead
                                      : l10n.markAsRead,
                                  style: AppTypography.labelLarge.copyWith(
                                    color: isGoalsRead
                                        ? AppColors.success
                                        : AppColors.teal,
                                  ),
                                ),
                              ),
                              if (!isGoalsRead)
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(readSectionsProvider.notifier)
                                        .markRead('goals');
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.teal,
                                  ),
                                  child: const Icon(Icons.check_rounded),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Main Goal Card (Teal background)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.teal,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 16,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.flag_rounded,
                                      color: Colors.white, size: 24),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      mainGoal['title'] as String? ??
                                          'Цель технологии Сибборд',
                                      style:
                                          AppTypography.titleSmall.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                mainGoal['description'] as String? ?? '',
                                style: AppTypography.bodyLarge.copyWith(
                                  color: Colors.white.withOpacity(0.95),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // App Goal Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.woodLight, width: 1.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.accentLight,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.school_rounded,
                                        color: AppColors.accent, size: 20),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      appGoal['title'] as String? ??
                                          'Цель приложения SIBBOARD EDU',
                                      style: AppTypography.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                appGoal['description'] as String? ?? '',
                                style: AppTypography.bodyMedium,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Tab Bar
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.divider),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: AppColors.teal,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: AppColors.textSoft,
                            labelStyle: AppTypography.labelLarge,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            padding: const EdgeInsets.all(4),
                            tabs: [
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(l10n.goalsTabKids),
                                ),
                              ),
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(l10n.goalsTabPedagogues),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1: Children Tasks (6 items)
                ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  itemCount: childrenTasks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final task = childrenTasks[index];
                    final no = task['no'] ?? (index + 1);
                    final taskTitle = task['title'] as String? ?? '';
                    final items = (task['items'] as List<dynamic>?) ?? [];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.tealLight,
                                  child: Text(
                                    '$no',
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      color: AppColors.teal,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    taskTitle,
                                    style: AppTypography.titleSmall.copyWith(
                                      color: AppColors.teal,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            ...items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        size: 16,
                                        color: AppColors.teal,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        item.toString(),
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                          color: AppColors.text,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Tab 2: Future Pedagogues (10 items)
                ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  itemCount: pedagogueTasks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final itemText = pedagogueTasks[index].toString();

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.divider),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.tealLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: AppColors.teal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              itemText,
                              style: AppTypography.bodyLarge.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
