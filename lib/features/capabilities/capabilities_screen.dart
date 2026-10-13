import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class CapabilitiesScreen extends ConsumerStatefulWidget {
  const CapabilitiesScreen({super.key});

  @override
  ConsumerState<CapabilitiesScreen> createState() => _CapabilitiesScreenState();
}

class _CapabilitiesScreenState extends ConsumerState<CapabilitiesScreen> {
  final Map<int, bool> _flippedCards = {};

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final repo = ref.watch(contentRepositoryProvider);
    final l10n = AppLocalizations.of(context)!;
    final readSections = ref.watch(readSectionsProvider);
    final isCapRead = readSections.contains('capabilities');
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: repo.getCapabilitiesData(lang),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
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
          final title =
              data['title'] as String? ?? 'Педагогические возможности';
          final overview = data['overview'] as String? ?? '';
          final keyIdea = data['key_idea'] as String? ?? '';
          final cards = (data['cards'] as List<dynamic>?) ?? [];

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '10 TA INTERAKTIV KARTA',
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
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        overview,
                        style: AppTypography.bodyMedium,
                      ),
                      const SizedBox(height: 16),

                      // Mark as read banner
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isCapRead
                              ? AppColors.successLight
                              : AppColors.accentLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isCapRead
                                ? AppColors.success
                                : AppColors.accent,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isCapRead
                                  ? Icons.check_circle_rounded
                                  : Icons.auto_awesome_rounded,
                              color: isCapRead
                                  ? AppColors.success
                                  : AppColors.accent,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                isCapRead ? l10n.alreadyRead : l10n.markAsRead,
                                style: AppTypography.labelLarge.copyWith(
                                  color: isCapRead
                                      ? AppColors.success
                                      : AppColors.accent,
                                ),
                              ),
                            ),
                            if (!isCapRead)
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(readSectionsProvider.notifier)
                                      .markRead('capabilities');
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.accent,
                                ),
                                child: const Icon(Icons.check_rounded),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.touch_app_rounded,
                              size: 16, color: AppColors.textSoft),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              l10n.flipCardHint,
                              style: AppTypography.caption,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 10 Flip Cards Grid (2 columns)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final cardData = cards[index];
                      final no = cardData['no'] as int? ?? (index + 1);
                      final cardTitle = cardData['title'] as String? ?? '';
                      final develops = cardData['develops'] as String? ?? '';
                      final imagePath = cardData['image'] as String? ?? '';
                      final backText = cardData['back'] as String? ?? '';
                      final cardKey = 'card_$no';
                      final isFav = favorites.contains(cardKey);
                      final isFlipped = _flippedCards[index] ?? false;

                      return _FlipCardWidget(
                        isFlipped: isFlipped,
                        onTap: () {
                          setState(() {
                            _flippedCards[index] = !isFlipped;
                          });
                        },
                        front: _CardFront(
                          no: no,
                          title: cardTitle,
                          imagePath: imagePath,
                          isFavorite: isFav,
                          onFavoriteTap: () {
                            ref
                                .read(favoritesProvider.notifier)
                                .toggle(cardKey);
                          },
                        ),
                        back: _CardBack(
                          no: no,
                          title: cardTitle,
                          develops: develops,
                          backText: backText,
                          isFavorite: isFav,
                          onFavoriteTap: () {
                            ref
                                .read(favoritesProvider.notifier)
                                .toggle(cardKey);
                          },
                          backLabel: l10n.flipCardBackTitle,
                        ),
                      );
                    },
                    childCount: cards.length,
                  ),
                ),
              ),

              // Key Idea Quote Block
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.4),
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
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.accentLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.format_quote_rounded,
                                  color: AppColors.accent, size: 24),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Ключевая идея раздела',
                                style: AppTypography.titleSmall.copyWith(
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          keyIdea,
                          style: AppTypography.bodyMedium.copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.55,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FlipCardWidget extends StatelessWidget {
  final bool isFlipped;
  final VoidCallback onTap;
  final Widget front;
  final Widget back;

  const _FlipCardWidget({
    required this.isFlipped,
    required this.onTap,
    required this.front,
    required this.back,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: isFlipped ? 180 : 0),
        duration: const Duration(milliseconds: 300),
        builder: (context, angle, child) {
          final isBack = angle >= 90;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY((angle * pi) / 180),
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: back,
                  )
                : front,
          );
        },
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  final int no;
  final String title;
  final String imagePath;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const _CardFront({
    required this.no,
    required this.title,
    required this.imagePath,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.woodLight,
                      child: const Icon(Icons.extension_rounded,
                          color: AppColors.woodDark, size: 40),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.black.withOpacity(0.6),
                      child: Text(
                        '$no',
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_outline_rounded,
                        color: isFavorite ? AppColors.accent : Colors.white,
                        size: 22,
                      ),
                      onPressed: onFavoriteTap,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 13,
                        color: AppColors.text,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Инфо',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 10, color: AppColors.accent),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  final int no;
  final String title;
  final String develops;
  final String backText;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final String backLabel;

  const _CardBack({
    required this.no,
    required this.title,
    required this.develops,
    required this.backText,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.backLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.4)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.accent,
                child: Text(
                  '$no',
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isFavorite
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_outline_rounded,
                  color: isFavorite ? AppColors.accent : AppColors.textSoft,
                  size: 20,
                ),
                onPressed: onFavoriteTap,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.accent,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              develops,
              style: AppTypography.caption.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                backText,
                style: AppTypography.caption.copyWith(
                  color: AppColors.text,
                  height: 1.35,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
