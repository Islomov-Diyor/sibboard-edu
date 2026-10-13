import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class TopicDetailScreen extends ConsumerWidget {
  final Map<String, dynamic> topic;

  const TopicDetailScreen({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final no = topic['no'] ?? 1;
    final title = topic['title'] as String? ?? '';
    final description = topic['description'] as String? ?? '';
    final image = topic['image'] as String?;

    final favorites = ref.watch(favoritesProvider);
    final topicKey = 'topic_$no';
    final isFav = favorites.contains(topicKey);

    return Scaffold(
      appBar: AppBar(
        title: Text('Тема $no', style: AppTypography.titleSmall),
        actions: [
          IconButton(
            tooltip: l10n.favorites,
            icon: Icon(
              isFav ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: isFav ? AppColors.accent : AppColors.text,
            ),
            onPressed: () {
              ref.read(favoritesProvider.notifier).toggle(topicKey);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 18),
            ],
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.woodDark,
                  child: Text(
                    '$no',
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.woodDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                description,
                style: AppTypography.bodyLarge.copyWith(height: 1.6),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_task_rounded),
              label: Text(l10n.newTask),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.woodDark,
              ),
              onPressed: () {
                context.push('/work/task-builder');
              },
            ),
          ],
        ),
      ),
    );
  }
}
