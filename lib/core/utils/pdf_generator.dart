import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../data/models/task_model.dart';

class PdfGenerator {
  PdfGenerator._();

  static Future<Uint8List> generateTaskPdf(UserTask task) async {
    final pdf = pw.Document();

    // Load Nunito font for Cyrillic and Latin support
    final fontData = await rootBundle.load('assets/fonts/Nunito.ttf');
    final nunitoFont = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(base: nunitoFont, bold: nunitoFont),
        build: (pw.Context context) {
          final fields = task.fields;

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0xFFFBF7F2),
                  borderRadius: pw.BorderRadius.circular(12),
                  border: pw.Border.all(
                    color: const PdfColor.fromInt(0xFFB88A55),
                    width: 1.5,
                  ),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'SIBBOARD EDU',
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: const PdfColor.fromInt(0xFFB88A55),
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Карта педагогического проектирования развивающего задания',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromInt(0xFF6F655D),
                          ),
                        ),
                      ],
                    ),
                    pw.Text(
                      '${task.created.day}.${task.created.month}.${task.created.year}',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        color: PdfColor.fromInt(0xFF6F655D),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Title
              pw.Text(
                fields['task_title'] ?? 'Развивающее задание на основе Сибборда',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: const PdfColor.fromInt(0xFF2B2623),
                ),
              ),
              pw.Divider(color: const PdfColor.fromInt(0xFFEFE8DE)),
              pw.SizedBox(height: 10),

              // Key parameters grid
              _buildPdfRow(
                  'Возрастная группа / Yosh guruhi:', fields['age_group'] ?? ''),
              _buildPdfRow('Образовательное направление / Ta\'lim yo\'nalishi:',
                  fields['direction'] ?? ''),
              _buildPdfRow(
                  'Элемент Сибборда / Sibbord elementi:', fields['element'] ?? ''),
              _buildPdfRow('Цель задания / Topshiriq maqsadi:', fields['goal'] ?? ''),
              _buildPdfRow('Содержание задания / Topshiriq mazmuni:',
                  fields['content'] ?? ''),
              _buildPdfRow(
                  'Действия ребёнка / Bola harakatlari:', fields['actions'] ?? ''),
              _buildPdfRow('Вопросы педагога / Pedagog savollari:',
                  fields['questions'] ?? ''),
              _buildPdfRow('Ожидаемый результат / Kutilgan natija:',
                  fields['result'] ?? ''),
              _buildPdfRow('Способ оценки / Baholash usuli:',
                  fields['evaluation'] ?? ''),

              pw.Spacer(),
              pw.Divider(color: const PdfColor.fromInt(0xFFEFE8DE)),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Создано в мобильном приложении SIBBOARD EDU',
                    style: const pw.TextStyle(
                      fontSize: 9,
                      color: PdfColor.fromInt(0xFF6F655D),
                    ),
                  ),
                  pw.Text(
                    'Toshkent davlat pedagogika universiteti',
                    style: const pw.TextStyle(
                      fontSize: 9,
                      color: PdfColor.fromInt(0xFF6F655D),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildPdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 170,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: const PdfColor.fromInt(0xFF6F655D),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: const pw.TextStyle(
                fontSize: 11,
                color: PdfColor.fromInt(0xFF2B2623),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> printOrSharePdf(UserTask task) async {
    final bytes = await generateTaskPdf(task);
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'sibboard_task_${task.id}.pdf',
    );
  }
}
