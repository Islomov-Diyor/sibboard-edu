// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'SIBBOARD EDU';

  @override
  String get homeNav => 'Bosh sahifa';

  @override
  String get goalsNav => 'Maqsad';

  @override
  String get capabilitiesNav => 'Imkoniyatlar';

  @override
  String get workNav => 'Ish';

  @override
  String get rulesNav => 'Qoidalar';

  @override
  String get search => 'Qidiruv';

  @override
  String get favorites => 'Sevimlilar';

  @override
  String get settings => 'Sozlamalar';

  @override
  String get searchHint =>
      'Bo\'limlar, mavzular va tushunchalar bo\'yicha qidiruv...';

  @override
  String get noSearchResults => 'Hech narsa topilmadi';

  @override
  String get searchResults => 'Qidiruv natijalari';

  @override
  String get emptyFavorites => 'Sevimlilarda hozircha hech narsa yo\'q';

  @override
  String get emptyFavoritesSubtitle =>
      'Muhim kartalar, mavzular va qoidalarni tezkor kirish uchun saqlab qo\'ying';

  @override
  String get clearFavorites => 'Barchasini tozalash';

  @override
  String get language => 'Interfeys tili';

  @override
  String get russian => 'Русский';

  @override
  String get uzbek => 'O\'zbekcha';

  @override
  String get fontSize => 'Shrift o\'lchami';

  @override
  String get fontStandard => 'Standart';

  @override
  String get fontMedium => 'O\'rtacha';

  @override
  String get fontLarge => 'Katta';

  @override
  String get readingProgress => 'Materiallarni o\'rganish darajasi';

  @override
  String get aboutApp => 'Ilova haqida';

  @override
  String get appVersion => 'Versiya';

  @override
  String get projectAuthor => 'Metodik materiallar muallifi';

  @override
  String get authorPlaceholder =>
      'Farangiz (Nizomiy nomidagi Toshkent davlat pedagogika universiteti)';

  @override
  String get resetProgress => 'Jarayonni qayta o\'rnatish';

  @override
  String get progressResetSuccess => 'Jarayon muvaffaqiyatli qayta o\'rnatildi';

  @override
  String get readMore => 'Davomini o\'qish';

  @override
  String get showLess => 'Qisqartirish';

  @override
  String get back => 'Orqaga';

  @override
  String get next => 'Keyingi';

  @override
  String get save => 'Saqlash';

  @override
  String get share => 'Ulashish';

  @override
  String get exportPdf => 'PDF ga eksport qilish';

  @override
  String get clear => 'Tozalash';

  @override
  String get create => 'Yaratish';

  @override
  String get details => 'Batafsil';

  @override
  String get completed => 'Bajarildi';

  @override
  String get retry => 'Qayta urinish';

  @override
  String get errorOccurred => 'Yuklashda xatolik yuz berdi';

  @override
  String get markAsRead => 'O\'rganilgan deb belgilash';

  @override
  String get alreadyRead => 'Bo\'lim o\'rganilgan';

  @override
  String get goalsTabKids => 'Bolalar uchun vazifalar';

  @override
  String get goalsTabPedagogues => 'Bo\'lajak pedagoglar uchun';

  @override
  String get flipCardHint => 'Batafsil ko\'rish uchun kartani bosing';

  @override
  String get flipCardBackTitle => 'Nima rivojlanadi:';

  @override
  String get workSubTabTopics => 'Mavzular';

  @override
  String get workSubTabStages => '5 bosqich';

  @override
  String get workSubTabAlgorithm => 'Algoritm';

  @override
  String get workSubTabVirtualBoard => 'Interaktiv taxta';

  @override
  String get workSubTabBuilder => 'Topshiriq konstruktori';

  @override
  String get safetyChecklistTitle => 'Tayyorgarlik va xavfsizlik chek-listi';

  @override
  String get safetyAllChecked =>
      'Barcha talablar bajarildi! Xavfsiz muhit tayyor ✓';

  @override
  String get clearChecklist => 'Belgilarni tozalash';

  @override
  String get myTasksTitle => 'Mening saqlangan topshiriqlarim';

  @override
  String get newTask => 'Yangi topshiriq yaratish';

  @override
  String get deleteTask => 'Topshiriqni o\'chirish';

  @override
  String get taskSavedSuccess => 'Topshiriq xotiraga muvaffaqiyatli saqlandi';

  @override
  String stepProgress(Object current, Object total) {
    return '$total dan $current-qadam';
  }

  @override
  String get ageGroup => 'Yosh guruhi';

  @override
  String get eduDirection => 'Ta\'lim yo\'nalishi';

  @override
  String get taskGoal => 'Topshiriq maqsadi';

  @override
  String get sibboardElement => 'Sibbord elementi';

  @override
  String get taskContent => 'Topshiriq mazmuni';

  @override
  String get childActions => 'Bola harakatlari';

  @override
  String get pedagogueQuestions => 'Pedagog savollari';

  @override
  String get expectedResult => 'Kutilgan natija';

  @override
  String get evaluationMethod => 'Baholash usuli';

  @override
  String get galleryTitle => 'Sibbord fotogalereyasi';

  @override
  String get sampleTaskPrompt =>
      '4–5 yoshli bolalar uchun Sibbord asosida rivojlantiruvchi topshiriq loyihalang';

  @override
  String get quickActionsTitle => 'Bo\'limlarga tezkor o\'tish';
}
