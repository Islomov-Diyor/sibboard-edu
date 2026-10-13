import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/pdf_generator.dart';
import '../../data/models/task_model.dart';
import '../../l10n/app_localizations.dart';

class TaskBuilderScreen extends ConsumerStatefulWidget {
  final String? initialElement;

  const TaskBuilderScreen({
    super.key,
    this.initialElement,
  });

  @override
  ConsumerState<TaskBuilderScreen> createState() => _TaskBuilderScreenState();
}

class _TaskBuilderScreenState extends ConsumerState<TaskBuilderScreen> {
  int _currentStep = 0;

  // Wizard fields
  String _ageGroup = '4–5 лет';
  String _direction = 'Элементарные математические представления';
  final TextEditingController _goalController = TextEditingController();
  String _element = 'Шнуровка';
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _actionsController = TextEditingController();
  final TextEditingController _questionsController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  final TextEditingController _evaluationController = TextEditingController();

  final List<String> _ageGroups = [
    '3–4 года / yosh',
    '4–5 лет / yosh',
    '5–6 лет / yosh',
    '6–7 лет / yosh',
  ];

  final List<String> _directions = [
    'Речевое развитие (Nutqiy rivojlanish)',
    'Элементарные математические представления (Matematik tasavvurlar)',
    'Ознакомление с природой и окружающим миром (Tabiat va atrof-olam)',
    'Художественно-творческая деятельность (Badiiy-ijodiy)',
    'Конструктивная деятельность (Konstruktiv)',
    'Театрализованная деятельность (Teatrlashtirilgan)',
    'Игровая деятельность (O\'yin faoliyati)',
  ];

  final List<String> _elements = [
    '🔘 Пуговица (Tugma)',
    '🔐 Замок (Qulf)',
    '🔺 Геометрическая фигура (Geometrik shakl)',
    '🔄 Колёсико (G\'ildirakcha)',
    '🧵 Шнуровка (Shnurovka)',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialElement != null && widget.initialElement!.isNotEmpty) {
      final match = _elements.firstWhere(
        (e) => e.toLowerCase().contains(widget.initialElement!.toLowerCase()),
        orElse: () => _elements.last,
      );
      _element = match;
    }
  }

  @override
  void dispose() {
    _goalController.dispose();
    _contentController.dispose();
    _actionsController.dispose();
    _questionsController.dispose();
    _resultController.dispose();
    _evaluationController.dispose();
    super.dispose();
  }

  void _loadSampleTask() {
    setState(() {
      _ageGroup = '4–5 лет / yosh';
      _direction =
          'Элементарные математические представления (Matematik tasavvurlar)';
      _element = '🧵 Шнуровка (Shnurovka)';
      _goalController.text =
          'Развитие мелкой моторики, счета и пространственной ориентации (Fazoviy mo\'ljal va motorikani rivojlantirish)';
      _contentController.text =
          'Продень цветной шнурок через пронумерованные отверстия по порядку от 1 до 5';
      _actionsController.text =
          'Ребёнок называет цифры вслух и продевает шнурок последовательно в каждое отверстие';
      _questionsController.text =
          '«С какого номера ты начал? Какая цифра идёт следующей? Куда сейчас направляется шнурок?»';
      _resultController.text =
          'Шнурок правильно продет через все 5 отверстий, ребёнок самостоятельно объясняет последовательность';
      _evaluationController.text =
          'Оценка степени самостоятельности, правильности счёта и точности движений пальцев';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Образец методического задания успешно загружен ✓'),
        backgroundColor: AppColors.woodDark,
        duration: Duration(seconds: 2),
      ),
    );
  }

  UserTask _buildUserTask() {
    return UserTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      created: DateTime.now(),
      fields: {
        'task_title': 'Развивающее задание: $_element',
        'age_group': _ageGroup,
        'direction': _direction,
        'goal': _goalController.text.trim(),
        'element': _element,
        'content': _contentController.text.trim(),
        'actions': _actionsController.text.trim(),
        'questions': _questionsController.text.trim(),
        'result': _resultController.text.trim(),
        'evaluation': _evaluationController.text.trim(),
      },
    );
  }

  Future<void> _saveTask(AppLocalizations l10n) async {
    final task = _buildUserTask();
    await ref.read(userTasksProvider.notifier).save(task);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.taskSavedSuccess),
          backgroundColor: AppColors.success,
        ),
      );
      setState(() {
        _currentStep = 9; // Summary step
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.workSubTabBuilder, style: AppTypography.titleSmall),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.auto_fix_high_rounded, size: 18),
            label: const Text('Образец'),
            style: TextButton.styleFrom(foregroundColor: AppColors.accent),
            onPressed: _loadSampleTask,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Linear progress bar
          LinearProgressIndicator(
            value: (_currentStep + 1) / 10.0,
            backgroundColor: AppColors.woodLight,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentStep < 9
                      ? l10n.stepProgress((_currentStep + 1).toString(), '9')
                      : 'Готово / Xulosa',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _getStepTitle(_currentStep),
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: _buildStepContent(l10n),
            ),
          ),
          _buildNavigationBottomBar(l10n),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return '1. Возрастная группа';
      case 1:
        return '2. Направление';
      case 2:
        return '3. Цель задания';
      case 3:
        return '4. Элемент Сибборда';
      case 4:
        return '5. Содержание задания';
      case 5:
        return '6. Действия ребёнка';
      case 6:
        return '7. Вопросы педагога';
      case 7:
        return '8. Ожидаемый результат';
      case 8:
        return '9. Способ оценки';
      case 9:
        return 'Итоговая технологическая карта';
      default:
        return '';
    }
  }

  Widget _buildStepContent(AppLocalizations l10n) {
    switch (_currentStep) {
      case 0:
        return _buildChoiceStep(
          title: l10n.ageGroup,
          subtitle:
              'Выберите целевую возрастную группу воспитанников детского сада:',
          options: _ageGroups,
          selected: _ageGroup,
          onSelected: (val) => setState(() => _ageGroup = val),
        );
      case 1:
        return _buildChoiceStep(
          title: l10n.eduDirection,
          subtitle: 'Выберите образовательное направление согласно стандарту:',
          options: _directions,
          selected: _direction,
          onSelected: (val) => setState(() => _direction = val),
        );
      case 2:
        return _buildInputStep(
          title: l10n.taskGoal,
          subtitle: 'Сформулируйте развивающую цель:',
          controller: _goalController,
          hint:
              'Например: Развитие мелкой моторики, счета и пространственной ориентации',
          icon: Icons.track_changes_rounded,
        );
      case 3:
        return _buildChoiceStep(
          title: l10n.sibboardElement,
          subtitle: 'Выберите функциональный элемент Сибборда для задания:',
          options: _elements,
          selected: _element,
          onSelected: (val) => setState(() => _element = val),
        );
      case 4:
        return _buildInputStep(
          title: l10n.taskContent,
          subtitle: 'Опишите практическую задачу для ребёнка:',
          controller: _contentController,
          hint: 'Например: Продень шнурок через отверстия по порядку от 1 до 5',
          icon: Icons.edit_note_rounded,
        );
      case 5:
        return _buildInputStep(
          title: l10n.childActions,
          subtitle: 'Что конкретно делает ребёнок в процессе выполнения:',
          controller: _actionsController,
          hint:
              'Например: Ребёнок называет цифры вслух и продевает шнурок последовательно',
          icon: Icons.directions_run_rounded,
        );
      case 6:
        return _buildInputStep(
          title: l10n.pedagogueQuestions,
          subtitle: 'Какие стимулирующие вопросы задаёт педагог:',
          controller: _questionsController,
          hint:
              'Например: «С чего ты начал? Куда направишь шнурок дальше? Почему?»',
          icon: Icons.question_answer_rounded,
        );
      case 7:
        return _buildInputStep(
          title: l10n.expectedResult,
          subtitle: 'Ожидаемый образовательный и развивающий результат:',
          controller: _resultController,
          hint:
              'Например: Ребёнок самостоятельно выполнил цепочку действий и объяснил её',
          icon: Icons.verified_rounded,
        );
      case 8:
        return _buildInputStep(
          title: l10n.evaluationMethod,
          subtitle: 'Способ и критерии педагогической оценки:',
          controller: _evaluationController,
          hint:
              'Например: Наблюдение за степенью самостоятельности и правильностью счета',
          icon: Icons.grade_rounded,
        );
      case 9:
        return _buildSummaryCard(l10n);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildChoiceStep({
    required String title,
    required String subtitle,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.titleMedium),
        const SizedBox(height: 6),
        Text(subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: 18),
        ...options.map((opt) {
          final isSelected = opt == selected;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => onSelected(opt),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.accentLight : AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.divider,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color:
                          isSelected ? AppColors.accent : AppColors.textSoft,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        opt,
                        style: AppTypography.labelLarge.copyWith(
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildInputStep({
    required String title,
    required String subtitle,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: AppTypography.titleMedium),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: 16),
        TextField(
          controller: controller,
          maxLines: 4,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(AppLocalizations l10n) {
    final task = _buildUserTask();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent, width: 1.5),
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
                  const Icon(Icons.assignment_turned_in_rounded,
                      color: AppColors.accent, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Карта проектирования задания',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildSummaryRow(l10n.ageGroup, _ageGroup),
              _buildSummaryRow(l10n.eduDirection, _direction),
              _buildSummaryRow(l10n.sibboardElement, _element),
              _buildSummaryRow(
                  l10n.taskGoal,
                  _goalController.text.isNotEmpty
                      ? _goalController.text
                      : 'Не указано'),
              _buildSummaryRow(
                  l10n.taskContent,
                  _contentController.text.isNotEmpty
                      ? _contentController.text
                      : 'Не указано'),
              _buildSummaryRow(
                  l10n.childActions,
                  _actionsController.text.isNotEmpty
                      ? _actionsController.text
                      : 'Не указано'),
              _buildSummaryRow(
                  l10n.pedagogueQuestions,
                  _questionsController.text.isNotEmpty
                      ? _questionsController.text
                      : 'Не указано'),
              _buildSummaryRow(
                  l10n.expectedResult,
                  _resultController.text.isNotEmpty
                      ? _resultController.text
                      : 'Не указано'),
              _buildSummaryRow(
                  l10n.evaluationMethod,
                  _evaluationController.text.isNotEmpty
                      ? _evaluationController.text
                      : 'Не указано'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.picture_as_pdf_rounded),
                label: Text(l10n.exportPdf),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teal,
                ),
                onPressed: () => PdfGenerator.printOrSharePdf(task),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSoft,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBottomBar(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep--;
                    });
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(l10n.back),
                  ),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 14),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_currentStep < 8) {
                    setState(() {
                      _currentStep++;
                    });
                  } else if (_currentStep == 8) {
                    _saveTask(l10n);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _currentStep < 8
                        ? l10n.next
                        : (_currentStep == 8 ? l10n.save : l10n.completed),
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
