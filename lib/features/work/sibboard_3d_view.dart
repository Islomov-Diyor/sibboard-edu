import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class Sibboard3dView extends StatefulWidget {
  final bool showHeader;

  const Sibboard3dView({
    super.key,
    this.showHeader = true,
  });

  @override
  State<Sibboard3dView> createState() => _Sibboard3dViewState();
}

class _Sibboard3dViewState extends State<Sibboard3dView>
    with SingleTickerProviderStateMixin {
  // 3D Orbit angles
  double _yaw = 0.5; // Horizontal rotation
  double _pitch = 0.35; // Vertical tilt
  double _scale = 1.0; // Zoom scale (0.7x to 2.8x)
  double _baseScale = 1.0;

  bool _isAutoRotating = true;
  bool _isLayerDetailMode = false;
  int? _selectedHotspotIndex;

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..addListener(() {
        if (_isAutoRotating) {
          setState(() {
            _yaw += 0.007;
            if (_yaw > math.pi * 2) {
              _yaw -= math.pi * 2;
            }
          });
        }
      });

    _animController.repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _resetView() {
    setState(() {
      _yaw = 0.5;
      _pitch = 0.35;
      _scale = 1.0;
      _isLayerDetailMode = false;
      _selectedHotspotIndex = null;
    });
  }

  void _toggleLayerMode() {
    setState(() {
      _isLayerDetailMode = !_isLayerDetailMode;
      if (_isLayerDetailMode) {
        _isAutoRotating = false;
        _pitch = 0.15;
        _yaw = 1.25;
        _scale = 2.1;
      } else {
        _scale = 1.0;
        _pitch = 0.35;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (widget.showHeader)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.woodLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.wood.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.view_in_ar_rounded,
                      size: 22, color: AppColors.woodDark),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.model3dSubtitle,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.woodDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        // 3D Interactive Canvas Box
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Studio Background Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.1,
                        colors: [
                          AppColors.surface,
                          AppColors.woodLight.withOpacity(0.5),
                          const Color(0xFFE2D6C6),
                        ],
                      ),
                    ),
                  ),

                  // Gesture Detector for 360 Orbit & Zoom
                  GestureDetector(
                    onScaleStart: (details) {
                      _baseScale = _scale;
                      setState(() {
                        _isAutoRotating = false;
                      });
                    },
                    onScaleUpdate: (details) {
                      setState(() {
                        if (details.pointerCount > 1) {
                          _scale = (_baseScale * details.scale).clamp(0.7, 3.0);
                        } else {
                          _yaw += details.focalPointDelta.dx * 0.012;
                          _pitch = (_pitch + details.focalPointDelta.dy * 0.012)
                              .clamp(-0.7, 0.75);
                        }
                      });
                    },
                    onDoubleTap: _resetView,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: _Sibboard3dPainter(
                        yaw: _yaw,
                        pitch: _pitch,
                        scale: _scale,
                        isLayerDetailMode: _isLayerDetailMode,
                        selectedHotspot: _selectedHotspotIndex,
                      ),
                    ),
                  ),

                  // Interactive Hotspot Action Badges
                  if (!_isLayerDetailMode)
                    Positioned(
                      top: 14,
                      left: 14,
                      right: 14,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildHotspotPill(
                              index: 0,
                              label: l10n.model3dHotspotRadius,
                              icon: Icons.architecture_rounded,
                            ),
                            const SizedBox(width: 8),
                            _buildHotspotPill(
                              index: 1,
                              label: l10n.model3dHotspotLayers,
                              icon: Icons.layers_rounded,
                            ),
                            const SizedBox(width: 8),
                            _buildHotspotPill(
                              index: 2,
                              label: l10n.model3dHotspotFelt,
                              icon: Icons.shield_rounded,
                            ),
                            const SizedBox(width: 8),
                            _buildHotspotPill(
                              index: 3,
                              label: l10n.model3dHotspotWeight,
                              icon: Icons.fitness_center_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Active Hotspot Info Card Popup
                  if (_selectedHotspotIndex != null)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 74,
                      child: _buildHotspotDetailCard(l10n),
                    ),

                  // Bottom Controls Bar
                  Positioned(
                    left: 14,
                    right: 14,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.woodLight),
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
                          // Toggle Layer Texture Mode
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Icon(
                                _isLayerDetailMode
                                    ? Icons.threesixty_rounded
                                    : Icons.layers_rounded,
                                size: 16,
                              ),
                              label: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  _isLayerDetailMode
                                      ? l10n.model3dOverviewBtn
                                      : l10n.model3dLayersBtn,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isLayerDetailMode
                                    ? AppColors.accent
                                    : AppColors.woodDark,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                minimumSize: const Size(0, 36),
                              ),
                              onPressed: _toggleLayerMode,
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Auto-rotate Button
                          IconButton(
                            icon: Icon(
                              _isAutoRotating
                                  ? Icons.pause_circle_filled_rounded
                                  : Icons.play_circle_fill_rounded,
                              color: _isAutoRotating
                                  ? AppColors.woodDark
                                  : AppColors.textSoft,
                            ),
                            tooltip: l10n.model3dAutoRotate,
                            onPressed: () {
                              setState(() {
                                _isAutoRotating = !_isAutoRotating;
                              });
                            },
                          ),

                          // Reset Camera
                          IconButton(
                            icon: const Icon(Icons.restart_alt_rounded,
                                color: AppColors.woodDark),
                            tooltip: l10n.model3dReset,
                            onPressed: _resetView,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHotspotPill({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedHotspotIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedHotspotIndex = isSelected ? null : index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.divider,
            width: 1.2,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? Colors.white : AppColors.woodDark,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotspotDetailCard(AppLocalizations l10n) {
    String title = '';
    String desc = '';

    switch (_selectedHotspotIndex) {
      case 0:
        title = 'Egilish radiusi (R = 120 sm) • Радиус дуги';
        desc =
            'Ushbu egrilik radiusi bolalarning vestibulyar tizimini haddan tashqari xavf ostiga qo\'ymasdan, muvozanat va fazoviy oriyentatsiyani rivojlantirish uchun standart hisoblanadi.';
        break;
      case 1:
        title = '15 mm qayin fanerasi • 11–15 слоёв древесины';
        desc =
            'Har biri 1.2–1.4 mm qalinlikdagi tabiiy qayin qatlamlari bosim ostida yopishtiriladi. Elastiklik, shovqinsiz egiluvchanlik va mustahkamlikni ta\'minlaydi.';
        break;
      case 2:
        title = 'Shovqinsiz kigiz • Фетровое покрытие';
        desc =
            'Taxtaning ostki yuzasiga qoplangan kigiz yoki probka pol qoplamasini chizilishdan asraydi va mashg\'ulot paytida ovozni yutadi.';
        break;
      case 3:
        title = '150 kg yuklama • Нагрузка до 150 кг';
        desc =
            'Kattalar va bolalarning birgalikdagi juftlik mashqlari hamda dinamik sakrashlariga to\'liq chidamli xavfsizlik darajasi.';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded,
              color: AppColors.accent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.woodDark,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.text,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.close_rounded, size: 18),
            onPressed: () {
              setState(() {
                _selectedHotspotIndex = null;
              });
            },
          ),
        ],
      ),
    );
  }
}

/// 3D Geometry and Wood Texture Painter
class _Sibboard3dPainter extends CustomPainter {
  final double yaw;
  final double pitch;
  final double scale;
  final bool isLayerDetailMode;
  final int? selectedHotspot;

  _Sibboard3dPainter({
    required this.yaw,
    required this.pitch,
    required this.scale,
    required this.isLayerDetailMode,
    required this.selectedHotspot,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Ground Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + 90 * scale),
        width: 220 * scale,
        height: 48 * scale,
      ),
      shadowPaint,
    );

    // Board Dimensions in 3D Space
    const boardLength = 190.0;
    const boardWidth = 84.0;
    const boardThickness = 12.0;
    const segments = 24;

    // Projection calculation:
    Offset project(double x, double y, double z) {
      // Rotate around Y axis (yaw)
      final x1 = x * math.cos(yaw) - z * math.sin(yaw);
      final z1 = x * math.sin(yaw) + z * math.cos(yaw);

      // Rotate around X axis (pitch)
      final y2 = y * math.cos(pitch) - z1 * math.sin(pitch);
      final z2 = y * math.sin(pitch) + z1 * math.cos(pitch);

      // Perspective projection
      const cameraDist = 480.0;
      final f = cameraDist / (cameraDist + z2);

      return Offset(cx + x1 * f * scale, cy + y2 * f * scale);
    }

    // Arch curve equation (Catenary / arc shape of the Sibboard)
    double getCurveY(double t) {
      // t is normalized from -1 to 1 along length
      // curve sagitta is about 32 units
      return (t * t - 0.4) * 32.0;
    }

    // Draw Bottom Felt / Cork Layer
    final feltPaint = Paint()
      ..color = const Color(0xFF6F5E4B)
      ..style = PaintingStyle.fill;

    // Draw Wood Veneer Layers and Surfaces
    final topSurfacePath = Path();
    final bottomSurfacePath = Path();
    final frontEdgePath = Path();
    final backEdgePath = Path();

    final topPointsLeft = <Offset>[];
    final topPointsRight = <Offset>[];
    final bottomPointsLeft = <Offset>[];
    final bottomPointsRight = <Offset>[];

    for (int i = 0; i <= segments; i++) {
      final t = -1.0 + (2.0 * i / segments);
      final x = t * (boardLength / 2);
      final archY = getCurveY(t);

      final ptTopLeft = project(x, archY, -boardWidth / 2);
      final ptTopRight = project(x, archY, boardWidth / 2);
      final ptBotLeft = project(x, archY + boardThickness, -boardWidth / 2);
      final ptBotRight = project(x, archY + boardThickness, boardWidth / 2);

      topPointsLeft.add(ptTopLeft);
      topPointsRight.add(ptTopRight);
      bottomPointsLeft.add(ptBotLeft);
      bottomPointsRight.add(ptBotRight);
    }

    // Build Front Edge Ribbon
    frontEdgePath.moveTo(topPointsRight[0].dx, topPointsRight[0].dy);
    for (int i = 1; i <= segments; i++) {
      frontEdgePath.lineTo(topPointsRight[i].dx, topPointsRight[i].dy);
    }
    for (int i = segments; i >= 0; i--) {
      frontEdgePath.lineTo(bottomPointsRight[i].dx, bottomPointsRight[i].dy);
    }
    frontEdgePath.close();

    // Build Top Surface
    topSurfacePath.moveTo(topPointsLeft[0].dx, topPointsLeft[0].dy);
    for (int i = 1; i <= segments; i++) {
      topSurfacePath.lineTo(topPointsLeft[i].dx, topPointsLeft[i].dy);
    }
    for (int i = segments; i >= 0; i--) {
      topSurfacePath.lineTo(topPointsRight[i].dx, topPointsRight[i].dy);
    }
    topSurfacePath.close();

    // Build Back Edge Ribbon
    backEdgePath.moveTo(topPointsLeft[0].dx, topPointsLeft[0].dy);
    for (int i = 1; i <= segments; i++) {
      backEdgePath.lineTo(topPointsLeft[i].dx, topPointsLeft[i].dy);
    }
    for (int i = segments; i >= 0; i--) {
      backEdgePath.lineTo(bottomPointsLeft[i].dx, bottomPointsLeft[i].dy);
    }
    backEdgePath.close();

    // 1. Draw Under-felt Surface
    bottomSurfacePath.moveTo(bottomPointsLeft[0].dx, bottomPointsLeft[0].dy);
    for (int i = 1; i <= segments; i++) {
      bottomSurfacePath.lineTo(bottomPointsLeft[i].dx, bottomPointsLeft[i].dy);
    }
    for (int i = segments; i >= 0; i--) {
      bottomSurfacePath.lineTo(bottomPointsRight[i].dx, bottomPointsRight[i].dy);
    }
    bottomSurfacePath.close();
    canvas.drawPath(bottomSurfacePath, feltPaint);

    // 2. Draw Back Edge (if facing camera)
    final backWoodPaint = Paint()
      ..color = const Color(0xFFC4A47C)
      ..style = PaintingStyle.fill;
    canvas.drawPath(backEdgePath, backWoodPaint);

    // 3. Draw Top Curved Board Surface with Natural Birch Wood Grain Shader
    final topWoodShader = LinearGradient(
      colors: const [
        Color(0xFFEAD8BA), // Light birch face
        Color(0xFFDFCAAA),
        Color(0xFFE6D2B3),
        Color(0xFFD6BE9C),
        Color(0xFFEADBBE),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(cx - 150, cy - 100, 300, 200));

    final topWoodPaint = Paint()
      ..shader = topWoodShader
      ..style = PaintingStyle.fill;
    canvas.drawPath(topSurfacePath, topWoodPaint);

    // Subtle Wood Grain Fibers (Curved contour lines on top face)
    final fiberPaint = Paint()
      ..color = const Color(0xFFBA9E79).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int w = 1; w < 4; w++) {
      final fiberPath = Path();
      final offsetZ = (-boardWidth / 2) + (boardWidth * w / 4);
      for (int i = 0; i <= segments; i++) {
        final t = -1.0 + (2.0 * i / segments);
        final x = t * (boardLength / 2);
        final archY = getCurveY(t) - 0.5;
        final pt = project(x, archY, offsetZ);
        if (i == 0) {
          fiberPath.moveTo(pt.dx, pt.dy);
        } else {
          fiberPath.lineTo(pt.dx, pt.dy);
        }
      }
      canvas.drawPath(fiberPath, fiberPaint);
    }

    // 4. Draw Front Plywood Edge & Plies (Cross-section)
    final frontWoodShader = LinearGradient(
      colors: const [
        Color(0xFFBA9B70),
        Color(0xFFD3B78F),
        Color(0xFFBA9B70),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(cx - 150, cy - 50, 300, 100));

    final frontWoodPaint = Paint()
      ..shader = frontWoodShader
      ..style = PaintingStyle.fill;
    canvas.drawPath(frontEdgePath, frontWoodPaint);

    // Micro Multi-ply Veneer Lines (11–15 Plies of Birch)
    const plyCount = 9;
    for (int p = 1; p < plyCount; p++) {
      final plyRatio = p / plyCount;
      final plyPaint = Paint()
        ..color = (p % 2 == 0)
            ? const Color(0xFF7A5C35).withOpacity(0.55)
            : const Color(0xFFE7D4B7).withOpacity(0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isLayerDetailMode ? 2.0 : 0.8;

      final plyPath = Path();
      for (int i = 0; i <= segments; i++) {
        final t = -1.0 + (2.0 * i / segments);
        final x = t * (boardLength / 2);
        final archY = getCurveY(t) + (boardThickness * plyRatio);
        final pt = project(x, archY, boardWidth / 2);
        if (i == 0) {
          plyPath.moveTo(pt.dx, pt.dy);
        } else {
          plyPath.lineTo(pt.dx, pt.dy);
        }
      }
      canvas.drawPath(plyPath, plyPaint);
    }

    // 5. Chamfer Outline Highlights
    final outlinePaint = Paint()
      ..color = const Color(0xFF96754E).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(topSurfacePath, outlinePaint);
    canvas.drawPath(frontEdgePath, outlinePaint);

    // 6. Draw Layer Cross-section Callout when in Macro Mode
    if (isLayerDetailMode) {
      final inspectPt = project(boardLength / 4, getCurveY(0.5), boardWidth / 2);

      final inspectBoxPaint = Paint()
        ..color = AppColors.accent.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(inspectPt, 32 * scale, inspectBoxPaint);

      // Callout Label Pointer
      final textSpan = TextSpan(
        text: '15 mm • 11 qatlamli qayin fanerasi\nEko-yog\'och faska burchagi R=3mm',
        style: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: AppColors.woodDark,
          backgroundColor: Colors.white.withOpacity(0.85),
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(inspectPt.dx + 12, inspectPt.dy - 34));
    }
  }

  @override
  bool shouldRepaint(covariant _Sibboard3dPainter oldDelegate) {
    return oldDelegate.yaw != yaw ||
        oldDelegate.pitch != pitch ||
        oldDelegate.scale != scale ||
        oldDelegate.isLayerDetailMode != isLayerDetailMode ||
        oldDelegate.selectedHotspot != selectedHotspot;
  }
}
