import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class AuthorScreen extends ConsumerStatefulWidget {
  const AuthorScreen({super.key});

  @override
  ConsumerState<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends ConsumerState<AuthorScreen> {
  int _selectedTab = 0;

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final repo = ref.watch(contentRepositoryProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(
          l10n.aboutAuthor,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: repo.getAuthorData(lang),
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
          final fullName = data['full_name'] as String? ?? '';
          final position = data['position'] as String? ?? '';
          final workplace = data['workplace'] as String? ?? '';
          final location = data['workplace_location'] as String? ?? '';
          final specialtyCode = data['specialty_code'] as String? ?? '';
          final specialtyName = data['specialty_name'] as String? ?? '';
          final orcid = data['orcid'] as String? ?? '';
          final address = data['address'] as String? ?? '';
          final aboutProject = data['about_project'] as String? ?? '';
          final languages = (data['languages'] as List<dynamic>?) ?? [];
          final education = (data['education'] as List<dynamic>?) ?? [];
          final career = (data['career'] as List<dynamic>?) ?? [];
          final certificates = (data['certificates'] as List<dynamic>?) ?? [];

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Hero Card
                _buildHeaderCard(
                  fullName: fullName,
                  position: position,
                  workplace: workplace,
                  location: location,
                  orcid: orcid,
                  l10n: l10n,
                ),

                const SizedBox(height: 16),

                // Tab Selector
                _buildTabSelector(l10n),

                const SizedBox(height: 16),

                // Content based on selected tab
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildTabContent(
                    tabIndex: _selectedTab,
                    specialtyCode: specialtyCode,
                    specialtyName: specialtyName,
                    address: address,
                    orcid: orcid,
                    languages: languages,
                    education: education,
                    career: career,
                    certificates: certificates,
                    aboutProject: aboutProject,
                    l10n: l10n,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderCard({
    required String fullName,
    required String position,
    required String workplace,
    required String location,
    required String orcid,
    required AppLocalizations l10n,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.wood, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.woodDark.withOpacity(0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Image.asset(
                    'assets/images/author_farangiz.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.woodLight,
                      child: const Icon(Icons.person,
                          size: 64, color: AppColors.woodDark),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            position,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$workplace\n$location',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSoft,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: InkWell(
              onTap: () => _copyToClipboard(
                context,
                orcid,
                '${l10n.copiedToClipboard}: $orcid',
              ),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFA6CE39).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFA6CE39).withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.fingerprint_rounded,
                      size: 18,
                      color: Color(0xFF75971E),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ORCID: $orcid',
                      style: AppTypography.labelMedium.copyWith(
                        color: const Color(0xFF4C6A0A),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.copy_rounded,
                      size: 14,
                      color: Color(0xFF75971E),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector(AppLocalizations l10n) {
    final tabs = [
      {'title': l10n.authorGeneralInfo, 'icon': Icons.info_outline_rounded},
      {'title': l10n.authorEducation, 'icon': Icons.school_outlined},
      {'title': l10n.authorCareer, 'icon': Icons.work_outline_rounded},
      {'title': l10n.authorCertificates, 'icon': Icons.workspace_premium_outlined},
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedTab == index;
          final tab = tabs[index];
          return InkWell(
            onTap: () => setState(() => _selectedTab = index),
            borderRadius: BorderRadius.circular(14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.woodDark : AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.woodDark : AppColors.divider,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.woodDark.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    tab['icon'] as IconData,
                    size: 17,
                    color: isSelected ? Colors.white : AppColors.textSoft,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    tab['title'] as String,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabContent({
    required int tabIndex,
    required String specialtyCode,
    required String specialtyName,
    required String address,
    required String orcid,
    required List<dynamic> languages,
    required List<dynamic> education,
    required List<dynamic> career,
    required List<dynamic> certificates,
    required String aboutProject,
    required AppLocalizations l10n,
  }) {
    switch (tabIndex) {
      case 0:
        return _buildGeneralTab(
          specialtyCode: specialtyCode,
          specialtyName: specialtyName,
          address: address,
          orcid: orcid,
          languages: languages,
          aboutProject: aboutProject,
          l10n: l10n,
        );
      case 1:
        return _buildEducationTab(education, l10n);
      case 2:
        return _buildCareerTab(career, l10n);
      case 3:
        return _buildCertificatesTab(certificates, l10n);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildGeneralTab({
    required String specialtyCode,
    required String specialtyName,
    required String address,
    required String orcid,
    required List<dynamic> languages,
    required String aboutProject,
    required AppLocalizations l10n,
  }) {
    return Column(
      children: [
        // Scientific Specialty Card
        _buildInfoCard(
          icon: Icons.science_outlined,
          iconColor: AppColors.teal,
          title: 'Научная специальность исследования',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.teal.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  specialtyCode,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontWeight: FontWeight.w900,
                    color: AppColors.teal,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                specialtyName,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Languages Card
        _buildInfoCard(
          icon: Icons.translate_rounded,
          iconColor: AppColors.woodDark,
          title: 'Владение языками / Tillarni bilishi',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: languages.map((lang) {
              final name = lang['name']?.toString() ?? '';
              final level = lang['level']?.toString() ?? '';
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.woodLight.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.woodDark.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.text,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.woodDark,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        level,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 12),

        // Address Card
        _buildInfoCard(
          icon: Icons.location_on_outlined,
          iconColor: AppColors.accent,
          title: 'Адрес / Manzil',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  address,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.text,
                    height: 1.4,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded,
                    size: 18, color: AppColors.textSoft),
                onPressed: () => _copyToClipboard(
                  context,
                  address,
                  '${l10n.copiedToClipboard}: $address',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // About the Methodology
        _buildInfoCard(
          icon: Icons.menu_book_rounded,
          iconColor: AppColors.woodDark,
          title: l10n.authorMethodology,
          child: Text(
            aboutProject,
            style: AppTypography.caption.copyWith(
              color: AppColors.text,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEducationTab(List<dynamic> education, AppLocalizations l10n) {
    return Column(
      children: education.map((item) {
        final level = item['level']?.toString() ?? '';
        final institution = item['institution']?.toString() ?? '';
        final period = item['period']?.toString() ?? '';
        final degree = item['degree']?.toString() ?? '';
        final degreeDate = item['degree_date']?.toString() ?? '';
        final code = item['code']?.toString() ?? '';
        final field = item['field']?.toString() ?? '';
        final qualification = item['qualification']?.toString() ?? '';
        final diplomaNumber = item['diploma_number']?.toString() ?? '';

        final isMaster = level.contains('магистратура') || level.contains('magistratura');

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isMaster
                  ? AppColors.teal.withOpacity(0.4)
                  : AppColors.divider,
            ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMaster
                          ? AppColors.teal.withOpacity(0.12)
                          : AppColors.woodDark.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      color: isMaster ? AppColors.teal : AppColors.woodDark,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: isMaster ? AppColors.teal : AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          institution,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSoft,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Text(
                      period,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textSoft,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 22),
              _buildKeyValueRow('Степень / Daraja:', '$degree ($degreeDate)'),
              const SizedBox(height: 6),
              _buildKeyValueRow('Специальность:', '$code — $field'),
              const SizedBox(height: 6),
              _buildKeyValueRow('Квалификация:', qualification),
              const SizedBox(height: 6),
              _buildKeyValueRow('Диплом №:', diplomaNumber),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCareerTab(List<dynamic> career, AppLocalizations l10n) {
    return Column(
      children: List.generate(career.length, (index) {
        final item = career[index];
        final period = item['period']?.toString() ?? '';
        final pos = item['position']?.toString() ?? '';
        final org = item['organization']?.toString() ?? '';
        final isCurrent = index == 0;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline line & indicator
              SizedBox(
                width: 36,
                child: Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isCurrent ? AppColors.accent : AppColors.woodDark,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: (isCurrent
                                    ? AppColors.accent
                                    : AppColors.woodDark)
                                .withOpacity(0.4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    if (index < career.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: AppColors.divider,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Card
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isCurrent
                          ? AppColors.accent.withOpacity(0.35)
                          : AppColors.divider,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: (isCurrent
                                        ? AppColors.accent
                                        : AppColors.woodDark)
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                period,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamily,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  color: isCurrent
                                      ? AppColors.accent
                                      : AppColors.woodDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Hozirda / Текущая',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pos,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        org,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSoft,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCertificatesTab(
      List<dynamic> certificates, AppLocalizations l10n) {
    return Column(
      children: certificates.map((cert) {
        final title = cert['title']?.toString() ?? '';
        final issuer = cert['issuer']?.toString() ?? '';
        final docNum = cert['doc_number']?.toString() ?? '';
        final level = cert['level']?.toString() ?? '';
        final details = cert['details']?.toString();
        final subject = cert['subject']?.toString();
        final valid = cert['valid_until']?.toString();

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: AppColors.accent,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          issuer,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSoft,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.woodDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      level,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              _buildKeyValueRow('Hujjat / Документ:', docNum),
              if (subject != null) ...[
                const SizedBox(height: 6),
                _buildKeyValueRow('Fan / Предмет:', subject),
              ],
              if (details != null) ...[
                const SizedBox(height: 6),
                _buildKeyValueRow('Tavsif / Описание:', details),
              ],
              if (valid != null) ...[
                const SizedBox(height: 6),
                _buildKeyValueRow('Amal qilish muddati:', valid),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              key,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textSoft,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
