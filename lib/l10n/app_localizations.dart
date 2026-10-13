import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'SIBBOARD EDU'**
  String get appTitle;

  /// No description provided for @homeNav.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get homeNav;

  /// No description provided for @goalsNav.
  ///
  /// In ru, this message translates to:
  /// **'Цели'**
  String get goalsNav;

  /// No description provided for @capabilitiesNav.
  ///
  /// In ru, this message translates to:
  /// **'Возможности'**
  String get capabilitiesNav;

  /// No description provided for @workNav.
  ///
  /// In ru, this message translates to:
  /// **'Практика'**
  String get workNav;

  /// No description provided for @rulesNav.
  ///
  /// In ru, this message translates to:
  /// **'Правила'**
  String get rulesNav;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @favorites.
  ///
  /// In ru, this message translates to:
  /// **'Избранное'**
  String get favorites;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @searchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по разделам, темам и понятиям...'**
  String get searchHint;

  /// No description provided for @noSearchResults.
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get noSearchResults;

  /// No description provided for @searchResults.
  ///
  /// In ru, this message translates to:
  /// **'Результаты поиска'**
  String get searchResults;

  /// No description provided for @emptyFavorites.
  ///
  /// In ru, this message translates to:
  /// **'В избранном пока ничего нет'**
  String get emptyFavorites;

  /// No description provided for @emptyFavoritesSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Сохраняйте карточки возможностей, темы и правила для быстрого доступа'**
  String get emptyFavoritesSubtitle;

  /// No description provided for @clearFavorites.
  ///
  /// In ru, this message translates to:
  /// **'Очистить все'**
  String get clearFavorites;

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Язык интерфейса'**
  String get language;

  /// No description provided for @russian.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @uzbek.
  ///
  /// In ru, this message translates to:
  /// **'O\'zbekcha'**
  String get uzbek;

  /// No description provided for @fontSize.
  ///
  /// In ru, this message translates to:
  /// **'Размер шрифта'**
  String get fontSize;

  /// No description provided for @fontStandard.
  ///
  /// In ru, this message translates to:
  /// **'Стандартный'**
  String get fontStandard;

  /// No description provided for @fontMedium.
  ///
  /// In ru, this message translates to:
  /// **'Средний'**
  String get fontMedium;

  /// No description provided for @fontLarge.
  ///
  /// In ru, this message translates to:
  /// **'Крупный'**
  String get fontLarge;

  /// No description provided for @readingProgress.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс изучения материалов'**
  String get readingProgress;

  /// No description provided for @aboutApp.
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get aboutApp;

  /// No description provided for @appVersion.
  ///
  /// In ru, this message translates to:
  /// **'Версия'**
  String get appVersion;

  /// No description provided for @projectAuthor.
  ///
  /// In ru, this message translates to:
  /// **'Автор методических материалов'**
  String get projectAuthor;

  /// No description provided for @authorPlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Нумонжонова Фарангиз Комилжон кизи (Университет экономики и педагогики, г. Карши)'**
  String get authorPlaceholder;

  /// No description provided for @authorFullName.
  ///
  /// In ru, this message translates to:
  /// **'Нумонжонова Фарангиз Комилжон кизи'**
  String get authorFullName;

  /// No description provided for @authorPosition.
  ///
  /// In ru, this message translates to:
  /// **'Ассистент-преподаватель кафедры «Дошкольного образования»'**
  String get authorPosition;

  /// No description provided for @authorWorkplace.
  ///
  /// In ru, this message translates to:
  /// **'Университет экономики и педагогики (г. Карши)'**
  String get authorWorkplace;

  /// No description provided for @authorSpecialty.
  ///
  /// In ru, this message translates to:
  /// **'13.00.01 — Теория педагогики. История педагогических учений'**
  String get authorSpecialty;

  /// No description provided for @aboutAuthor.
  ///
  /// In ru, this message translates to:
  /// **'Сведения об авторе'**
  String get aboutAuthor;

  /// No description provided for @viewAuthorProfile.
  ///
  /// In ru, this message translates to:
  /// **'Подробнее об авторе'**
  String get viewAuthorProfile;

  /// No description provided for @authorEducation.
  ///
  /// In ru, this message translates to:
  /// **'Образование'**
  String get authorEducation;

  /// No description provided for @authorCareer.
  ///
  /// In ru, this message translates to:
  /// **'Трудовая деятельность'**
  String get authorCareer;

  /// No description provided for @authorCertificates.
  ///
  /// In ru, this message translates to:
  /// **'Сертификаты и языки'**
  String get authorCertificates;

  /// No description provided for @authorGeneralInfo.
  ///
  /// In ru, this message translates to:
  /// **'Общие сведения'**
  String get authorGeneralInfo;

  /// No description provided for @copyOrcid.
  ///
  /// In ru, this message translates to:
  /// **'Копировать ORCID'**
  String get copyOrcid;

  /// No description provided for @copiedToClipboard.
  ///
  /// In ru, this message translates to:
  /// **'Скопировано в буфер обмена'**
  String get copiedToClipboard;

  /// No description provided for @openOrcid.
  ///
  /// In ru, this message translates to:
  /// **'Открыть профиль ORCID'**
  String get openOrcid;

  /// No description provided for @authorMethodology.
  ///
  /// In ru, this message translates to:
  /// **'О научно-методическом пособии'**
  String get authorMethodology;

  /// No description provided for @resetProgress.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить прогресс'**
  String get resetProgress;

  /// No description provided for @progressResetSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс успешно сброшен'**
  String get progressResetSuccess;

  /// No description provided for @readMore.
  ///
  /// In ru, this message translates to:
  /// **'Читать далее'**
  String get readMore;

  /// No description provided for @showLess.
  ///
  /// In ru, this message translates to:
  /// **'Свернуть'**
  String get showLess;

  /// No description provided for @back.
  ///
  /// In ru, this message translates to:
  /// **'Назад'**
  String get back;

  /// No description provided for @next.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get next;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @share.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get share;

  /// No description provided for @exportPdf.
  ///
  /// In ru, this message translates to:
  /// **'Экспорт в PDF'**
  String get exportPdf;

  /// No description provided for @clear.
  ///
  /// In ru, this message translates to:
  /// **'Очистить'**
  String get clear;

  /// No description provided for @create.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get create;

  /// No description provided for @details.
  ///
  /// In ru, this message translates to:
  /// **'Подробнее'**
  String get details;

  /// No description provided for @completed.
  ///
  /// In ru, this message translates to:
  /// **'Выполнено'**
  String get completed;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить попытку'**
  String get retry;

  /// No description provided for @errorOccurred.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка при загрузке'**
  String get errorOccurred;

  /// No description provided for @markAsRead.
  ///
  /// In ru, this message translates to:
  /// **'Отметить как изученное'**
  String get markAsRead;

  /// No description provided for @alreadyRead.
  ///
  /// In ru, this message translates to:
  /// **'Раздел изучен'**
  String get alreadyRead;

  /// No description provided for @goalsTabKids.
  ///
  /// In ru, this message translates to:
  /// **'Задачи для детей'**
  String get goalsTabKids;

  /// No description provided for @goalsTabPedagogues.
  ///
  /// In ru, this message translates to:
  /// **'Для будущих педагогов'**
  String get goalsTabPedagogues;

  /// No description provided for @flipCardHint.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите на карточку, чтобы узнать подробнее'**
  String get flipCardHint;

  /// No description provided for @flipCardBackTitle.
  ///
  /// In ru, this message translates to:
  /// **'Что развивается:'**
  String get flipCardBackTitle;

  /// No description provided for @workSubTabTopics.
  ///
  /// In ru, this message translates to:
  /// **'Метеоды и темы'**
  String get workSubTabTopics;

  /// No description provided for @workSubTabStages.
  ///
  /// In ru, this message translates to:
  /// **'5 этапов'**
  String get workSubTabStages;

  /// No description provided for @workSubTabAlgorithm.
  ///
  /// In ru, this message translates to:
  /// **'Алгоритм'**
  String get workSubTabAlgorithm;

  /// No description provided for @workSubTabVirtualBoard.
  ///
  /// In ru, this message translates to:
  /// **'Интерактивный борд'**
  String get workSubTabVirtualBoard;

  /// No description provided for @workSubTabBuilder.
  ///
  /// In ru, this message translates to:
  /// **'Конструктор заданий'**
  String get workSubTabBuilder;

  /// No description provided for @safetyChecklistTitle.
  ///
  /// In ru, this message translates to:
  /// **'Чек-лист готовности и безопасности'**
  String get safetyChecklistTitle;

  /// No description provided for @safetyAllChecked.
  ///
  /// In ru, this message translates to:
  /// **'Все пункты соблюдены! Безопасная среда готова ✓'**
  String get safetyAllChecked;

  /// No description provided for @clearChecklist.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить отметки'**
  String get clearChecklist;

  /// No description provided for @myTasksTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мои сохранённые задания'**
  String get myTasksTitle;

  /// No description provided for @newTask.
  ///
  /// In ru, this message translates to:
  /// **'Создать новое задание'**
  String get newTask;

  /// No description provided for @deleteTask.
  ///
  /// In ru, this message translates to:
  /// **'Удалить задание'**
  String get deleteTask;

  /// No description provided for @taskSavedSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Задание успешно сохранено в локальную память'**
  String get taskSavedSuccess;

  /// No description provided for @stepProgress.
  ///
  /// In ru, this message translates to:
  /// **'Шаг {current} из {total}'**
  String stepProgress(Object current, Object total);

  /// No description provided for @ageGroup.
  ///
  /// In ru, this message translates to:
  /// **'Возрастная группа'**
  String get ageGroup;

  /// No description provided for @eduDirection.
  ///
  /// In ru, this message translates to:
  /// **'Образовательное направление'**
  String get eduDirection;

  /// No description provided for @taskGoal.
  ///
  /// In ru, this message translates to:
  /// **'Цель задания'**
  String get taskGoal;

  /// No description provided for @sibboardElement.
  ///
  /// In ru, this message translates to:
  /// **'Элемент Сибборда'**
  String get sibboardElement;

  /// No description provided for @taskContent.
  ///
  /// In ru, this message translates to:
  /// **'Содержание задания'**
  String get taskContent;

  /// No description provided for @childActions.
  ///
  /// In ru, this message translates to:
  /// **'Действия ребёнка'**
  String get childActions;

  /// No description provided for @pedagogueQuestions.
  ///
  /// In ru, this message translates to:
  /// **'Вопросы педагога'**
  String get pedagogueQuestions;

  /// No description provided for @expectedResult.
  ///
  /// In ru, this message translates to:
  /// **'Ожидаемый результат'**
  String get expectedResult;

  /// No description provided for @evaluationMethod.
  ///
  /// In ru, this message translates to:
  /// **'Способ оценки'**
  String get evaluationMethod;

  /// No description provided for @galleryTitle.
  ///
  /// In ru, this message translates to:
  /// **'Фотогалерея Сибборда'**
  String get galleryTitle;

  /// No description provided for @sampleTaskPrompt.
  ///
  /// In ru, this message translates to:
  /// **'Разработайте развивающее задание на основе Сибборда для детей 4–5 лет'**
  String get sampleTaskPrompt;

  /// No description provided for @quickActionsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Быстрый переход к разделам'**
  String get quickActionsTitle;

  /// No description provided for @model3dNav.
  ///
  /// In ru, this message translates to:
  /// **'3D Модель'**
  String get model3dNav;

  /// No description provided for @model3dTitle.
  ///
  /// In ru, this message translates to:
  /// **'3D Модель Сибборда'**
  String get model3dTitle;

  /// No description provided for @model3dSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Вращение 360°, масштабирование и текстура слоёв древесины'**
  String get model3dSubtitle;

  /// No description provided for @model3dLayersBtn.
  ///
  /// In ru, this message translates to:
  /// **'Текстура и срез слоёв'**
  String get model3dLayersBtn;

  /// No description provided for @model3dOverviewBtn.
  ///
  /// In ru, this message translates to:
  /// **'Общий 3D вид'**
  String get model3dOverviewBtn;

  /// No description provided for @model3dAutoRotate.
  ///
  /// In ru, this message translates to:
  /// **'Авто-вращение'**
  String get model3dAutoRotate;

  /// No description provided for @model3dReset.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить ракурс'**
  String get model3dReset;

  /// No description provided for @model3dHotspotRadius.
  ///
  /// In ru, this message translates to:
  /// **'Радиус изгиба: 120 см'**
  String get model3dHotspotRadius;

  /// No description provided for @model3dHotspotLayers.
  ///
  /// In ru, this message translates to:
  /// **'15 мм берёзовая фанера (11–15 слоёв)'**
  String get model3dHotspotLayers;

  /// No description provided for @model3dHotspotFelt.
  ///
  /// In ru, this message translates to:
  /// **'Шумопоглощающий фетровый слой'**
  String get model3dHotspotFelt;

  /// No description provided for @model3dHotspotWeight.
  ///
  /// In ru, this message translates to:
  /// **'Нагрузка до 150 кг'**
  String get model3dHotspotWeight;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
