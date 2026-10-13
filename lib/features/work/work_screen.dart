import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/pdf_generator.dart';
import '../../l10n/app_localizations.dart';
import 'task_builder_screen.dart';
import 'topic_detail_screen.dart';
import 'virtual_board_view.dart';

class WorkScreen extends ConsumerStatefulWidget {
  const WorkScreen({super.key});

  @override
  ConsumerState<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends ConsumerState<WorkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeStage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
    final isWorkRead = readSections.contains('work');
    final userTasks = ref.watch(userTasksProvider);

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: repo.getWorkData(lang),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.woodDark),
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
          final title = data['title'] as String? ?? 'Возможности работы';
          final topics = (data['topics'] as List<dynamic>?) ?? [];
          final stages = (data['stages'] as List<dynamic>?) ?? [];
          final algorithm = (data['algorithm'] as List<dynamic>?) ?? [];
          final algorithmReminder =
              data['algorithm_reminder'] as String? ?? '';
          final virtualElements =
              (data['virtual_elements'] as List<dynamic>?) ?? [];

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.woodDark,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'AMALIY METODIKA VA LOYIHALASH',
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
                          style: AppTypography.titleLarge,
                        ),
                        const SizedBox(height: 14),

                        // Mark as read banner
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isWorkRead
                                ? AppColors.successLight
                                : AppColors.woodLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isWorkRead
                                  ? AppColors.success
                                  : AppColors.wood,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isWorkRead
                                    ? Icons.check_circle_rounded
                                    : Icons.handyman_rounded,
                                color: isWorkRead
                                    ? AppColors.success
                                    : AppColors.woodDark,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  isWorkRead
                                      ? l10n.alreadyRead
                                      : l10n.markAsRead,
                                  style: AppTypography.labelLarge.copyWith(
                                    color: isWorkRead
                                        ? AppColors.success
                                        : AppColors.woodDark,
                                  ),
                                ),
                              ),
                              if (!isWorkRead)
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(readSectionsProvider.notifier)
                                        .markRead('work');
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.woodDark,
                                  ),
                                  child: const Icon(Icons.check_rounded),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 5 Segment Tabs
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            indicator: BoxDecoration(
                              color: AppColors.woodDark,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: AppColors.textSoft,
                            labelStyle: AppTypography.labelLarge,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            padding: const EdgeInsets.all(4),
                            tabs: [
                              Tab(text: l10n.workSubTabTopics),
                              Tab(text: l10n.workSubTabStages),
                              Tab(text: l10n.workSubTabAlgorithm),
                              Tab(text: l10n.workSubTabVirtualBoard),
                              Tab(text: l10n.workSubTabBuilder),
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
                // Part A: 11 Topics
                ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  itemCount: topics.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final t = topics[index] as Map<String, dynamic>;
                    final no = t['no'] ?? (index + 1);
                    final tTitle = t['title'] as String? ?? '';
                    final desc = t['description'] as String? ?? '';
                    final image = t['image'] as String?;

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => TopicDetailScreen(topic: t),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border:
                              Border.all(color: AppColors.divider),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            if (image != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  image,
                                  width: 68,
                                  height: 68,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 68,
                                    height: 68,
                                    color: AppColors.woodLight,
                                    child: const Icon(Icons.menu_book,
                                        color: AppColors.woodDark),
                                  ),
                                ),
                              )
                            else
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: AppColors.woodLight,
                                child: Text(
                                  '$no',
                                  style: const TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.woodDark,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tTitle,
                                    style: AppTypography.titleSmall.copyWith(
                                      fontSize: 15,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    desc,
                                    style: AppTypography.caption,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                size: 14, color: AppColors.textSoft),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Part B: 5 Stages Stepper
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5 этапов постепенного усложнения заданий',
                        style: AppTypography.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Знакомство → Подражание → Самостоятельное выполнение → Проблемное задание → Творческая деятельность',
                        style: AppTypography.caption,
                      ),
                      const SizedBox(height: 18),

                      // Horizontal Step Indicator
                      Row(
                        children: List.generate(stages.length, (index) {
                          final isSelected = _activeStage == index;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _activeStage = index;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.woodDark
                                      : AppColors.woodLight,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Этап ${index + 1}',
                                      style: TextStyle(
                                        fontFamily: AppTypography.fontFamily,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.woodDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      // Active Stage Card
                      if (_activeStage < stages.length) ...[
                        Builder(
                          builder: (context) {
                            final stage = stages[_activeStage];
                            final stitle =
                                stage['title'] as String? ?? '';
                            final sdesc =
                                stage['description'] as String? ?? '';

                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.woodDark,
                                  width: 1.5,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.shadow,
                                    blurRadius: 16,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor: AppColors.woodDark,
                                        child: Text(
                                          '${_activeStage + 1}',
                                          style: const TextStyle(
                                            fontFamily: AppTypography.fontFamily,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          stitle,
                                          style: AppTypography.titleMedium
                                              .copyWith(
                                            color: AppColors.woodDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 24),
                                  Text(
                                    sdesc,
                                    style: AppTypography.bodyLarge.copyWith(
                                      height: 1.55,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],

                      const SizedBox(height: 24),

                      OutlinedButton.icon(
                        icon: const Icon(Icons.rule_rounded),
                        label: const Flexible(
                          child: Text(
                            'Смотреть правила последовательности в разделе «Правила»',
                          ),
                        ),
                        onPressed: () => context.go('/rules'),
                      ),
                    ],
                  ),
                ),

                // Part C: 8-Step Algorithm Timeline
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '8-шаговый алгоритм педагога',
                        style: AppTypography.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Определение цели → Выбор элементов → Постановка задания → Демонстрация → Самостоятельность → Поддержка → Анализ → Рефлексия',
                        style: AppTypography.caption,
                      ),
                      const SizedBox(height: 20),

                      ...List.generate(algorithm.length, (index) {
                        final alg = algorithm[index];
                        final st = alg['step'] ?? (index + 1);
                        final stitle = alg['title'] as String? ?? '';
                        final sdesc = alg['desc'] as String? ?? '';
                        final isLast = index == algorithm.length - 1;

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.woodDark,
                                  child: Text(
                                    '$st',
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                if (!isLast)
                                  Container(
                                    width: 2.5,
                                    height: 54,
                                    color: AppColors.wood,
                                  ),
                              ],
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  padding: const EdgeInsets.all(14),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stitle,
                                        style:
                                            AppTypography.labelLarge.copyWith(
                                          color: AppColors.woodDark,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(sdesc,
                                          style: AppTypography.bodyMedium),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),

                      const SizedBox(height: 12),

                      // Algorithm Reminder Box
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.woodLight,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.wood),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.psychology_rounded,
                                color: AppColors.woodDark, size: 26),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                algorithmReminder,
                                style: AppTypography.bodyMedium.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.text,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Part D: Virtual Sibboard (CustomPainter & Elements)
                VirtualBoardView(
                  elements: virtualElements,
                  onElementSelected: (el) {
                    final elName = el['name'] as String? ?? '';
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) =>
                            TaskBuilderScreen(initialElement: elName),
                      ),
                    );
                  },
                ),

                // Part E: Task Builder & Saved Tasks
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add_task_rounded),
                        label: Text(l10n.newTask),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const TaskBuilderScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(l10n.myTasksTitle, style: AppTypography.titleMedium),
                      const SizedBox(height: 14),

                      if (userTasks.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.divider),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.assignment_outlined,
                                  size: 48, color: AppColors.textSoft),
                              const SizedBox(height: 12),
                              Text(
                                'Вы ещё не создали заданий',
                                style: AppTypography.titleSmall,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Используйте пошаговый конструктор для проектирования методических занятий',
                                style: AppTypography.caption,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userTasks.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final task = userTasks[index];
                            final fields = task.fields;
                            final taskTitle = fields['task_title'] ??
                                'Развивающее задание';
                            final age = fields['age_group'] ?? '';
                            final goal = fields['goal'] ?? '';

                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    color: AppColors.divider),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.shadow,
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          taskTitle,
                                          style: AppTypography.titleSmall
                                              .copyWith(
                                            color: AppColors.woodDark,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: AppColors.accent,
                                            size: 20),
                                        onPressed: () {
                                          ref
                                              .read(
                                                  userTasksProvider.notifier)
                                              .remove(task.id);
                                        },
                                      ),
                                    ],
                                  ),
                                  if (age.isNotEmpty) ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.woodLight,
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        age,
                                        style: AppTypography.caption.copyWith(
                                          color: AppColors.woodDark,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                  Text(
                                    goal,
                                    style: AppTypography.bodyMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                        Icons.picture_as_pdf_rounded,
                                        size: 18),
                                    label: Text(l10n.exportPdf),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.teal,
                                      minimumSize: const Size(0, 38),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                    ),
                                    onPressed: () =>
                                        PdfGenerator.printOrSharePdf(task),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
