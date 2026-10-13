import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';
import 'sibboard_3d_view.dart';

class VirtualBoardView extends StatefulWidget {
  final List<dynamic> elements;
  final Function(Map<String, dynamic> element) onElementSelected;

  const VirtualBoardView({
    super.key,
    required this.elements,
    required this.onElementSelected,
  });

  @override
  State<VirtualBoardView> createState() => _VirtualBoardViewState();
}

class _VirtualBoardViewState extends State<VirtualBoardView>
    with SingleTickerProviderStateMixin {
  int? _activeElementIndex;
  late AnimationController _pulseController;
  int _viewMode = 0; // 0: 2D Elements, 1: 3D Model

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleElementTap(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _activeElementIndex = index;
    });

    final el = widget.elements[index] as Map<String, dynamic>;
    _showElementBottomSheet(el);
  }

  void _showElementBottomSheet(Map<String, dynamic> element) {
    final l10n = AppLocalizations.of(context)!;
    final name = element['name'] as String? ?? '';
    final develops = element['develops'] as String? ?? '';
    final task = element['task'] as String? ?? '';
    final symbol = element['symbol'] as String? ?? '✨';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 20,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.woodLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      symbol,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTypography.titleMedium,
                        ),
                        Text(
                          'Sibbord elementi',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.woodLight.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.wood),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.flipCardBackTitle,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.woodDark,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      develops,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.accentLight.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Рекомендуемое задание • Tavsiya etiladigan topshiriq:',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.accent,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_task_rounded),
                label: Text(l10n.newTask),
                onPressed: () {
                  Navigator.pop(context);
                  widget.onElementSelected(element);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Mode Selector: 2D Elements Map vs 3D Model
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.woodLight.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.divider),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _viewMode = 0),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _viewMode == 0
                                  ? AppColors.woodDark
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '2D Sxema • Elementlar',
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _viewMode == 0
                                      ? Colors.white
                                      : AppColors.text,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _viewMode = 1),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _viewMode == 1
                                  ? AppColors.woodDark
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.threesixty_rounded,
                                    size: 15,
                                    color: _viewMode == 1
                                        ? Colors.white
                                        : AppColors.accent,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '3D Model • 360°',
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamily,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _viewMode == 1
                                          ? Colors.white
                                          : AppColors.text,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_viewMode == 1) ...[
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'To\'liq ekran',
                  icon: const Icon(Icons.fullscreen_rounded,
                      color: AppColors.woodDark),
                  onPressed: () => context.push('/sibboard-3d'),
                ),
              ],
            ],
          ),
        ),

        if (_viewMode == 1)
          const Expanded(
            child: Sibboard3dView(showHeader: false),
          )
        else ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.woodLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.touch_app_rounded,
                      size: 18, color: AppColors.woodDark),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Taxtadagi elementlarni bosing va ularning pedagogik ahamiyatini o\'rganing',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.woodDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;

                return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        // Wooden board background custom painter
                        CustomPaint(
                          size: Size(width, height),
                          painter: _WoodenBoardPainter(),
                        ),

                        // 5 interactive element buttons laid out across the board
                        ...List.generate(widget.elements.length, (index) {
                          final el = widget.elements[index] as Map<String, dynamic>;
                          final id = el['id'] as String? ?? '';
                          final name = el['name'] as String? ?? '';
                          final symbol = el['symbol'] as String? ?? '🔘';

                          // Positions on the board (normalized 0..1)
                          final positions = [
                            const Offset(0.25, 0.28), // Button (top-left)
                            const Offset(0.75, 0.28), // Lock (top-right)
                            const Offset(0.50, 0.52), // Shape (center)
                            const Offset(0.25, 0.76), // Wheel (bottom-left)
                            const Offset(0.75, 0.76), // Lacing (bottom-right)
                          ];

                          final pos = index < positions.length
                              ? positions[index]
                              : Offset(0.5, 0.2 * index);

                          final isSelected = _activeElementIndex == index;

                          return Positioned(
                            left: pos.dx * width - 42,
                            top: pos.dy * height - 42,
                            child: GestureDetector(
                              onTap: () => _handleElementTap(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.accentLight
                                      : Colors.white.withOpacity(0.92),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.accent
                                        : AppColors.woodDark,
                                    width: isSelected ? 3 : 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildVectorIcon(id, symbol, isSelected),
                                    const SizedBox(height: 2),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                          fontFamily: AppTypography.fontFamily,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10,
                                          color: isSelected
                                              ? AppColors.accent
                                              : AppColors.text,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ],
  );
  }

  Widget _buildVectorIcon(String id, String fallbackEmoji, bool isSelected) {
    final color = isSelected ? AppColors.accent : AppColors.woodDark;
    IconData icon;
    switch (id) {
      case 'button':
        icon = Icons.radio_button_checked_rounded;
        break;
      case 'lock':
        icon = Icons.lock_rounded;
        break;
      case 'geo_shape':
        icon = Icons.change_history_rounded;
        break;
      case 'wheel':
        icon = Icons.settings_rounded;
        break;
      case 'lacing':
        icon = Icons.gesture_rounded;
        break;
      default:
        icon = Icons.extension_rounded;
    }
    return Icon(icon, size: 28, color: color);
  }
}

class _WoodenBoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Wood base gradient
    final woodPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE8C9A0),
          Color(0xFFDAB384),
          Color(0xFFE4C297),
          Color(0xFFC99F6C),
        ],
      ).createShader(rect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(28)),
      woodPaint,
    );

    // Board wood grain lines
    final grainPaint = Paint()
      ..color = const Color(0xFFB88A55).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (var i = 1; i <= 6; i++) {
      final y = size.height * (i / 7.0);
      final path = Path()
        ..moveTo(0, y)
        ..quadraticBezierTo(
          size.width * 0.35,
          y - 12,
          size.width * 0.65,
          y + 10,
        )
        ..quadraticBezierTo(
          size.width * 0.85,
          y - 4,
          size.width,
          y + 6,
        );
      canvas.drawPath(path, grainPaint);
    }

    // Inner bevel border
    final borderPaint = Paint()
      ..color = const Color(0xFF9E7242).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.deflate(6),
        const Radius.circular(22),
      ),
      borderPaint,
    );

    // Decorative corner brass studs
    final studPaint = Paint()..color = const Color(0xFFB88A55);
    final studBorder = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final studOffsets = [
      const Offset(22, 22),
      Offset(size.width - 22, 22),
      Offset(22, size.height - 22),
      Offset(size.width - 22, size.height - 22),
    ];

    for (final offset in studOffsets) {
      canvas.drawCircle(offset, 6, studPaint);
      canvas.drawCircle(offset, 6, studBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
