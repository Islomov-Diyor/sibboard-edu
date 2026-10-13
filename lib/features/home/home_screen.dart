import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';
import '../gallery/gallery_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isDefinitionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final repo = ref.watch(contentRepositoryProvider);
    final l10n = AppLocalizations.of(context)!;
    final readSections = ref.watch(readSectionsProvider);

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: repo.getHomeData(lang),
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
                    Text(l10n.errorOccurred,
                        style: AppTypography.titleSmall,
                        textAlign: TextAlign.center),
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
          final title = data['title'] as String? ?? 'Что такое Сибборд?';
          final subtitle = data['subtitle'] as String? ?? '';
          final heroImage = data['hero_image'] as String? ??
              'assets/images/06_kids_home_play.webp';
          final definition = data['definition'] as String? ?? '';
          final materialsInfo = data['materials_info'] as String? ?? '';
          final galleryImages = (data['gallery_images'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [];
          final chainSteps = (data['chain_steps'] as List<dynamic>?) ?? [];
          final accordions = (data['accordions'] as List<dynamic>?) ?? [];

          final isHomeRead = readSections.contains('home');

          return CustomScrollView(
            slivers: [
              // Hero Banner
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Hero(
                      tag: 'hero_home_image',
                      child: Container(
                        height: 240,
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
                          heroImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.woodLight,
                            child: const Center(
                              child: Icon(Icons.toys_rounded,
                                  size: 64, color: AppColors.woodDark),
                            ),
                          ),
                        ),
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
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'TEXNOLOGIYA ASOSLARI',
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
                              fontSize: 26,
                            ),
                          ),
                          if (subtitle.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: AppTypography.caption.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                              ),
                            ),
                          ],
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
                        color: isHomeRead
                            ? AppColors.successLight
                            : AppColors.woodLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isHomeRead
                              ? AppColors.success
                              : AppColors.wood,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isHomeRead
                                ? Icons.check_circle_rounded
                                : Icons.menu_book_rounded,
                            color: isHomeRead
                                ? AppColors.success
                                : AppColors.woodDark,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isHomeRead ? l10n.alreadyRead : l10n.markAsRead,
                              style: AppTypography.labelLarge.copyWith(
                                color: isHomeRead
                                    ? AppColors.success
                                    : AppColors.woodDark,
                              ),
                            ),
                          ),
                          if (!isHomeRead)
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(readSectionsProvider.notifier)
                                    .markRead('home');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.woodDark,
                                visualDensity: VisualDensity.compact,
                              ),
                              child: const Icon(Icons.check_rounded),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Main Definition Card with "Read More"
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.woodLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.info_outline_rounded,
                                      color: AppColors.woodDark, size: 20),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    title,
                                    style: AppTypography.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              _isDefinitionExpanded
                                  ? '$definition\n\n$materialsInfo'
                                  : (definition.length > 220
                                      ? '${definition.substring(0, 220)}...'
                                      : definition),
                              style: AppTypography.bodyLarge,
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isDefinitionExpanded =
                                      !_isDefinitionExpanded;
                                });
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _isDefinitionExpanded
                                          ? l10n.showLess
                                          : l10n.readMore,
                                      style:
                                          AppTypography.labelLarge.copyWith(
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      _isDefinitionExpanded
                                          ? Icons.keyboard_arrow_up_rounded
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.accent,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Gallery Section
                    if (galleryImages.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              l10n.galleryTitle,
                              style: AppTypography.titleMedium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Pinch-zoom',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryImages.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final imgPath = galleryImages[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => GalleryScreen(
                                      images: galleryImages,
                                      initialIndex: index,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.shadow,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    imgPath,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: AppColors.woodLight,
                                      child: const Icon(Icons.image,
                                          color: AppColors.woodDark),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Chain of 7 Steps (Visual horizontal flow)
                    if (chainSteps.isNotEmpty) ...[
                      Text(
                        'Деятельностная цепочка • Faoliyat zanjiri',
                        style: AppTypography.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '«увидеть → потрогать → выполнить действие → исследовать → подумать → получить результат → осмыслить»',
                        style: AppTypography.caption,
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 125,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: chainSteps.length,
                          separatorBuilder: (context, index) => Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: AppColors.woodDark,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final step = chainSteps[index];
                            final no = step['step'] ?? (index + 1);
                            final stitle = step['title'] as String? ?? '';
                            final desc = step['desc'] as String? ?? '';

                            return Container(
                              width: 140,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    color: AppColors.woodLight),
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
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: AppColors.woodLight,
                                    child: Text(
                                      '$no',
                                      style: const TextStyle(
                                        fontFamily: AppTypography.fontFamily,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: AppColors.woodDark,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    stitle,
                                    style: AppTypography.labelLarge.copyWith(
                                      fontSize: 13,
                                      color: AppColors.text,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    desc,
                                    style: AppTypography.caption.copyWith(
                                      fontSize: 11,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Accordions
                    Text(
                      'Теоретические и практические основы',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 12),

                    ...accordions.map((acc) {
                      final accTitle = acc['title'] as String? ?? '';
                      final accContent = acc['content'] as String? ?? '';
                      final accImage = acc['image'] as String?;

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
                              accTitle,
                              style: AppTypography.titleSmall.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.woodLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.auto_stories_rounded,
                                color: AppColors.woodDark,
                                size: 20,
                              ),
                            ),
                            childrenPadding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 20),
                            children: [
                              if (accImage != null) ...[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    accImage,
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const SizedBox.shrink(),
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                              Text(
                                accContent,
                                style: AppTypography.bodyLarge.copyWith(
                                  height: 1.55,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 24),

                    // Quick Jump Cards (4 section cards)
                    Text(
                      l10n.quickActionsTitle,
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 14),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.18,
                      children: [
                        _QuickCard(
                          title: l10n.goalsNav,
                          icon: Icons.flag_rounded,
                          color: AppColors.teal,
                          onTap: () => context.go('/goals'),
                        ),
                        _QuickCard(
                          title: l10n.capabilitiesNav,
                          icon: Icons.auto_awesome_rounded,
                          color: AppColors.accent,
                          onTap: () => context.go('/capabilities'),
                        ),
                        _QuickCard(
                          title: l10n.workNav,
                          icon: Icons.handyman_rounded,
                          color: AppColors.woodDark,
                          onTap: () => context.go('/work'),
                        ),
                        _QuickCard(
                          title: l10n.rulesNav,
                          icon: Icons.verified_user_rounded,
                          color: AppColors.success,
                          onTap: () => context.go('/rules'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 3D Sibboard Interactive Model Banner
                    InkWell(
                      onTap: () => context.push('/sibboard-3d'),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.accent.withOpacity(0.12),
                              AppColors.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.35),
                            width: 1.2,
                          ),
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
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.threesixty_rounded,
                                  color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.accent,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Text(
                                          'INTERAKTIV 3D',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    l10n.model3dTitle,
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color: AppColors.text,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.model3dSubtitle,
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.textSoft,
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColors.accent.withOpacity(0.12),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Author Profile Banner
                    InkWell(
                      onTap: () => context.push('/author'),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.wood.withOpacity(0.32),
                              AppColors.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.woodDark.withOpacity(0.3),
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 58,
                              height: 72,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.woodDark,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.woodDark.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/author_farangiz.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.person,
                                          color: AppColors.woodDark),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.woodDark,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          l10n.projectAuthor,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    l10n.authorFullName,
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: AppColors.text,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.authorWorkplace,
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.textSoft,
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor:
                                  AppColors.woodDark.withOpacity(0.12),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppColors.woodDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
}

class _QuickCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.3), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 19),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: AppTypography.labelLarge.copyWith(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, size: 15, color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
