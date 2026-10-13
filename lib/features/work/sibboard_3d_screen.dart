import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';
import 'sibboard_3d_view.dart';

class Sibboard3dScreen extends StatelessWidget {
  const Sibboard3dScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.model3dTitle,
          style: AppTypography.titleSmall,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.woodLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.threesixty_rounded, size: 16, color: AppColors.woodDark),
                SizedBox(width: 4),
                Text(
                  '360°',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.woodDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: Sibboard3dView(showHeader: true),
      ),
    );
  }
}
