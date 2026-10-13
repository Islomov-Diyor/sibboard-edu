import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites, style: AppTypography.titleSmall),
        actions: [
          if (favorites.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(favoritesProvider.notifier).clearAll();
              },
              child: Text(l10n.clearFavorites),
            ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.woodLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_border_rounded,
                        size: 54,
                        color: AppColors.woodDark,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      l10n.emptyFavorites,
                      style: AppTypography.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.emptyFavoritesSubtitle,
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final favId = favorites.elementAt(index);
                final isCard = favId.startsWith('card_');
                final isTopic = favId.startsWith('topic_');

                String title = 'Элемент $favId';
                String subtitle = 'Сохранённый материал';
                String route = '/home';

                if (isCard) {
                  final num = favId.replaceFirst('card_', '');
                  title = 'Педагогическая возможность №$num';
                  subtitle = 'Интерактивная карточка развития';
                  route = '/capabilities';
                } else if (isTopic) {
                  final num = favId.replaceFirst('topic_', '');
                  title = 'Тема методической работы №$num';
                  subtitle = 'Раздел возможностей работы';
                  route = '/work';
                }

                return Container(
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
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isCard
                              ? AppColors.accentLight
                              : AppColors.woodLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isCard
                              ? Icons.auto_awesome_rounded
                              : Icons.menu_book_rounded,
                          color: isCard
                              ? AppColors.accent
                              : AppColors.woodDark,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: InkWell(
                          onTap: () => context.push(route),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: AppTypography.labelLarge),
                              const SizedBox(height: 2),
                              Text(subtitle, style: AppTypography.caption),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_remove_rounded,
                            color: AppColors.accent),
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggle(favId);
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
