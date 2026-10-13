// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'SIBBOARD EDU';

  @override
  String get homeNav => 'Главная';

  @override
  String get goalsNav => 'Цели';

  @override
  String get capabilitiesNav => 'Возможности';

  @override
  String get workNav => 'Практика';

  @override
  String get rulesNav => 'Правила';

  @override
  String get search => 'Поиск';

  @override
  String get favorites => 'Избранное';

  @override
  String get settings => 'Настройки';

  @override
  String get searchHint => 'Поиск по разделам, темам и понятиям...';

  @override
  String get noSearchResults => 'Ничего не найдено';

  @override
  String get searchResults => 'Результаты поиска';

  @override
  String get emptyFavorites => 'В избранном пока ничего нет';

  @override
  String get emptyFavoritesSubtitle =>
      'Сохраняйте карточки возможностей, темы и правила для быстрого доступа';

  @override
  String get clearFavorites => 'Очистить все';

  @override
  String get language => 'Язык интерфейса';

  @override
  String get russian => 'Русский';

  @override
  String get uzbek => 'O\'zbekcha';

  @override
  String get fontSize => 'Размер шрифта';

  @override
  String get fontStandard => 'Стандартный';

  @override
  String get fontMedium => 'Средний';

  @override
  String get fontLarge => 'Крупный';

  @override
  String get readingProgress => 'Прогресс изучения материалов';

  @override
  String get aboutApp => 'О приложении';

  @override
  String get appVersion => 'Версия';

  @override
  String get projectAuthor => 'Автор методических материалов';

  @override
  String get authorPlaceholder =>
      'Нумонжонова Фарангиз Комилжон кизи (Университет экономики и педагогики, г. Карши)';

  @override
  String get authorFullName => 'Нумонжонова Фарангиз Комилжон кизи';

  @override
  String get authorPosition =>
      'Ассистент-преподаватель кафедры «Дошкольного образования»';

  @override
  String get authorWorkplace => 'Университет экономики и педагогики (г. Карши)';

  @override
  String get authorSpecialty =>
      '13.00.01 — Теория педагогики. История педагогических учений';

  @override
  String get aboutAuthor => 'Сведения об авторе';

  @override
  String get viewAuthorProfile => 'Подробнее об авторе';

  @override
  String get authorEducation => 'Образование';

  @override
  String get authorCareer => 'Трудовая деятельность';

  @override
  String get authorCertificates => 'Сертификаты и языки';

  @override
  String get authorGeneralInfo => 'Общие сведения';

  @override
  String get copyOrcid => 'Копировать ORCID';

  @override
  String get copiedToClipboard => 'Скопировано в буфер обмена';

  @override
  String get openOrcid => 'Открыть профиль ORCID';

  @override
  String get authorMethodology => 'О научно-методическом пособии';

  @override
  String get resetProgress => 'Сбросить прогресс';

  @override
  String get progressResetSuccess => 'Прогресс успешно сброшен';

  @override
  String get readMore => 'Читать далее';

  @override
  String get showLess => 'Свернуть';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далее';

  @override
  String get save => 'Сохранить';

  @override
  String get share => 'Поделиться';

  @override
  String get exportPdf => 'Экспорт в PDF';

  @override
  String get clear => 'Очистить';

  @override
  String get create => 'Создать';

  @override
  String get details => 'Подробнее';

  @override
  String get completed => 'Выполнено';

  @override
  String get retry => 'Повторить попытку';

  @override
  String get errorOccurred => 'Произошла ошибка при загрузке';

  @override
  String get markAsRead => 'Отметить как изученное';

  @override
  String get alreadyRead => 'Раздел изучен';

  @override
  String get goalsTabKids => 'Задачи для детей';

  @override
  String get goalsTabPedagogues => 'Для будущих педагогов';

  @override
  String get flipCardHint => 'Нажмите на карточку, чтобы узнать подробнее';

  @override
  String get flipCardBackTitle => 'Что развивается:';

  @override
  String get workSubTabTopics => 'Метеоды и темы';

  @override
  String get workSubTabStages => '5 этапов';

  @override
  String get workSubTabAlgorithm => 'Алгоритм';

  @override
  String get workSubTabVirtualBoard => 'Интерактивный борд';

  @override
  String get workSubTabBuilder => 'Конструктор заданий';

  @override
  String get safetyChecklistTitle => 'Чек-лист готовности и безопасности';

  @override
  String get safetyAllChecked =>
      'Все пункты соблюдены! Безопасная среда готова ✓';

  @override
  String get clearChecklist => 'Сбросить отметки';

  @override
  String get myTasksTitle => 'Мои сохранённые задания';

  @override
  String get newTask => 'Создать новое задание';

  @override
  String get deleteTask => 'Удалить задание';

  @override
  String get taskSavedSuccess => 'Задание успешно сохранено в локальную память';

  @override
  String stepProgress(Object current, Object total) {
    return 'Шаг $current из $total';
  }

  @override
  String get ageGroup => 'Возрастная группа';

  @override
  String get eduDirection => 'Образовательное направление';

  @override
  String get taskGoal => 'Цель задания';

  @override
  String get sibboardElement => 'Элемент Сибборда';

  @override
  String get taskContent => 'Содержание задания';

  @override
  String get childActions => 'Действия ребёнка';

  @override
  String get pedagogueQuestions => 'Вопросы педагога';

  @override
  String get expectedResult => 'Ожидаемый результат';

  @override
  String get evaluationMethod => 'Способ оценки';

  @override
  String get galleryTitle => 'Фотогалерея Сибборда';

  @override
  String get sampleTaskPrompt =>
      'Разработайте развивающее задание на основе Сибборда для детей 4–5 лет';

  @override
  String get quickActionsTitle => 'Быстрый переход к разделам';

  @override
  String get model3dNav => '3D Модель';

  @override
  String get model3dTitle => '3D Модель Сибборда';

  @override
  String get model3dSubtitle =>
      'Вращение 360°, масштабирование и текстура слоёв древесины';

  @override
  String get model3dLayersBtn => 'Текстура и срез слоёв';

  @override
  String get model3dOverviewBtn => 'Общий 3D вид';

  @override
  String get model3dAutoRotate => 'Авто-вращение';

  @override
  String get model3dReset => 'Сбросить ракурс';

  @override
  String get model3dHotspotRadius => 'Радиус изгиба: 120 см';

  @override
  String get model3dHotspotLayers => '15 мм берёзовая фанера (11–15 слоёв)';

  @override
  String get model3dHotspotFelt => 'Шумопоглощающий фетровый слой';

  @override
  String get model3dHotspotWeight => 'Нагрузка до 150 кг';
}
