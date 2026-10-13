# SIBBOARD EDU — Mobil ilova: to'liq loyiha rejasi (Antigravity uchun)

> Bu fayl loyiha ildizida turadi. Agent birinchi navbatda shu faylni to'liq o'qib, so'ng M1 dan boshlab bosqichma-bosqich bajaradi.

## 0. Ishga tushirish (Antigravity'ga birinchi prompt)

```
PLAN.md ni to'liq o'qi. docs/content_ru.md — ilovaning yagona kontent manbai,
assets/images/ — barcha rasmlar. PLAN.md dagi M1 dan M6 gacha bo'lgan bosqichlarni
ketma-ket bajar. Har bosqich oxirida "Qabul mezonlari" ni tekshir, flutter analyze
va flutter test xatosiz o'tsin, so'ng keyingi bosqichga o't. Kontent matnini
o'zgartirma, qisqartirma va o'zing to'qima — faqat docs/content_ru.md dan ol.
```

## 1. Loyiha xulosasi

| | |
|---|---|
| Nomi | **SIBBOARD EDU** |
| Maqsad | Bo'lajak maktabgacha ta'lim pedagoglarini Sibboard texnologiyasi bilan tanishtirish va ular uchun o'quv topshiriqlarini loyihalashni o'rgatish |
| Auditoriya | Pedagogika universiteti talabalari, tarbiyachilar |
| Platforma | Android (asosiy), iOS (kod tayyor bo'ladi) |
| Ishlash rejimi | **Offline-first**, backend yo'q, login yo'q |
| Tillar | Rus tili (asl kontent) + O'zbek (lotin). Til almashtirgich bor |

## 2. Texnologik qaror (o'zgartirilmaydi)

- **Flutter (stable) + Dart**, Material 3
- State: `flutter_riverpod`
- Navigatsiya: `go_router`
- Mahalliy saqlash: `shared_preferences` (sevimlilar, o'qilgan bo'limlar, til, tayyorlangan topshiriqlar JSON)
- Lokalizatsiya: `flutter_localizations` + `intl` (interfeys satrlari uchun ARB), kontent uchun JSON
- PDF/ulashish: `pdf`, `printing`, `share_plus`
- Shrift: **Nunito** (lotin + kirill), `assets/fonts/` ichiga yuklab qo'yiladi (offline ishlashi uchun `google_fonts` ishlatilmaydi)
- Rasmlar: loyihaga qo'shishdan oldin WebP ga o'tkaziladi (har biri ≤ 250 KB), `cached` yuklash kerak emas — hammasi assets'da
- Package id: `uz.sibboardedu.app`, min Android SDK 24

## 3. Muhim ogohlantirish (kontent va rasm mos emas)

`docs/content_ru.md` matni Sibbordni **elementli o'quv taxtasi** (tugma, molniya, qulf, shnurovka, g'ildirak, geometrik shakllar) sifatida tasvirlaydi. Lekin `assets/images/` dagi barcha 16 rasmda **egilgan yog'och balans-taxta** (bolalar va kattalar uning ustida turibdi, yotibdi, mashq qilmoqda) ko'rsatilgan.

**Qaror (buyurtmachi javob berguncha):** matn aynan hujjatdagidek qoladi; rasmlar *fotogalereya va bo'lim muqovalari* sifatida ishlatiladi; 5.4-bo'limdagi "Virtual Sibbord" elementlari esa vektor (CustomPainter) bilan chiziladi. Kontent va rasmlar JSON ichida alohida maydon bo'lgani uchun keyin almashtirish 1 daqiqalik ish.

## 4. Papka tuzilmasi

```
sibboard_edu/
├─ PLAN.md
├─ docs/
│  ├─ content_ru.md            # kontent manbai (o'zgartirilmaydi)
│  └─ source_sibboard.docx
├─ assets/
│  ├─ images/                  # 01..16 (WebP ga o'tkazilgan)
│  ├─ content/
│  │  ├─ ru/*.json             # content_ru.md dan ajratilgan
│  │  └─ uz/*.json             # ruscha JSON dan tarjima
│  └─ fonts/Nunito-*.ttf
├─ lib/
│  ├─ main.dart, app.dart, router.dart
│  ├─ core/ (theme, constants, widgets/, utils/)
│  ├─ data/ (models/, content_repository.dart, local_store.dart)
│  └─ features/
│     ├─ splash/ home/ about/ goals/ capabilities/
│     ├─ work/ (stages, algorithm, virtual_board, task_builder)
│     ├─ rules/ favorites/ search/ settings/
└─ l10n/app_ru.arb, app_uz.arb
```

## 5. Dizayn tizimi

**Kayfiyat:** iliq, bolalarbop, yog'och tekstura, yumaloq shakllar, toza oq joy. Rasmlardagi tabiiy yog'och rangi va "Siberia" logotipidagi qizil-to'q sariq urg'u rangidan olinadi.

| Token | Qiymat |
|---|---|
| `bg` | `#FBF7F2` |
| `surface` | `#FFFFFF` |
| `wood` (asosiy) | `#E8C9A0` |
| `woodDark` | `#B88A55` |
| `accent` | `#E2573A` |
| `teal` (ikkinchi urg'u) | `#3A8F85` |
| `text` | `#2B2623` |
| `textSoft` | `#6F655D` |
| `success` / `warning` | `#4C9A5F` / `#E5A53A` |

- Radius: kartalar 20, tugmalar 14, rasm 16. Soya yumshoq (blur 16, opacity 0.08).
- Shrift: sarlavha Nunito 800 (24–28), bo'lim 700 (18–20), matn 400 (16, line-height 1.5)
- Har bo'limning o'z rangi: Maqsad — teal, Imkoniyatlar — accent, Ish — wood, Qoidalar — success
- Dark mode: **kerak emas** (hajm cheklangan)
- Animatsiya: sahifa o'tishi (fade+slide 250ms), kartochka flip (300ms), `Hero` rasm o'tishlari. Boshqasi yo'q.
- Minimal teginish maydoni 48dp, matn kattalashtirishni qo'llab-quvvatlaydi (`textScaleFactor` 1.3 gacha buzilmasin)

## 6. Navigatsiya

Pastki `NavigationBar` (5 ta): **Bosh sahifa · Maqsad · Imkoniyatlar · Ish · Qoidalar**. Yuqori o'ng burchakda: qidiruv, sevimlilar, sozlamalar (til).

## 7. Ekranlar (har biri uchun kontent va rasm xaritasi)

Kontent manbai: `docs/content_ru.md` ichidagi tegishli bo'lim sarlavhasi.

### 7.1 Splash
Logo matni "SIBBOARD EDU" + `01_board_logo_front` kichik ko'rinishda, 1.2 s, keyin Home.

### 7.2 Bosh sahifa — «Что такое Сибборд?»
- Hero: `06_kids_home_play` (yuqori, to'liq kenglik, gradient ustida sarlavha)
- Asosiy ta'rif matni (bo'lim "BOSH SAHIFA") — qisqa qismi ko'rinadi, "Davomini o'qish" bilan ochiladi
- Galereya (gorizontal): `02`, `03`, `04`, `01`; bosilganda to'liq ekran, pinch-zoom
- Zanjir vizualizatsiyasi: «увидеть → потрогать → выполнить действие → исследовать → подумать → получить результат → осмыслить результат» — 7 ta doira-qadam, gorizontal scroll
- Quyidagi bo'limlar akkordeon (`ExpansionTile`) sifatida: *Педагогическая сущность*, *Образовательные возможности* (Когнитивное, Мелкая моторика, Зрительно-моторная координация, Сенсорное, Речевое, Творческое), *Самостоятельная деятельность*, *Мультисенсорный подход*, *Кинезиологический подход*
- Har akkordeonda: sarlavha, matn, mos rasm (`12`, `11`, `13`, `04`, `10`, `06`, `16`, `14` — tartib bo'yicha, JSON'da o'zgartiriladi)
- Pastda 4 ta tezkor kirish kartasi → boshqa bo'limlarga

### 7.3 Maqsad va vazifalar
- Muqova: `05_group_lesson_hall`
- Yuqorida "Цель технологии Сибборд" — alohida ajratilgan karta (teal fon)
- 2 ta tab: **Bolalar uchun vazifalar** (6 ta: познавательная, мелкая моторика, речь, творческое мышление, социально-коммуникативные, самостоятельность) va **Bo'lajak pedagoglar uchun** (10 ta band)
- Har vazifa — ikonka + sarlavha + ichma-ich ro'yxat (checkmark belgilari)
- "SIBBOARD EDU uchun maqsad" alohida blok

### 7.4 Pedagogik imkoniyatlar — 10 ta flip-karta
- 2 ustunli grid, 10 karta. Old tomon: raqam + nom + rasm; orqa tomon: "Что развивается" + qisqa izoh (hujjatdagi jadvaldan)
- Karta rasmlari: 1 Познавательная `12`; 2 Сенсомоторная `11`; 3 Сенсорное `04`; 4 Речевое `10`; 5 Творческая `06`; 6 Проблемное `13`; 7 Совместная `16`; 8 Самостоятельная `08`; 9 Индивидуализация `14`; 10 Профессиональная подготовка `05`
- Pastda "Ключевая идея раздела" bloki (iqtibos uslubida)
- Har kartada sevimlilarga qo'shish tugmasi

### 7.5 Sibboard bilan ishlash imkoniyatlari («Ish» tabi)
Ichki tab/segment bilan 4 qism:

**A. Mavzular (11 ta):** hujjatdagi 1–11 bo'limlar ro'yxat shaklida, har biri alohida detal ekran. Rasmlar: `07`, `09`, `15`, `12`, `13`, `14`, `16` ni mavzuga mos taqsimlash (JSON'da `image` maydoni).

**B. 5 bosqich (stepper):** Знакомство → Подражание → Самостоятельное выполнение → Проблемное задание → Творческая деятельность. Gorizontal progress, har bosqichga bosilganda tavsif. Pastda "Qoidalar"dagi ketma-ketlik bilan havola.

**C. Pedagog algoritmi:** 8 qadam vertikal timeline (Определение цели … Рефлексия), qadamlar ketma-ket animatsiya bilan ochiladi. Oxirida eslatma: "javob to'g'riligi emas, harakat usuli, mustaqillik, tashabbus, tushuntira olish".

**D. Virtual Sibbord (interaktiv):**
- Yog'och taxta shaklidagi ekran (`CustomPainter`), unda 5 ta bosiladigan element: 🔘 Tugma, 🔐 Qulf, 🔺 Geometrik shakl, 🔄 G'ildirak, 🧵 Shnurovka (emoji emas, vektor ikonka chiziladi)
- Elementga bosilsa — bottom sheet: **nima rivojlanadi** (2 qator) + **topshiriq** + "Topshiriq yaratish" tugmasi (E ga olib boradi, element oldindan tanlangan)
- Hujjatdagi mapping: Пуговица → точность движений / самостоятельное действие; Замок → проблемная ситуация / поиск решения; Геометрическая фигура → сенсорное и математическое развитие / классификация и сравнение; Колёсико → двигательная активность / координация; Шнуровка → мелкая моторика / последовательность действий
- Elementlar bosilganda yengil tebranish (haptic) va "bosilgan" animatsiyasi

**E. Topshiriq konstruktori (9 qadamli wizard):**
`Yosh guruhi → Ta'lim yo'nalishi → Maqsad → Sibbord elementi → Topshiriq mazmuni → Bola harakatlari → Pedagog savollari → Kutilgan natija → Baholash usuli`
- Yosh guruhi: 3–4, 4–5, 5–6, 6–7 (chip)
- Ta'lim yo'nalishi (7 ta, hujjatdan): nutq, elementar matematik tasavvurlar, tabiat bilan tanishtirish, badiiy-ijodiy, konstruktiv, teatrlashtirilgan, o'yin faoliyati
- Element: 5 ta (D bo'limidan)
- Qolgan qadamlar — matn kiritish, har birida hujjatdagi namuna ("Продень шнурок через отверстия по порядку" va h.k.) `hint` sifatida
- Natija: xulosa kartasi → **mahalliy saqlash** ("Mening topshiriqlarim" ro'yxati) → **PDF eksport / ulashish**
- Birinchi qadamda hujjatdagi namuna topshiriq: "Разработайте развивающее задание на основе Сибборда для детей 4–5 лет"

### 7.6 Foydalanish qoidalari
- Muqova: `09_lunge_pose` yoki `08_tree_pose`
- 6 bo'lim akkordeon: Asosiy qoidalar (8 band), Xavfsizlik qoidalari (9 band), Pedagogik hamrohlik, Guruh ishi qoidalari, Samarali foydalanish, Pedagog roli
- **Xavfsizlik chek-listi:** 9 band — har biri checkbox, holati saqlanadi, "Hammasini tozalash" tugmasi. Hammasi belgilansa "Tayyor ✓" animatsiyasi
- "4 savol" bloki: Что развиваем? → Что должен сделать ребёнок? → Какой элемент используем? → Как определим результат? (4 ta rangli qadam-karta) + hujjatdagi misol (шнуровка)
- Banner: «Не сделать за ребёнка, а помочь ему сделать самостоятельно»

### 7.7 Qo'shimcha ekranlar
- **Qidiruv:** barcha JSON kontent ichidan (sarlavha + matn), natijada bo'lim nomi ko'rsatiladi, bosilganda shu joyga o'tadi
- **Sevimlilar:** kartalar, mavzular va qoidalar saqlanadi
- **Sozlamalar:** til (RU/UZ), matn o'lchami (3 daraja), ilova haqida (versiya, muallif: F.K. No'monjonova rasmiy profili to'liq integratsiya qilingan)
- **Muallif sahifasi (/author):** F.K. No'monjonova — rasm, lavozim, universitet, mutaxassislik (13.00.01), ORCID, ta'lim, mehnat faoliyati va sertifikatlar
- **O'qish progressi:** o'qilgan bo'limlar bosh sahifada halqa-diagramma bilan (%), `shared_preferences`

## 8. Ma'lumotlar modeli

```dart
class Section { String id; String title; String? subtitle; String? image; List<Block> blocks; }
sealed class Block {}
class ParagraphBlock extends Block { String text; }
class BulletsBlock extends Block { List<String> items; }
class QuoteBlock extends Block { String text; }
class StepsBlock extends Block { List<StepItem> steps; }   // title + description
class CardItem { int no; String title; String develops; String? image; String? back; }
class BoardElement { String id; String name; String develops; String task; }
class UserTask { String id; DateTime created; Map<String,String> fields; }
```

JSON fayl qoidasi: `assets/content/{lang}/{section}.json`; barcha `id` ikkala tilda bir xil; `image` maydoni `assets/images/..` yo'lini beradi.

## 9. Kontent va tarjima qoidalari

1. Ruscha JSON'lar `docs/content_ru.md` dan **so'zma-so'z** ko'chiriladi (tahrirlanmaydi, qisqartirilmaydi).
2. O'zbekcha JSON — ruscha JSON'ning tarjimasi (lotin yozuvi, pedagogik atamalar: "сибборд" → "Sibbord", "воспитатель" → "tarbiyachi", "рефлексия" → "refleksiya"). Tarjima `// REVIEW` bayrog'i bilan belgilanadi — buyurtmachi/Diyorbek tekshiradi.
3. Interfeys satrlari (tugma, sarlavha, xato) — `l10n/*.arb`.
4. Hujjat matnidagi tibbiy-ilmiy ehtiyotkorlik jumlalari ("avtomatik rivojlantiradi deb da'vo qilmaslik") **saqlanadi**.

## 10. Rasm xaritasi (qisqa)

| Fayl | Mazmun | Qayerda |
|---|---|---|
| 01 | Logotipli taxta (old) | Splash, galereya |
| 02, 03 | Taxta yon ko'rinishi | Galereya |
| 04 | Probka taxta | Sensor, galereya |
| 05 | Zalda guruh mashg'uloti | Maqsad muqovasi, Kasbiy tayyorgarlik |
| 06 | Uyda bolalar o'yini | Bosh sahifa hero |
| 07 | Juftlikda balans | Mavzular |
| 08 | "Daraxt" poza | Mustaqil faoliyat, Qoidalar |
| 09 | Kattalar mashqi | Qoidalar, mavzular |
| 10 | Juftlikda mashq | Nutq/ijtimoiy |
| 11 | Bola taxta ustida | Sensomotor |
| 12, 13 | O'g'il bola, tayoqchalar | Kognitiv, Muammoli |
| 14, 15 | Yotgan juftlik | Individuallashtirish |
| 16 | Zalda guruh | Birgalikdagi faoliyat |

Har rasmga `semanticsLabel` (alt matn) yoziladi.

## 11. Bosqichlar va qabul mezonlari

**M1 — Skelet (poydevor)**
Flutter loyiha, paketlar, tema (5-bo'lim), router + pastki navigatsiya, til almashtirgich (RU/UZ), bo'sh ekranlar.
✓ Ilova ishga tushadi, 5 tab o'tadi, til o'zgaradi va saqlanadi.

**M2 — Kontent qatlami**
`content_ru.md` → ruscha JSON; uzbekcha JSON; `ContentRepository`; modellar; rasmlar WebP ga o'tkazilgan.
✓ Barcha bo'limlar kodda o'qiladi, unit test: har JSON parse bo'ladi, ru/uz `id` lari mos.

**M3 — Bosh sahifa, Maqsad, Pedagogik imkoniyatlar**
7.2, 7.3, 7.4 ekranlari, galereya, flip-kartalar.
✓ 10 karta flip bo'ladi, galereya zoom qiladi, matnlar hujjat bilan mos.

**M4 — Ish bo'limi**
7.5 A–E: mavzular, bosqichlar, algoritm, Virtual Sibbord, konstruktor + PDF.
✓ 5 elementning har biri bottom sheet ochadi; konstruktor 9 qadamni o'tadi, saqlaydi, PDF yaratadi (kirill va lotin to'g'ri chiqadi).

**M5 — Qoidalar va qo'shimcha**
7.6, qidiruv, sevimlilar, progress, sozlamalar.
✓ Chek-list holati ilovani qayta ochganda saqlanadi; qidiruv ruscha va o'zbekcha ishlaydi.

**M6 — Sayqal va chiqarish**
Ikonka va splash (`flutter_launcher_icons`, `flutter_native_splash`), kichik ekranlarda (360×640) overflow yo'q, `textScale 1.3` da buzilmaydi, release APK/AAB, ProGuard/R8 tekshiruvi.
✓ `flutter build apk --release` xatosiz; APK ≤ 40 MB; 3 xil qurilma o'lchamida skrinshotlar.

## 12. Sifat qoidalari (agent uchun)

- Har bosqichdan so'ng `flutter analyze` — 0 ogohlantirish, `flutter test` — yashil
- Hard-coded matn yo'q: interfeys → ARB, kontent → JSON
- Har ekran bo'sh/yuklanish/xato holatiga ega; rasm yo'q bo'lsa `errorBuilder`
- Katta `build()` metodlari kichik vidjetlarga bo'linadi; `const` konstruktorlar ishlatiladi
- Tashqi API, reklama, analitika, ruxsatnomalar (kamera, joylashuv) **qo'shilmaydi** — faqat internetsiz ishlaydi
- Bolalar auditoriyasi bilan ishlash materiali bo'lgani uchun foydalanuvchi ma'lumoti yig'ilmaydi

## 13. Ochiq savollar (buyurtmachidan so'rash)

1. **Rasm va matn mosligi** (3-bo'lim): Sibbord = taxtadagi elementlarmi yoki balans-taxtami? Rasmlar bo'yicha balans-taxta ko'rinadi.
2. Yosh guruhlari 3–7 yosh bo'lishi mumkinmi (hujjatda faqat 4–5 yosh misol sifatida bor)?
3. Asosiy til rus tilimi yoki o'zbek tilimi? Tarjimani kim tekshiradi?
4. **Muallif va universitet ma'lumotlari:** [HAL QILINDI ✓] F.K. No'monjonova ma'lumotlari, fotosurati, ilmiy ixtisosligi, ta'limi va sertifikatlari `/author` ekrani va Sozlamalar/Bosh sahifada to'liq joylashtirildi.
5. Google Play'ga chiqarish kerakmi (bo'lsa, developer akkaunt kimda bo'ladi)?

## 14. Hajmdan tashqari (keyingi versiya, alohida narx)

Test/viktorina moduli, videodarslar, foydalanuvchi akkaunti va bulutli sinxronlash, admin panel, push-bildirishnomalar, iOS App Store'ga chiqarish.
