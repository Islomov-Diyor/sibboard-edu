# -*- coding: utf-8 -*-
import json
import os

os.makedirs('assets/content/ru', exist_ok=True)
os.makedirs('assets/content/uz', exist_ok=True)

# ----------------- HOME (RU) -----------------
home_ru = {
    "id": "home",
    "title": "Что такое Сибборд?",
    "subtitle": "Интерактивное развивающее средство для дошкольного образования",
    "hero_image": "assets/images/06_kids_home_play.webp",
    "definition": "Сибборд (Sibboard) — это интерактивное развивающее средство, предназначенное для организации активной познавательной, двигательной, сенсорной, речевой и творческой деятельности ребёнка. Его основу составляет специально организованная игровая или развивающая поверхность, на которой размещаются различные функциональные, бытовые, сенсорные и дидактические элементы. В процессе взаимодействия с ними ребёнок не только выполняет определённые действия, но и получает возможность самостоятельно исследовать свойства предметов, устанавливать простые причинно-следственные связи, решать практические задачи и приобретать опыт самостоятельной деятельности.",
    "materials_info": "Сибборд может изготавливаться из дерева или других безопасных материалов. На его поверхности могут размещаться пуговицы, застёжки, молнии, крючки, шнуровки, безопасные замки, колёсики, переключатели, магниты, геометрические фигуры, цветные элементы, цифры, буквы, тактильные поверхности и другие дидактические компоненты.\n\nКонкретный состав Сибборда определяется возрастом детей, целями образовательной деятельности, содержанием занятия и индивидуальными возможностями воспитанников.",
    "gallery_images": [
        "assets/images/02_board_side_view_1.webp",
        "assets/images/03_board_side_view_2.webp",
        "assets/images/04_cork_board.webp",
        "assets/images/01_board_logo_front.webp"
    ],
    "chain_steps": [
        {"step": 1, "title": "Увидеть", "desc": "Зрительное восприятие объекта"},
        {"step": 2, "title": "Потрогать", "desc": "Тактильное знакомство с материалом"},
        {"step": 3, "title": "Выполнить действие", "desc": "Практическое взаимодействие с элементом"},
        {"step": 4, "title": "Исследовать", "desc": "Изучение свойств и реакций предмета"},
        {"step": 5, "title": "Подумать", "desc": "Осмысление причинно-следственной связи"},
        {"step": 6, "title": "Получить результат", "desc": "Достижение цели практического действия"},
        {"step": 7, "title": "Осмыслить результат", "desc": "Рефлексия и словесное объяснение"}
    ],
    "accordions": [
        {
            "id": "pedagogical_essence",
            "title": "Педагогическая сущность технологии Сибборда",
            "image": "assets/images/12_boy_sticks.webp",
            "content": "С педагогической точки зрения Сибборд следует рассматривать не только как игровую конструкцию или набор предметов, но и как средство организации целенаправленной развивающей деятельности.\n\nПри традиционном предъявлении учебного материала ребёнок может воспринимать информацию преимущественно посредством наблюдения и слушания. При работе с Сиббордом к этим процессам добавляется непосредственное действие с предметами. Ребёнок может нажать, повернуть, открыть, закрыть, соединить, расстегнуть, застегнуть, протянуть, подобрать, расположить или переместить определённый элемент.\n\nНапример, при выполнении задания «Открой и закрой» ребёнок работает с замком или застёжкой. При этом педагог может задавать вопросы:\n• Что ты сейчас делаешь?\n• Для чего нужен этот элемент?\n• Что произойдёт, если повернуть ключ?\n• Открывается ли замок в другую сторону?\n• Как ты понял, что задание выполнено правильно?\n\nТаким образом, одно простое практическое действие может быть преобразовано педагогом в комплексное развивающее задание, включающее двигательную, познавательную и речевую активность.\n\nПоэтому педагогическая ценность Сибборда определяется не только наличием развивающих элементов, но и способом их методически грамотного использования."
        },
        {
            "id": "cognitive_dev",
            "title": "Когнитивное развитие",
            "image": "assets/images/11_child_on_board.webp",
            "content": "Работа с Сиббордом может создавать условия для развития внимания, наблюдательности, памяти, сравнения, классификации, анализа, установления простых причинно-следственных связей, решения практических задач и элементарного логического мышления.\n\nНапример, педагог может предложить ребёнку найти элемент определённого цвета, формы или размера, определить его расположение или подобрать соответствующую деталь.\n\nВажно отметить, что сам по себе Сибборд не гарантирует развитие определённой когнитивной способности. Результат зависит от содержания задания, его сложности, возраста ребёнка и характера педагогического сопровождения."
        },
        {
            "id": "fine_motor_dev",
            "title": "Развитие мелкой моторики",
            "image": "assets/images/13_problem_solving.webp",
            "content": "Многие действия с элементами Сибборда требуют точных движений пальцев и кисти.\n\nНапример:\nзастегнуть пуговицу → открыть молнию → завязать шнурок → открыть замок → повернуть элемент → соединить детали.\n\nТакие действия создают условия для тренировки координации движений кисти и пальцев.\n\nОсобое значение имеет постепенное усложнение заданий: от простых манипуляций с крупными элементами к более точным действиям."
        },
        {
            "id": "visual_motor_coordination",
            "title": "Развитие зрительно-моторной координации",
            "image": "assets/images/04_cork_board.webp",
            "content": "При работе с Сиббордом ребёнку необходимо одновременно:\n• увидеть необходимый объект;\n• определить его положение;\n• направить к нему руку;\n• выполнить требуемое действие;\n• оценить полученный результат.\n\nТаким образом, педагог может включать задания, направленные на согласование зрительного восприятия и двигательного действия."
        },
        {
            "id": "sensory_dev",
            "title": "Сенсорное развитие",
            "image": "assets/images/10_pair_exercise.webp",
            "content": "Сибборд позволяет создавать ситуации, в которых ребёнок получает непосредственный сенсорный опыт. Ребёнок может видеть различные цвета, различать формы, ощущать различные фактуры, сравнивать размеры, определять расположение предметов и взаимодействовать с различными по характеру поверхностями.\n\nНа этой основе педагог может формировать задания типа: «Найди такой же», «Что отличается?», «Подбери по цвету», «Найди большую фигуру», «Определи на ощупь»."
        },
        {
            "id": "speech_dev",
            "title": "Сибборд и речевое развитие",
            "image": "assets/images/06_kids_home_play.webp",
            "content": "Сибборд может использоваться как средство организации речевой деятельности. Во время выполнения практического задания педагог может побуждать ребёнка: называть предметы, описывать их свойства, обозначать действия, отвечать на вопросы, составлять простые предложения, объяснять последовательность действий, рассказывать о полученном результате.\n\nНапример, педагог показывает молнию и спрашивает: «Что это?» — «Для чего она нужна?» — «Что ты сейчас делаешь?» — «Что произошло после того, как ты её закрыл?»\n\nПрактическое действие становится основой для ситуативного речевого общения."
        },
        {
            "id": "creative_dev",
            "title": "Сибборд и творческое развитие",
            "image": "assets/images/16_group_hall.webp",
            "content": "Сибборд может использоваться не только для выполнения заранее заданных действий, но и для создания ребёнком собственных игровых ситуаций. Педагог может предложить: «Придумай игру с этими элементами» или «Создай историю, используя изображения на Сибборде».\n\nВ результате ребёнок получает возможность самостоятельно выбирать элементы, комбинировать их и создавать собственные варианты деятельности. Это создаёт условия для проявления воображения, инициативности, самостоятельности, гибкости мышления и творческого поиска."
        },
        {
            "id": "independent_activity",
            "title": "Сибборд и самостоятельная деятельность",
            "image": "assets/images/08_tree_pose.webp",
            "content": "Одним из педагогически значимых аспектов Сибборда является возможность организации самостоятельной деятельности ребёнка. Ребёнок может самостоятельно выбрать элемент, определить последовательность действий, попробовать различные способы выполнения задания и проверить результат.\n\nПри возникновении затруднения педагог не обязательно сразу сообщает правильный ответ. Он может использовать наводящие вопросы: «Попробуй ещё раз», «Как ты думаешь, почему не получилось?», «Какой элемент подходит сюда?», «Что можно изменить?»\n\nТакой подход способствует формированию опыта поиска решения, а не только воспроизведения готового образца."
        },
        {
            "id": "multisensory_approach",
            "title": "Сибборд и мультисенсорный подход",
            "image": "assets/images/14_individual_lying.webp",
            "content": "Особое значение имеет возможность объединения нескольких каналов восприятия. В процессе работы ребёнок: видит → прикасается → двигает → слышит → наблюдает результат → обсуждает его.\n\nНапример, ребёнок видит красную геометрическую фигуру, берёт её рукой, определяет форму, перемещает в соответствующее место и называет её. Таким образом, в одном задании могут сочетаться зрительное восприятие, тактильный опыт, двигательная активность и речевое сопровождение."
        },
        {
            "id": "kinesiological_approach",
            "title": "Сибборд и кинезиологический подход",
            "image": "assets/images/15_pair_lying.webp",
            "content": "Работа с Сиббордом включает различные движения кистей и пальцев, зрительно-моторную координацию и управление двигательными действиями. Поэтому его использование может быть методически связано с подходами, рассматривающими взаимосвязь двигательной и познавательной активности.\n\nПри этом научно корректно не утверждать, что любое использование Сибборда автоматически обеспечивает развитие высших психических функций или интеллекта. Педагогический эффект определяется содержанием задания, его целью, возрастной адекватностью, систематичностью применения и профессиональными действиями педагога.\n\nПоэтому в образовательном процессе важно сочетать Сибборд с беседой, вопросами, игровыми методами, проблемными заданиями, двигательными упражнениями, творческими заданиями, рефлексией и другими средствами обучения."
        }
    ]
}

# ----------------- HOME (UZ) -----------------
home_uz = {
    "id": "home",
    "title": "Sibbord o'zi nima?",
    "subtitle": "Maktabgacha ta'lim uchun interaktiv rivojlantiruvchi vosita",
    "hero_image": "assets/images/06_kids_home_play.webp",
    "definition": "Sibbord (Sibboard) — bu bolaning faol bilish, harakat, sensor, nutq va ijodiy faoliyatini tashkil etish uchun mo'ljallangan interaktiv rivojlantiruvchi vositadir. Uning asosini maxsus tashkil etilgan o'yin yoki rivojlantiruvchi sirt tashkil etadi, unda turli funksional, maishiy, sensor va didaktik elementlar joylashtiriladi. Ular bilan o'zaro ta'sir jarayonida bola nafaqat muayyan harakatlarni bajaradi, balki buyumlarning xususiyatlarini mustaqil ravishda o'rganish, oddiy sabab-oqibat bog'lanishlarini o'rnatish, amaliy vazifalarni hal qilish va mustaqil faoliyat tajribasini orttirish imkoniyatiga ega bo'ladi.",
    "materials_info": "Sibbord yog'ochdan yoki boshqa xavfsiz materiallardan tayyorlanishi mumkin. Uning yuzasida tugmalar, qisqichlar, molniyalar, ilgaklar, bog'ichlar (shnurovka), xavfsiz qulflar, g'ildirakchalar, ulagichlar, magnitlar, geometrik shakllar, rangli elementlar, raqamlar, harflar, taktil yuzalar va boshqa didaktik komponentlar joylashtirilishi mumkin.\n\nSibbordning aniq tarkibi bolalarning yoshi, ta'lim faoliyati maqsadlari, mashg'ulot mazmuni va tarbiyalanuvchilarning individual imkoniyatlari bilan belgilanadi.",
    "gallery_images": [
        "assets/images/02_board_side_view_1.webp",
        "assets/images/03_board_side_view_2.webp",
        "assets/images/04_cork_board.webp",
        "assets/images/01_board_logo_front.webp"
    ],
    "chain_steps": [
        {"step": 1, "title": "Ko'rish", "desc": "Obyektni vizual idrok etish"},
        {"step": 2, "title": "Ushlab ko'rish", "desc": "Material bilan taktil tanishuv"},
        {"step": 3, "title": "Harakat qilish", "desc": "Element bilan amaliy o'zaro munosabat"},
        {"step": 4, "title": "Tadqiq etish", "desc": "Predmet xususiyatlari va reaksiyalarini o'rganish"},
        {"step": 5, "title": "O'ylash", "desc": "Sabab-oqibat bog'lanishini anglash"},
        {"step": 6, "title": "Natija olish", "desc": "Amaliy harakat maqsadiga erishish"},
        {"step": 7, "title": "Natijani tushunish", "desc": "Refleksiya va og'zaki izohlash"}
    ],
    "accordions": [
        {
            "id": "pedagogical_essence",
            "title": "Sibbord texnologiyasining pedagogik mohiyati",
            "image": "assets/images/12_boy_sticks.webp",
            "content": "Pedagogik nuqtai nazardan Sibbordni faqat o'yin konstruksiyasi yoki buyumlar to'plami sifatida emas, balki maqsadli rivojlantiruvchi faoliyatni tashkil etish vositasi sifatida ko'rib chiqish lozim.\n\nO'quv materialini an'anaviy taqdim etishda bola ma'lumotni asosan kuzatish va tinglash orqali idrok etishi mumkin. Sibbord bilan ishlashda bu jarayonlarga buyumlar bilan bevosita harakat qo'shiladi. Bola ma'lum bir elementni bosishi, burashi, ochishi, yopishi, ulashi, yechishi, qadashi, tortishi, moslashtirishi, joylashtirishi yoki siljitishi mumkin.\n\nMasalan, «Och va yop» topshirig'ini bajarishda bola qulf yoki mahkamlagich bilan ishlaydi. Bunda tarbiyachi quyidagi savollarni berishi mumkin:\n• Hozir nima qilyapsan?\n• Bu element nima uchun kerak?\n• Kalit buralsa nima bo'ladi?\n• Qulf boshqa tomonga ochiladimi?\n• Topshiriq to'g'ri bajarilganini qayerdan bilding?\n\nShunday qilib, bitta oddiy amaliy harakat pedagog tomonidan harakat, bilish va nutq faolligini o'z ichiga olgan kompleks rivojlantiruvchi topshiriqqa aylantirilishi mumkin.\n\nShu sababli Sibbordning pedagogik qiymati nafaqat rivojlantiruvchi elementlarning mavjudligi bilan, balki ulardan metodik jihatdan to'g'ri foydalanish usuli bilan belgilanadi."
        },
        {
            "id": "cognitive_dev",
            "title": "Kognitiv (bilish) rivojlanish",
            "image": "assets/images/11_child_on_board.webp",
            "content": "Sibbord bilan ishlash diqqat, kuzatuvchanlik, xotira, taqqoslash, tasniflash, tahlil qilish, oddiy sabab-oqibat bog'lanishlarini o'rnatish, amaliy masalalarni yechish va boshlang'ich mantiqiy fikrlashni rivojlantirish uchun shart-sharoit yaratishi mumkin.\n\nMasalan, pedagog bolaga ma'lum bir rang, shakl yoki o'lchamdagi elementni topishni, uning joylashuvini aniqlashni yoki mos detalni tanlashni taklif qilishi mumkin.\n\nShuni ta'kidlash kerakki, Sibbordning o'zi avtomatik ravishda ma'lum bir kognitiv qobiliyat rivojlanishini kafolatlamaydi. Natija topshiriq mazmuni, uning murakkabligi, bolaning yoshi va pedagogik hamrohlik xarakteriga bog'liq."
        },
        {
            "id": "fine_motor_dev",
            "title": "Mayda motorikani rivojlantirish",
            "image": "assets/images/13_problem_solving.webp",
            "content": "Sibbord elementlari bilan ko'plab harakatlar barmoqlar va kaftning aniq harakatlarini talab qiladi.\n\nMasalan:\ntugmani qadash → molniyani ochish → bog'ichni bog'lash → qulfni ochish → elementni burash → detallarni birlashtirish.\n\nBunday harakatlar barmoqlar va kaft harakatlari koordinatsiyasini mashq qildirish uchun sharoit yaratadi.\n\nTopshiriqlarni bosqichma-bosqich murakkablashtirish alohida ahamiyatga ega: yirik elementlar bilan oddiy manipulyatsiyalardan aniqroq harakatlarga o'tish."
        },
        {
            "id": "visual_motor_coordination",
            "title": "Ko'rish-harakat koordinatsiyasini rivojlantirish",
            "image": "assets/images/04_cork_board.webp",
            "content": "Sibbord bilan ishlashda bola bir vaqtning o'zida quyidagilarni bajarishi kerak:\n• kerakli obyektni ko'rish;\n• uning holatini aniqlash;\n• unga qarab qo'lini yo'naltirish;\n• talab qilingan harakatni bajarish;\n• olingan natijani baholash.\n\nShunday qilib, pedagog ko'rish idroki va harakat amalini muvofiqlashtirishga qaratilgan topshiriqlarni kiritishi mumkin."
        },
        {
            "id": "sensory_dev",
            "title": "Sensor rivojlanish",
            "image": "assets/images/10_pair_exercise.webp",
            "content": "Sibbord bolaning bevosita sensor tajriba olishiga imkon beradigan vaziyatlarni yaratadi. Bola turli ranglarni ko'rishi, shakllarni ajratishi, turli teksturalarni his qilishi, o'lchamlarni solishtirishi, buyumlarning joylashuvini aniqlashi va turli sirtlar bilan o'zaro munosabatda bo'lishi mumkin.\n\nShu asosda pedagog quyidagi turdagi topshiriqlarni shakllantirishi mumkin: «Xuddi shundayini top», «Nima bilan farq qiladi?», «Rangiga qarab tanla», «Katta shaklni top», «Paypaslab aniqla»."
        },
        {
            "id": "speech_dev",
            "title": "Sibbord va nutqiy rivojlanish",
            "image": "assets/images/06_kids_home_play.webp",
            "content": "Sibbord nutq faoliyatini tashkil etish vositasi sifatida ishlatilishi mumkin. Amaliy topshiriqni bajarish paytida pedagog bolani quyidagilarga undashi mumkin: buyumlarni nomlash, ularning xususiyatlarini tasvirlash, harakatlarni ifodalash, savollarga javob berish, oddiy jumlalar tuzish, harakatlar ketma-ketligini tushuntirish, olingan natija haqida so'zlab berish.\n\nMasalan, pedagog molniyani ko'rsatib so'raydi: «Bu nima?» — «U nima uchun kerak?» — «Hozir nima qilyapsan?» — «Uni yopganingdan keyin nima bo'ldi?»\n\nAmaliy harakat vaziyatli nutqiy muloqot uchun asos bo'ladi."
        },
        {
            "id": "creative_dev",
            "title": "Sibbord va ijodiy rivojlanish",
            "image": "assets/images/16_group_hall.webp",
            "content": "Sibbord nafaqat oldindan belgilangan harakatlarni bajarish, balki bola tomonidan shaxsiy o'yin vaziyatlarini yaratish uchun ham qo'llanilishi mumkin. Pedagog taklif qilishi mumkin: «Ushbu elementlar bilan o'yin o'ylab top» yoki «Sibborddagi tasvirlardan foydalanib hikoya tuz».\n\nNatijada bola elementlarni mustaqil tanlash, ularni birlashtirish va faoliyatning o'ziga xos variantlarini yaratish imkoniyatiga ega bo'ladi. Bu tasavvur, tashabbuskorlik, mustaqillik, fikrlashning moslashuvchanligi va ijodiy izlanishni namoyon etish uchun sharoit yaratadi."
        },
        {
            "id": "independent_activity",
            "title": "Sibbord va mustaqil faoliyat",
            "image": "assets/images/08_tree_pose.webp",
            "content": "Sibbordning pedagogik jihatdan muhim jihatlaridan biri bolaning mustaqil faoliyatini tashkil etish imkoniyatidir. Bola mustaqil ravishda elementni tanlashi, harakatlar ketma-ketligini belgilashi, topshiriqni bajarishning turli usullarini sinab ko'rishi va natijani tekshirishi mumkin.\n\nQiyinchilik yuzaga kelganda pedagog darhol tayyor javobni aytishi shart emas. U yo'naltiruvchi savollardan foydalanishi mumkin: «Yana bir bor urinib ko'r», «Seningcha, nega o'xshamadi?», «Bu yerga qaysi element mos keladi?», «Nimani o'zgartirish mumkin?»\n\nBunday yondashuv faqat tayyor namunani takrorlash emas, balki yechim izlash tajribasini shakllantirishga yordam beradi."
        },
        {
            "id": "multisensory_approach",
            "title": "Sibbord va multisensor yondashuv",
            "image": "assets/images/14_individual_lying.webp",
            "content": "Bir nechta idrok kanallarini birlashtirish imkoniyati alohida ahamiyatga ega. Ish jarayonida bola: ko'radi → ushlaydi → harakatlantiradi → eshitadi → natijani kuzatadi → uni muhokama qiladi.\n\nMasalan, bola qizil geometrik shaklni ko'radi, uni qo'li bilan oladi, shaklini aniqlaydi, tegishli joyga o'tkazadi va uni nomlaydi. Shunday qilib, bitta topshiriqda ko'rish idroki, taktil tajriba, harakat faolligi va nutqiy hamrohlik uyg'unlashishi mumkin."
        },
        {
            "id": "kinesiological_approach",
            "title": "Sibbord va kineziologik yondashuv",
            "image": "assets/images/15_pair_lying.webp",
            "content": "Sibbord bilan ishlash barmoqlar va kaftlarning turli harakatlarini, ko'rish-harakat koordinatsiyasini va harakat amallarini boshqarishni o'z ichiga oladi. Shuning uchun undan foydalanish harakat va bilish faolligi o'rtasidagi bog'liqlikni ko'rib chiqadigan yondashuvlar bilan metodik jihatdan bog'liq bo'lishi mumkin.\n\nShu bilan birga, ilmiy jihatdan to'g'ri bo'lishi uchun, Sibborddan har qanday foydalanish avtomatik ravishda oliy ruhiy funksiyalar yoki intellekt rivojlanishini ta'minlaydi deb da'vo qilmaslik lozim. Pedagogik samara topshiriq mazmuni, uning maqsadi, yoshga mosligi, qo'llashning tizimliligi va pedagogning kasbiy harakatlari bilan belgilanadi.\n\nShuning uchun ta'lim jarayonida Sibbordni suhbat, savollar, o'yin usullari, muammoli topshiriqlar, harakat mashqlari, ijodiy topshiriqlar, refleksiya va boshqa ta'lim vositalari bilan uyg'unlashtirish muhimdir."
        }
    ]
}

# ----------------- GOALS (RU) -----------------
goals_ru = {
    "id": "goals",
    "title": "Цель и задачи технологии Сибборд",
    "cover_image": "assets/images/05_group_lesson_hall.webp",
    "main_goal": {
        "title": "Цель технологии Сибборд",
        "description": "Основная цель технологии Сибборд заключается в целостном развитии познавательной, двигательной, сенсорной, речевой, творческой и социальной активности ребёнка, поддержке его самостоятельной деятельности, а также организации образовательного процесса на основе практической и интерактивной деятельности.\n\nИспользование Сибборда в дошкольном образовании позволяет ребёнку непосредственно взаимодействовать с различными предметами и механизмами, изучать их свойства, решать простые практические задачи, устанавливать причинно-следственные связи и наблюдать результаты собственной деятельности."
    },
    "app_goal": {
        "title": "Цель приложения SIBBOARD EDU",
        "description": "В рамках мобильного приложения SIBBOARD EDU данная цель расширяется и направляется на подготовку будущих педагогов к целесообразному и методически обоснованному использованию технологии Сибборд, а также на развитие их профессиональных компетенций."
    },
    "children_tasks": [
        {
            "no": 1,
            "title": "Развитие познавательной деятельности",
            "icon": "lightbulb",
            "items": [
                "развитие у ребёнка навыков наблюдения и сравнения;",
                "содействие пониманию свойств и признаков предметов;",
                "формирование представлений о причинно-следственных связях;",
                "ориентация ребёнка на поиск решений в проблемных ситуациях;",
                "поддержка самостоятельного мышления."
            ]
        },
        {
            "no": 2,
            "title": "Развитие мелкой моторики",
            "icon": "touch_app",
            "items": [
                "активизация движений пальцев и кистей рук;",
                "формирование точных и координированных движений;",
                "развитие зрительно-моторной координации;",
                "закрепление навыков выполнения практических действий в повседневной деятельности."
            ]
        },
        {
            "no": 3,
            "title": "Поддержка речевой деятельности",
            "icon": "chat_bubble",
            "items": [
                "создание условий для усвоения новых слов;",
                "побуждение к называнию предметов и действий;",
                "стимулирование способности отвечать на вопросы и выражать собственные мысли;",
                "развитие диалогической и монологической речи."
            ]
        },
        {
            "no": 4,
            "title": "Развитие творческого мышления",
            "icon": "brush",
            "items": [
                "стимулирование поиска нестандартных решений;",
                "создание различных педагогических и игровых ситуаций;",
                "предоставление возможности для самостоятельной разработки идей;",
                "поддержка воображения и творческой активности."
            ]
        },
        {
            "no": 5,
            "title": "Развитие социально-коммуникативных навыков",
            "icon": "people",
            "items": [
                "организация работы в парах и малых группах;",
                "развитие способности выражать собственное мнение;",
                "формирование умения слушать мнение других;",
                "организация совместной деятельности;",
                "формирование навыков соблюдения очередности и общих правил."
            ]
        },
        {
            "no": 6,
            "title": "Формирование самостоятельности",
            "icon": "star",
            "items": [
                "предоставление возможности самостоятельно выполнять задания;",
                "развитие навыков выбора;",
                "ориентация на самостоятельное выявление и исправление ошибок;",
                "формирование умения оценивать результаты собственной деятельности."
            ]
        }
    ],
    "pedagogue_tasks": [
        "Обучение будущих педагогов теоретическим основам технологии Сибборд.",
        "Раскрытие педагогических возможностей технологии Сибборд.",
        "Формирование умений разрабатывать задания на основе Сибборда для занятий в дошкольных образовательных организациях.",
        "Формирование навыков создания педагогических ситуаций, соответствующих различным возрастным группам детей.",
        "Развитие у студентов творческой и проектировочной компетентности.",
        "Развитие навыков самостоятельного решения педагогических проблем.",
        "Формирование умений организовывать интерактивную и практическую образовательную деятельность.",
        "Обучение анализу собственной педагогической деятельности и осуществлению профессиональной рефлексии.",
        "Формирование навыков оценки результатов применения технологии Сибборд.",
        "Поэтапное развитие профессиональных компетенций будущих педагогов посредством специально организованной работы с технологией Сибборд."
    ]
}

# ----------------- GOALS (UZ) -----------------
goals_uz = {
    "id": "goals",
    "title": "Sibbord texnologiyasining maqsad va vazifalari",
    "cover_image": "assets/images/05_group_lesson_hall.webp",
    "main_goal": {
        "title": "Sibbord texnologiyasining maqsadi",
        "description": "Sibbord texnologiyasining asosiy maqsadi bolaning bilish, harakat, sensor, nutq, ijodiy va ijtimoiy faolligini yaxlit rivojlantirish, uning mustaqil faoliyatini qo'llab-quvvatlash, shuningdek ta'lim jarayonini amaliy va interaktiv faoliyat asosida tashkil etishdan iborat.\n\nMaktabgacha ta'limda Sibborddan foydalanish bolaga turli buyumlar va mexanizmlar bilan bevosita muloqot qilish, ularning xususiyatlarini o'rganish, oddiy amaliy masalalarni yechish, sabab-oqibat bog'lanishlarini o'rnatish va o'z faoliyati natijalarini kuzatish imkonini beradi."
    },
    "app_goal": {
        "title": "SIBBOARD EDU ilovasining maqsadi",
        "description": "SIBBOARD EDU mobil ilovasi doirasida ushbu maqsad kengaytiriladi va bo'lajak pedagoglarni Sibbord texnologiyasidan maqsadli va metodik asoslangan holda foydalanishga tayyorlashga, shuningdek ularning kasbiy kompetensiyalarini rivojlantirishga yo'naltiriladi."
    },
    "children_tasks": [
        {
            "no": 1,
            "title": "Bilish (kognitiv) faoliyatini rivojlantirish",
            "icon": "lightbulb",
            "items": [
                "bolada kuzatish va taqqoslash ko'nikmalarini rivojlantirish;",
                "buyumlarning xususiyatlari va belgilarini tushunishga ko'maklashish;",
                "sabab-oqibat bog'lanishlari haqida tasavvurlarni shakllantirish;",
                "bolani muammoli vaziyatlarda yechim izlashga yo'naltirish;",
                "mustaqil fikrlashni qo'llab-quvvatlash."
            ]
        },
        {
            "no": 2,
            "title": "Mayda motorikani rivojlantirish",
            "icon": "touch_app",
            "items": [
                "barmoqlar va qo'l kaftlari harakatlarini faollashtirish;",
                "aniq va muvofiqlashtirilgan harakatlarni shakllantirish;",
                "ko'rish-harakat koordinatsiyasini rivojlantirish;",
                "kundalik faoliyatda amaliy harakatlarni bajarish ko'nikmalarini mustahkamlash."
            ]
        },
        {
            "no": 3,
            "title": "Nutq faoliyatini qo'llab-quvvatlash",
            "icon": "chat_bubble",
            "items": [
                "yangi so'zlarni o'zlashtirish uchun sharoit yaratish;",
                "buyumlar va harakatlarni nomlashga undash;",
                "savollarga javob berish va o'z fikrlarini ifodalash qobiliyatini rag'batlantirish;",
                "dialogik va monologik nutqni rivojlantirish."
            ]
        },
        {
            "no": 4,
            "title": "Ijodiy fikrlashni rivojlantirish",
            "icon": "brush",
            "items": [
                "nostandart yechimlarni izlashni rag'batlantirish;",
                "turli pedagogik va o'yin vaziyatlarini yaratish;",
                "g'oyalarni mustaqil ishlab chiqish uchun imkoniyat yaratish;",
                "tasavvur va ijodiy faollikni qo'llab-quvvatlash."
            ]
        },
        {
            "no": 5,
            "title": "Ijtimoiy-kommunikativ ko'nikmalarni rivojlantirish",
            "icon": "people",
            "items": [
                "juftlikda va kichik guruhlarda ishlashni tashkil etish;",
                "o'z fikrini ifoda etish qobiliyatini rivojlantirish;",
                "boshqalarning fikrini tinglash ko'nikmasini shakllantirish;",
                "birgalikdagi faoliyatni tashkil qilish;",
                "navbatga va umumiy qoidalarga rioya qilish ko'nikmalarini shakllantirish."
            ]
        },
        {
            "no": 6,
            "title": "Mustaqillikni shakllantirish",
            "icon": "star",
            "items": [
                "topshiriqlarni mustaqil bajarish imkoniyatini taqdim etish;",
                "tanlash ko'nikmalarini rivojlantirish;",
                "xatolarni mustaqil aniqlash va tuzatishga yo'naltirish;",
                "shaxsiy faoliyat natijalarini baholash qobiliyatini shakllantirish."
            ]
        }
    ],
    "pedagogue_tasks": [
        "Bo'lajak pedagoglarga Sibbord texnologiyasining nazariy asoslarini o'rgatish.",
        "Sibbord texnologiyasining pedagogik imkoniyatlarini ochib berish.",
        "Maktabgacha ta'lim tashkilotlaridagi mashg'ulotlar uchun Sibbord asosida topshiriqlar ishlab chiqish ko'nikmalarini shakllantirish.",
        "Bolalarning turli yosh guruhlariga mos keladigan pedagogik vaziyatlarni yaratish ko'nikmalarini shakllantirish.",
        "Talabalarda ijodiy va loyihalash kompetensiyasini rivojlantirish.",
        "Pedagogik muammolarni mustaqil hal qilish ko'nikmalarini rivojlantirish.",
        "Interaktiv va amaliy ta'lim faoliyatini tashkil etish ko'nikmalarini shakllantirish.",
        "O'z pedagogik faoliyatini tahlil qilish va kasbiy refleksiyani amalga oshirishga o'rgatish.",
        "Sibbord texnologiyasini qo'llash natijalarini baholash ko'nikmalarini shakllantirish.",
        "Sibbord texnologiyasi bilan maxsus tashkil etilgan ish orqali bo'lajak pedagoglarning kasbiy kompetensiyalarini bosqichma-bosqich rivojlantirish."
    ]
}

# ----------------- CAPABILITIES (RU) -----------------
capabilities_ru = {
    "id": "capabilities",
    "title": "Педагогические возможности технологии Сибборд",
    "overview": "Технология Сибборд обладает широкими педагогическими возможностями и может использоваться как средство организации активной, практико-ориентированной, интерактивной и развивающей образовательной деятельности. Её педагогический потенциал связан с возможностью объединения предметно-практических действий ребёнка с познавательными, сенсорными, двигательными, речевыми и творческими заданиями.\n\nВ дошкольном образовании Сибборд может выступать не только как средство самостоятельной игры, но и как инструмент педагогического сопровождения, с помощью которого воспитатель создаёт специальные образовательные ситуации, задаёт вопросы, предлагает проблемные задания, организует взаимодействие детей и оценивает результаты деятельности.\n\nВ рамках SIBBOARD EDU педагогические возможности Сибборда рассматриваются также с позиции подготовки будущего педагога к проектированию и проведению развивающей деятельности.",
    "key_idea": "Сибборд становится педагогически значимым средством не только благодаря своим развивающим элементам, но прежде всего благодаря тому, как педагог ставит цель, конструирует задание, организует взаимодействие ребёнка с материалом и анализирует полученный результат.\n\nИменно этот принцип лежит в основе SIBBOARD EDU: приложение обучает будущего педагога не просто «работать с Сиббордом», а проектировать педагогически обоснованную деятельность с использованием Сибборд-технологии.",
    "cards": [
        {
            "no": 1,
            "title": "Познавательная активность",
            "develops": "мышление, внимание, анализ",
            "image": "assets/images/12_boy_sticks.webp",
            "back": "Формирует способность наблюдать, сравнивать, группировать предметы по признакам и устанавливать причинно-следственные связи в процессе практических действий."
        },
        {
            "no": 2,
            "title": "Сенсомоторная активность",
            "develops": "моторика, координация",
            "image": "assets/images/11_child_on_board.webp",
            "back": "Тренирует согласованную работу зрительного анализатора и пальцев рук, точность движений при манипуляциях с мелкими деталями и балансировании."
        },
        {
            "no": 3,
            "title": "Сенсорное развитие",
            "develops": "цвет, форма, размер, фактура",
            "image": "assets/images/04_cork_board.webp",
            "back": "Обогащает сенсорный опыт через тактильное обследование различных поверхностей, различение геометрических фигур, цветовых оттенков и пропорций."
        },
        {
            "no": 4,
            "title": "Речевое развитие",
            "develops": "словарь, диалог, связная речь",
            "image": "assets/images/10_pair_exercise.webp",
            "back": "Стимулирует речевое сопровождение действий, комментирование выполняемых операций, обогащение глагольного и качественного словаря."
        },
        {
            "no": 5,
            "title": "Творческая деятельность",
            "develops": "воображение, инициативность",
            "image": "assets/images/06_kids_home_play.webp",
            "back": "Побуждает к созданию собственных игровых сюжетов, придумыванию историй и нестандартных способов комбинирования развивающих элементов."
        },
        {
            "no": 6,
            "title": "Проблемное обучение",
            "develops": "поиск и решение задач",
            "image": "assets/images/13_problem_solving.webp",
            "back": "Моделирует проблемные ситуации (заклинивший элемент, неподходящая деталь), направляя ребёнка по циклу: гипотеза → проба → проверка → вывод."
        },
        {
            "no": 7,
            "title": "Совместная деятельность",
            "develops": "коммуникация, сотрудничество",
            "image": "assets/images/16_group_hall.webp",
            "back": "Учит распределять роли в парах и малых группах, договариваться, соблюдать очередность и достигать общего положительного результата."
        },
        {
            "no": 8,
            "title": "Самостоятельная деятельность",
            "develops": "инициатива, выбор, ответственность",
            "image": "assets/images/08_tree_pose.webp",
            "back": "Предоставляет ребёнку возможность автономного выбора последовательности действий, самоконтроля и исправления ошибок без вмешательства взрослого."
        },
        {
            "no": 9,
            "title": "Индивидуализация",
            "develops": "учёт возможностей ребёнка",
            "image": "assets/images/14_individual_lying.webp",
            "back": "Позволяет гибко адаптировать сложность, темп и дидактические цели одного и того же элемента под индивидуальные особенности каждого воспитанника."
        },
        {
            "no": 10,
            "title": "Профессиональная подготовка",
            "develops": "проектирование и рефлексия",
            "image": "assets/images/05_group_lesson_hall.webp",
            "back": "Формирует у студентов педагогических вузов методические навыки моделирования развивающих занятий и осознанной педагогической рефлексии."
        }
    ]
}

# ----------------- CAPABILITIES (UZ) -----------------
capabilities_uz = {
    "id": "capabilities",
    "title": "Sibbord texnologiyasining pedagogik imkoniyatlari",
    "overview": "Sibbord texnologiyasi keng pedagogik imkoniyatlarga ega bo'lib, faol, amaliyotga yo'naltirilgan, interaktiv va rivojlantiruvchi ta'lim faoliyatini tashkil etish vositasi sifatida qo'llanilishi mumkin. Uning pedagogik salohiyati bolaning predmetli-amaliy harakatlarini bilish, sensor, harakat, nutq va ijodiy topshiriqlar bilan birlashtirish imkoniyati bilan bog'liq.\n\nMaktabgacha ta'limda Sibbord nafaqat mustaqil o'yin vositasi, balki tarbiyachi maxsus ta'lim vaziyatlarini yaratadigan, savollar beradigan, muammoli vazifalarni taklif qiladigan, bolalarning o'zaro hamkorligini tashkil etadigan va faoliyat natijalarini baholaydigan pedagogik hamrohlik vositasi sifatida ham xizmat qilishi mumkin.\n\nSIBBOARD EDU doirasida Sibbordning pedagogik imkoniyatlari bo'lajak pedagoglarni rivojlantiruvchi faoliyatni loyihalash va o'tkazishga tayyorlash nuqtai nazaridan ham ko'rib chiqiladi.",
    "key_idea": "Sibbord nafaqat o'zining rivojlantiruvchi elementlari tufayli, balki birinchi navbatda pedagog maqsadni qanday qo'yishi, topshiriqni qanday loyihalashi, bolaning material bilan o'zaro ta'sirini qanday tashkil etishi va olingan natijani qanday tahlil qilishi tufayli pedagogik ahamiyatga ega vositaga aylanadi.\n\nAynan shu tamoyil SIBBOARD EDU asosini tashkil etadi: ilova bo'lajak pedagogga shunchaki «Sibbord bilan ishlash»ni emas, balki Sibbord texnologiyasidan foydalangan holda pedagogik jihatdan asoslangan faoliyatni loyihalashni o'rgatadi.",
    "cards": [
        {
            "no": 1,
            "title": "Bilish (kognitiv) faolligi",
            "develops": "tafakkur, diqqat, tahlil",
            "image": "assets/images/12_boy_sticks.webp",
            "back": "Amaliy harakatlar jarayonida kuzatish, taqqoslash, buyumlarni belgilariga ko'ra guruhlash va sabab-oqibat bog'lanishlarini o'rnatish qobiliyatini shakllantiradi."
        },
        {
            "no": 2,
            "title": "Sensomotor faollik",
            "develops": "motorika, koordinatsiya",
            "image": "assets/images/11_child_on_board.webp",
            "back": "Ko'rish analizatori va qo'l barmoqlarining uyg'un ishlashini, mayda detallar bilan harakatlanishda va muvozanat saqlashda harakatlar aniqligini mashq qildiradi."
        },
        {
            "no": 3,
            "title": "Sensor rivojlanish",
            "develops": "rang, shakl, o'lcham, tekstura",
            "image": "assets/images/04_cork_board.webp",
            "back": "Turli sirtlarni taktil tekshirish, geometrik shakllar, rang tuslari va proporsiyalarni farqlash orqali sensor tajribani boyitadi."
        },
        {
            "no": 4,
            "title": "Nutqiy rivojlanish",
            "develops": "lug'at boyligi, muloqot, bog'lanishli nutq",
            "image": "assets/images/10_pair_exercise.webp",
            "back": "Harakatlarning nutqiy hamrohligini, bajarilayotgan amallarni sharhlashni, fe'l va sifat lug'atini boyitishni rag'batlantiradi."
        },
        {
            "no": 5,
            "title": "Ijodiy faoliyat",
            "develops": "tasavvur, tashabbuskorlik",
            "image": "assets/images/06_kids_home_play.webp",
            "back": "Shaxsiy o'yin syujetlarini yaratishga, hikoyalar to'qishga va rivojlantiruvchi elementlarni nostandart usulda birlashtirishga undaydi."
        },
        {
            "no": 6,
            "title": "Muammoli ta'lim",
            "develops": "yechim izlash va masalalarni hal qilish",
            "image": "assets/images/13_problem_solving.webp",
            "back": "Muammoli vaziyatlarni (tiqilib qolgan detal, mos kelmagan shakl) modellashtiradi: gipoteza → sinab ko'rish → tekshirish → xulosa bosqichlari bo'yicha yo'naltiradi."
        },
        {
            "no": 7,
            "title": "Hamkorlikdagi faoliyat",
            "develops": "kommunikatsiya, hamkorlik",
            "image": "assets/images/16_group_hall.webp",
            "back": "Juftlik va kichik guruhlarda rollarni taqsimlashni, kelishishni, navbatga rioya qilishni va umumiy ijobiy natijaga erishishni o'rgatadi."
        },
        {
            "no": 8,
            "title": "Mustaqil faoliyat",
            "develops": "tashabbus, tanlov, mas'uliyat",
            "image": "assets/images/08_tree_pose.webp",
            "back": "Bolaga harakatlar ketma-ketligini mustaqil tanlash, kattalarning aralashuvisiz o'z-o'zini nazorat qilish va xatolarni tuzatish imkoniyatini beradi."
        },
        {
            "no": 9,
            "title": "Individuallashtirish",
            "develops": "bolaning imkoniyatlarini hisobga olish",
            "image": "assets/images/14_individual_lying.webp",
            "back": "Bitta elementning murakkabligi, sur'ati va didaktik maqsadlarini har bir tarbiyalanuvchining individual xususiyatlariga moslashtirish imkonini beradi."
        },
        {
            "no": 10,
            "title": "Kasbiy tayyorgarlik",
            "develops": "loyihalash va refleksiya",
            "image": "assets/images/05_group_lesson_hall.webp",
            "back": "Pedagogika oliygohlari talabalarida rivojlantiruvchi mashg'ulotlarni modellashtirish va ongli pedagogik refleksiyani amalga oshirish ko'nikmalarini shakllantiradi."
        }
    ]
}

# ----------------- WORK (RU) -----------------
work_ru = {
    "id": "work",
    "title": "Возможности работы с Сиббордом",
    "overview": "Работа с Сиббордом основывается на непосредственном взаимодействии ребёнка с различными предметными, сенсорными, двигательными и дидактическими элементами. В процессе такой деятельности ребёнок выполняет практические действия, исследует свойства предметов, решает поставленные задачи и получает опыт самостоятельной деятельности.\n\nПедагог при этом организует деятельность целенаправленно: определяет образовательную цель, подбирает соответствующие элементы, формулирует задания, наблюдает за действиями ребёнка, при необходимости оказывает педагогическую поддержку и анализирует полученный результат.\n\nЭффективность работы с Сиббордом зависит от возраста ребёнка, его индивидуальных возможностей, содержания задания, педагогической цели и методики организации деятельности.",
    "topics": [
        {
            "no": 1,
            "title": "Практическая работа с элементами Сибборда",
            "image": "assets/images/07_pair_balance.webp",
            "description": "Ребёнок может выполнять различные действия: застёгивать и расстёгивать пуговицы; открывать и закрывать молнии; завязывать и развязывать шнурки; открывать и закрывать крючки; работать с безопасными замками; вставлять и поворачивать ключ; вращать колёсики; соединять магнитные элементы; подбирать геометрические фигуры; перемещать и группировать детали; располагать элементы в определённой последовательности.\n\nТакие действия создают условия для развития мелкой моторики, точности движений и зрительно-моторной координации."
        },
        {
            "no": 2,
            "title": "Постепенное усложнение заданий",
            "image": "assets/images/12_boy_sticks.webp",
            "description": "Работу с Сиббордом целесообразно организовывать от простых действий к более сложным через 5 последовательных этапов:\n1. Знакомство: ребёнок рассматривает элементы, знакомится с их названиями.\n2. Подражание: педагог показывает действие, ребёнок повторяет.\n3. Самостоятельное выполнение: выполнение предложенного задания без помощи.\n4. Проблемное задание: поиск решения в нестандартной ситуации.\n5. Творческая деятельность: ребёнок самостоятельно придумывает игру или правила."
        },
        {
            "no": 3,
            "title": "Организация игровой деятельности",
            "image": "assets/images/06_kids_home_play.webp",
            "description": "Сибборд позволяет объединять образовательные задачи с игровыми ситуациями:\n• «Открой замок» — ребёнок выбирает подходящий ключ и открывает замок.\n• «Найди цвет» — поиск элемента заданного цвета.\n• «Подбери форму» — подбор геометрической фигуры к отверстию.\n• «Помоги герою» — сюжетная ситуация, требующая действий с элементами.\n\nИгровое задание должно иметь конкретную педагогическую цель, соответствующую возрасту ребёнка."
        },
        {
            "no": 4,
            "title": "Развитие речевой деятельности",
            "image": "assets/images/10_pair_exercise.webp",
            "description": "Работа сопровождается активным речевым взаимодействием. Педагог задаёт вопросы: «Что это?», «Какого цвета?», «Что ты сейчас делаешь?», «Для чего нужен этот элемент?», «Какой элемент подходит?», «Почему не получилось?», «Как выполнить по-другому?»\n\nРебёнок учится называть предметы, обозначать действия, описывать свойства, отвечать на вопросы, составлять предложения и объяснять последовательность."
        },
        {
            "no": 5,
            "title": "Создание проблемных ситуаций",
            "image": "assets/images/13_problem_solving.webp",
            "description": "Сибборд предоставляет возможность моделировать простые проблемные ситуации. Например: «Замок не открывается. Что нужно сделать?» или «Эта фигура не подходит. Какую необходимо выбрать?»\n\nРебёнок пробует несколько вариантов, сравнивает результаты и самостоятельно находит решение.\n\nФормируется последовательность: Проблема → предположение → действие → проверка → результат → вывод."
        },
        {
            "no": 6,
            "title": "Работа в парах и малых группах",
            "image": "assets/images/16_group_hall.webp",
            "description": "Сибборд может использоваться для совместной деятельности: в парах, малых группах, в рамках совместной игры или при выполнении общего проекта.\n\nНапример: «Используя элементы Сибборда, подготовьте материалы для игры “Магазин”». Дети распределяют действия, обсуждают варианты, выполняют задания и получают общий результат, развивая навыки сотрудничества и соблюдения очередности."
        },
        {
            "no": 7,
            "title": "Использование в различных образовательных направлениях",
            "image": "assets/images/09_lunge_pose.webp",
            "description": "Сибборд успешно интегрируется во все ключевые направления:\n🗣️ Речевое развитие — словарь, описание, рассказы.\n🔢 Математические представления — счёт, сравнение, форма, размер.\n🌿 Окружающий мир — природа, времена года, явления.\n🎨 Художественно-творческая деятельность — цвет, композиция.\n🏗️ Конструктивная деятельность — сборка, комбинирование.\n🎭 Театрализованная деятельность — сюжеты, персонажи.\n🎲 Игровая деятельность — парные и групповые развивающие игры."
        },
        {
            "no": 8,
            "title": "Организация самостоятельной деятельности",
            "image": "assets/images/08_tree_pose.webp",
            "description": "Педагог создаёт условия для самостоятельного поиска: «Как ты думаешь, что нужно сделать?», «Попробуй найти другой способ», «Как можно проверить свой ответ?»\n\nРебёнок пробует разные варианты, обнаруживает ошибки и ищет альтернативные решения. Педагог выступает как организатор, консультант и направляющий партнер."
        },
        {
            "no": 9,
            "title": "Индивидуализация работы",
            "image": "assets/images/14_individual_lying.webp",
            "description": "Сложность заданий варьируется в зависимости от возраста, уровня подготовленности, индивидуального темпа, двигательных и познавательных возможностей.\n\nНапример, одному ребёнку даётся задание «Найди красный круг», а другому — более сложное: «Найди все красные фигуры, сравни их и расположи от самой маленькой к самой большой»."
        },
        {
            "no": 10,
            "title": "Соблюдение правил безопасности",
            "image": "assets/images/04_cork_board.webp",
            "description": "Безопасность — обязательное условие организации работы. Педагог проверяет прочность крепления элементов, исключает острые и травмоопасные части, учитывает возраст при выборе мелких деталей, контролирует деятельность детей и не допускает использования неисправных деталей."
        },
        {
            "no": 11,
            "title": "Роль педагога при работе с Сиббордом",
            "image": "assets/images/15_pair_lying.webp",
            "description": "Педагог строит работу по 8-шаговому алгоритму. При этом оценивается не только правильность выполнения, но и способ действия ребёнка, степень его самостоятельности, инициативность и способность вербально объяснить полученный результат."
        }
    ],
    "stages": [
        {
            "step": 1,
            "title": "Знакомство",
            "description": "Ребёнок рассматривает элементы, прикасается к ним и знакомится с их названиями и назначением под доброжелательным наблюдением педагога."
        },
        {
            "step": 2,
            "title": "Подражание",
            "description": "Педагог демонстрирует определённый способ действия (как повернуть, застегнуть, продеть), после чего ребёнок повторяет увиденное."
        },
        {
            "step": 3,
            "title": "Самостоятельное выполнение",
            "description": "Ребёнок выполняет предложенное практическое задание самостоятельно, без постоянной подсказки взрослого."
        },
        {
            "step": 4,
            "title": "Проблемное задание",
            "description": "Ребёнку предлагается найти способ решения определённой практической проблемы («деталь не входит», «замок не поворачивается»)."
        },
        {
            "step": 5,
            "title": "Творческая деятельность",
            "description": "Ребёнок самостоятельно придумывает собственную игру, новое правило или сюжетный способ использования элементов Сибборда."
        }
    ],
    "algorithm": [
        {"step": 1, "title": "Определение цели", "desc": "Формулирование конкретной развивающей или образовательной цели занятия."},
        {"step": 2, "title": "Выбор элементов", "desc": "Подбор элементов Сибборда, наиболее эффективных для поставленной цели."},
        {"step": 3, "title": "Постановка задания", "desc": "Четкая и понятная для ребёнка формулировка игровой или практической задачи."},
        {"step": 4, "title": "Демонстрация способа", "desc": "Показ приёма действия педагогом (только при необходимости на этапе обучения)."},
        {"step": 5, "title": "Самостоятельная деятельность", "desc": "Предоставление ребёнку времени и пространства для индивидуального действия."},
        {"step": 6, "title": "Педагогическая поддержка", "desc": "Наблюдение, стимулирующие вопросы и наводящие подсказки без выполнения за ребёнка."},
        {"step": 7, "title": "Анализ результата", "desc": "Совместное обсуждение полученного итога и пути его достижения."},
        {"step": 8, "title": "Рефлексия", "desc": "Осознание ребёнком успешности своих действий и формулирование педагогом выводов."}
    ],
    "algorithm_reminder": "Педагог должен учитывать не только правильность выполнения задания, но и способ действия ребёнка, степень самостоятельности, инициативность и способность объяснить полученный результат.",
    "virtual_elements": [
        {
            "id": "button",
            "name": "Пуговица",
            "symbol": "🔘",
            "develops": "Точность движений пальцев и кисти, мелкая моторика",
            "task": "Задание на самостоятельное действие: застегни и расстегни пуговицу, соблюдая аккуратность."
        },
        {
            "id": "lock",
            "name": "Замок",
            "symbol": "🔐",
            "develops": "Проблемная ситуация, аналитическое мышление и поиск решений",
            "task": "Проблемное задание: подбери подходящий ключ и открой замок, определив правильное направление поворота."
        },
        {
            "id": "geo_shape",
            "name": "Геометрическая фигура",
            "symbol": "🔺",
            "develops": "Сенсорное и математическое развитие, классификация и сравнение",
            "task": "Дидактическое задание: найди фигуру заданной формы и цвета, сопоставь с соответствующим контуром."
        },
        {
            "id": "wheel",
            "name": "Колёсико",
            "symbol": "🔄",
            "develops": "Двигательная активность, координация и причинно-следственные связи",
            "task": "Практическое задание: поверни колёсико и проследи, как передаётся движение другим связанным элементам."
        },
        {
            "id": "lacing",
            "name": "Шнуровка",
            "symbol": "🧵",
            "develops": "Мелкая моторика, пространственная ориентация и последовательность действий",
            "task": "Комплексное задание: продень шнурок через отверстия по заданному порядку, завяжи узелок."
        }
    ],
    "builder_options": {
        "age_groups": ["3–4 года", "4–5 лет", "5–6 лет", "6–7 лет"],
        "directions": [
            "Речевое развитие",
            "Элементарные математические представления",
            "Ознакомление с природой и окружающим миром",
            "Художественно-творческая деятельность",
            "Конструктивная деятельность",
            "Театрализованная деятельность",
            "Игровая деятельность"
        ],
        "sample_task": {
            "title": "Разработайте развивающее задание на основе Сибборда для детей 4–5 лет",
            "age_group": "4–5 лет",
            "direction": "Элементарные математические представления",
            "goal": "Развитие пространственной ориентации, счета и последовательности действий",
            "element": "Шнуровка",
            "content": "Продень цветной шнурок через пронумерованные отверстия от 1 до 5",
            "child_actions": "Ребёнок называет цифры вслух и продевает шнурок по порядку возрастания",
            "pedagogue_questions": "С какого номера ты начал? Какая цифра идёт следующей? Куда сейчас направляется шнурок?",
            "expected_result": "Шнурок правильно продет через все 5 отверстий, ребёнок может проговорить последовательность",
            "evaluation_method": "Наблюдение за самостоятельностью, правильностью счета и аккуратностью выполнения движений"
        }
    }
}

# ----------------- WORK (UZ) -----------------
work_uz = {
    "id": "work",
    "title": "Sibbord bilan ishlash imkoniyatlari",
    "overview": "Sibbord bilan ishlash bolaning turli predmetli, sensor, harakat va didaktik elementlar bilan bevosita munosabatiga asoslanadi. Bunday faoliyat jarayonida bola amaliy harakatlarni bajaradi, buyumlarning xususiyatlarini o'rganadi, qo'yilgan vazifalarni yechadi va mustaqil faoliyat tajribasini orttiradi.\n\nPedagog bu jarayonni maqsadli tashkil etadi: ta'lim maqsadini belgilaydi, mos elementlarni tanlaydi, topshiriqlarni shakllantiradi, bolaning harakatlarini kuzatadi, zarur hollarda pedagogik yordam ko'rsatadi va olingan natijani tahlil qiladi.\n\nSibbord bilan ishlash samaradorligi bolaning yoshi, individual imkoniyatlari, topshiriq mazmuni, pedagogik maqsad va faoliyatni tashkil etish metodikasiga bog'liq.",
    "topics": [
        {
            "no": 1,
            "title": "Sibbord elementlari bilan amaliy ish",
            "image": "assets/images/07_pair_balance.webp",
            "description": "Bola turli harakatlarni bajarishi mumkin: tugmalarni qadash va yechish; molniyalarni ochish va yopish; bog'ichlarni bog'lash va yechish; ilgaklarni ochish va yopish; xavfsiz qulflar bilan ishlash; kalitni solish va burash; g'ildirakchalarni aylantirish; magnit elementlarni birlashtirish; geometrik shakllarni tanlash; detallarni ko'chirish va guruhlash; elementlarni muayyan ketma-ketlikda joylashtirish.\n\nBunday amallar mayda motorika, harakatlar aniqligi va ko'rish-harakat koordinatsiyasini rivojlantirish uchun sharoit yaratadi."
        },
        {
            "no": 2,
            "title": "Topshiriqlarni bosqichma-bosqich murakkablashtirish",
            "image": "assets/images/12_boy_sticks.webp",
            "description": "Sibbord bilan ishlashni oddiy harakatlardan murakkabroq harakatlarga qarab 5 ta bosqichda tashkil etish maqsadga muvofiqdir:\n1. Tanishuv: bola elementlarni ko'zdan kechiradi, ularning nomlari bilan tanishadi.\n2. Taqlid qilish: pedagog harakatni ko'rsatadi, bola takrorlaydi.\n3. Mustaqil bajarish: berilgan topshiriqni yordamsiz bajarish.\n4. Muammoli topshiriq: nostandart vaziyatda yechim izlash.\n5. Ijodiy faoliyat: bola mustaqil ravishda o'yin yoki qoidalar o'ylab topadi."
        },
        {
            "no": 3,
            "title": "O'yin faoliyatini tashkil etish",
            "image": "assets/images/06_kids_home_play.webp",
            "description": "Sibbord ta'lim vazifalarini o'yin vaziyatlari bilan birlashtirishga imkon beradi:\n• «Qulfni och» — bola mos kalitni tanlaydi va qulfni ochadi.\n• «Rangni top» — berilgan rangdagi elementni izlash.\n• «Shaklni mosla» — geometrik shaklni tegishli teshikka moslashtirish.\n• «Qahramonga yordam ber» — elementlar bilan harakatlarni talab qiladigan syujetli vaziyat.\n\nO'yin topshirig'i bolaning yoshiga mos keladigan aniq pedagogik maqsadga ega bo'lishi kerak."
        },
        {
            "no": 4,
            "title": "Nutq faoliyatini rivojlantirish",
            "image": "assets/images/10_pair_exercise.webp",
            "description": "Ish faol nutqiy muloqot bilan birga olib boriladi. Pedagog savollar beradi: «Bu nima?», «Qanday rangda?», «Hozir nima qilyapsan?», «Bu element nima uchun kerak?», «Qaysi element mos keladi?», «Nega o'xshamadi?», «Boshqacha qanday bajarish mumkin?»\n\nBola buyumlarni nomlashni, harakatlarni ifodalashni, xususiyatlarni tasvirlashni, savollarga javob berishni va ketma-ketlikni tushuntirishni o'rganadi."
        },
        {
            "no": 5,
            "title": "Muammoli vaziyatlarni yaratish",
            "image": "assets/images/13_problem_solving.webp",
            "description": "Sibbord oddiy muammoli vaziyatlarni modellashtirish imkonini beradi. Masalan: «Qulf ochilmayapti. Nima qilish kerak?» yoki «Bu shakl mos kelmadi. Qaysi birini tanlash lozim?»\n\nBola bir nechta variantlarni sinab ko'radi, natijalarni solishtiradi va mustaqil ravishda yechim topadi.\n\nKetma-ketlik shakllanadi: Muammo → taxmin → harakat → tekshirish → natija → xulosa."
        },
        {
            "no": 6,
            "title": "Juftlikda va kichik guruhlarda ishlash",
            "image": "assets/images/16_group_hall.webp",
            "description": "Sibbord birgalikdagi faoliyat uchun qo'llanilishi mumkin: juftlikda, kichik guruhlarda, umumiy o'yin yoki umumiy loyihani bajarishda.\n\nMasalan: «Sibbord elementlaridan foydalanib “Do'kon” o'yini uchun materiallar tayyorlang». Bolalar harakatlarni taqsimlaydilar, variantlarni muhokama qiladilar, vazifalarni bajaradilar va hamkorlik hamda navbatga rioya qilish ko'nikmalarini rivojlantiradilar."
        },
        {
            "no": 7,
            "title": "Turli ta'lim yo'nalishlarida foydalanish",
            "image": "assets/images/09_lunge_pose.webp",
            "description": "Sibbord barcha asosiy yo'nalishlarga muvaffaqiyatli integratsiyalashadi:\n🗣️ Nutqiy rivojlanish — lug'at, tasvirlash, hikoyalar.\n🔢 Elementar matematik tasavvurlar — hisoblash, taqqoslash, shakl, o'lcham.\n🌿 Atrof-muhit bilan tanishtirish — tabiat, fasllar, hodisalar.\n🎨 Badiiy-ijodiy faoliyat — rang, kompozitsiya.\n🏗️ Konstruktiv faoliyat — yig'ish, birlashtirish.\n🎭 Teatrlashtirilgan faoliyat — syujetlar, qahramonlar.\n🎲 O'yin faoliyati — juftlik va guruhli rivojlantiruvchi o'yinlar."
        },
        {
            "no": 8,
            "title": "Mustaqil faoliyatni tashkil etish",
            "image": "assets/images/08_tree_pose.webp",
            "description": "Pedagog mustaqil izlanish uchun sharoit yaratadi: «Seningcha nima qilish kerak?», «Boshqa usulni topib ko'r», «Javobingni qanday tekshirish mumkin?»\n\nBola turli variantlarni sinab ko'radi, xatolarni aniqlaydi va muqobil yechimlarni izlaydi. Pedagog tashkilotchi, maslahatchi va yo'naltiruvchi sherik sifatida qatnashadi."
        },
        {
            "no": 9,
            "title": "Ishni individuallashtirish",
            "image": "assets/images/14_individual_lying.webp",
            "description": "Topshiriqlar murakkabligi yoshga, tayyorgarlik darajasiga, individual sur'atga, harakat va bilish imkoniyatlariga qarab o'zgaradi.\n\nMasalan, bir bolaga «Qizil doirani top» topshirig'i berilsa, boshqasiga murakkabroq topshiriq beriladi: «Barcha qizil shakllarni top, ularni solishtir va eng kichigidan eng kattasiga qarab joylashtir»."
        },
        {
            "no": 10,
            "title": "Xavfsizlik qoidalariga rioya qilish",
            "image": "assets/images/04_cork_board.webp",
            "description": "Xavfsizlik — ishni tashkil etishning majburiy shartidir. Pedagog elementlarning mustahkam mahkamlanganligini tekshiradi, o'tkir va xavfli qismlarni chiqarib tashlaydi, mayda detallarni tanlashda yoshni hisobga oladi, bolalar faoliyatini nazorat qiladi va nosoz qismlardan foydalanishga yo'l qo'ymaydi."
        },
        {
            "no": 11,
            "title": "Sibbord bilan ishlashda pedagogning roli",
            "image": "assets/images/15_pair_lying.webp",
            "description": "Pedagog ishni 8 bosqichli algoritm bo'yicha quradi. Bunda nafaqat to'g'ri bajarilgani, balki bolaning harakat qilish usuli, mustaqillik darajasi, tashabbuskorligi va olingan natijani og'zaki tushuntira olish qobiliyati ham baholanadi."
        }
    ],
    "stages": [
        {
            "step": 1,
            "title": "Tanishuv",
            "description": "Bola elementlarni ko'zdan kechiradi, ularga tegib ko'radi va pedagogning xayrixoh nazorati ostida ularning nomlari va vazifalari bilan tanishadi."
        },
        {
            "step": 2,
            "title": "Taqlid qilish",
            "description": "Pedagog muayyan harakat usulini ko'rsatadi (qanday burash, qadash, o'tkazish), shundan so'ng bola ko'rgan harakatini takrorlaydi."
        },
        {
            "step": 3,
            "title": "Mustaqil bajarish",
            "description": "Bola taklif qilingan amaliy topshiriqni kattalarning doimiy yordamisiz mustaqil ravishda bajaradi."
        },
        {
            "step": 4,
            "title": "Muammoli topshiriq",
            "description": "Bolaga muayyan amaliy muammoni yechish yo'lini topish taklif etiladi («detal sig'mayapti», «qulf burilmayapti»)."
        },
        {
            "step": 5,
            "title": "Ijodiy faoliyat",
            "description": "Bola o'zining shaxsiy o'yinini, yangi qoidasini yoki Sibbord elementlaridan foydalanishning syujetli usulini mustaqil ravishda o'ylab topadi."
        }
    ],
    "algorithm": [
        {"step": 1, "title": "Maqsadni aniqlash", "desc": "Mashg'ulotning aniq rivojlantiruvchi yoki ta'limiy maqsadini shakllantirish."},
        {"step": 2, "title": "Elementlarni tanlash", "desc": "Qo'yilgan maqsad uchun eng samarali Sibbord elementlarini saralab olish."},
        {"step": 3, "title": "Topshiriqni belgilash", "desc": "Bola uchun aniq va tushunarli o'yin yoki amaliy vazifani ifodalash."},
        {"step": 4, "title": "Usulni namoyish qilish", "desc": "Harakat usulini pedagog tomonidan ko'rsatib berish (zarur hollarda)."},
        {"step": 5, "title": "Mustaqil faoliyat", "desc": "Bolaga individual harakat uchun yetarli vaqt va erkinlik berish."},
        {"step": 6, "title": "Pedagogik hamrohlik", "desc": "Bolaning o'rniga bajarmasdan kuzatish, rag'batlantiruvchi savollar berish."},
        {"step": 7, "title": "Natijani tahlil qilish", "desc": "Olingan yakuniy natijani va unga erishish yo'lini birgalikda muhokama qilish."},
        {"step": 8, "title": "Refleksiya", "desc": "Bola o'z harakatlarining muvaffaqiyatini anglaydi, pedagog xulosalarni shakllantiradi."}
    ],
    "algorithm_reminder": "Pedagog nafaqat topshiriq to'g'ri bajarilganini, balki bolaning harakat usulini, mustaqillik darajasini, tashabbuskorligini va natijani tushuntira olishini hisobga olishi kerak.",
    "virtual_elements": [
        {
            "id": "button",
            "name": "Tugma",
            "symbol": "🔘",
            "develops": "Barmoqlar va kaft harakatlari aniqligi, mayda motorika",
            "task": "Mustaqil harakat topshirig'i: ehtiyotkorlik bilan tugmani qada va yechib ko'r."
        },
        {
            "id": "lock",
            "name": "Qulf",
            "symbol": "🔐",
            "develops": "Muammoli vaziyat, tahliliy fikrlash va yechim izlash",
            "task": "Muammoli topshiriq: mos kalitni tanlab ol va burilish yo'nalishini aniqlab qulfni och."
        },
        {
            "id": "geo_shape",
            "name": "Geometrik shakl",
            "symbol": "🔺",
            "develops": "Sensor va matematik tasavvurlar, tasniflash va taqqoslash",
            "task": "Didaktik topshiriq: berilgan shakl va rangdagi detalni top va mos konturga joylashtir."
        },
        {
            "id": "wheel",
            "name": "G'ildirakcha",
            "symbol": "🔄",
            "develops": "Harakat faolligi, koordinatsiya va sabab-oqibat bog'lanishi",
            "task": "Amaliy topshiriq: g'ildirakchani aylantir va harakat boshqa qismlarga qanday o'tishini kuzat."
        },
        {
            "id": "lacing",
            "name": "Shnurovka (bog'ich)",
            "symbol": "🧵",
            "develops": "Mayda motorika, fazoviy mo'ljal va harakatlar ketma-ketligi",
            "task": "Kompleks topshiriq: bog'ichni teshikchalar orqali tartib bilan o'tkaz va tuguncha bog'la."
        }
    ],
    "builder_options": {
        "age_groups": ["3–4 yosh", "4–5 yosh", "5–6 yosh", "6–7 yosh"],
        "directions": [
            "Nutqiy rivojlanish",
            "Elementar matematik tasavvurlar",
            "Tabiat va atrof-olam bilan tanishtirish",
            "Badiiy-ijodiy faoliyat",
            "Konstruktiv faoliyat",
            "Teatrlashtirilgan faoliyat",
            "O'yin faoliyati"
        ],
        "sample_task": {
            "title": "4–5 yoshli bolalar uchun Sibbord asosida rivojlantiruvchi topshiriq loyihalang",
            "age_group": "4–5 yosh",
            "direction": "Elementar matematik tasavvurlar",
            "goal": "Fazoviy mo'ljal, hisoblash va harakatlar ketma-ketligini rivojlantirish",
            "element": "Shnurovka (bog'ich)",
            "content": "Rangli bog'ichni 1 dan 5 gacha raqamlangan teshiklar orqali tartib bilan o'tkaz",
            "child_actions": "Bola raqamlarni baland ovozda aytadi va bog'ichni o'sish tartibida o'tkazadi",
            "pedagogue_questions": "Qaysi raqamdan boshlading? Keyingi raqam qaysi? Bog'ich hozir qayerga yo'nalyapti?",
            "expected_result": "Bog'ich barcha 5 teshikdan to'g'ri o'tkazilgan, bola ketma-ketlikni tushuntira oladi",
            "evaluation_method": "Mustaqillik, to'g'ri hisoblash va harakatlar aniqligini kuzatish orqali baholash"
        }
    }
}

# ----------------- RULES (RU) -----------------
rules_ru = {
    "id": "rules",
    "title": "Правила пользования Сиббордом",
    "cover_image": "assets/images/09_lunge_pose.webp",
    "overview": "Правильная организация работы с Сиббордом является важным условием его безопасного и педагогически эффективного применения в дошкольном образовании. Использование Сибборда должно осуществляться с учётом возраста ребёнка, уровня его развития, индивидуальных возможностей и поставленных образовательных задач.",
    "core_principle": "«Не сделать за ребёнка, а помочь ему сделать самостоятельно»",
    "four_questions": [
        {"question": "Что развиваем?", "desc": "Определяем конкретную способность: мелкая моторика, последовательность действий, речь или логика."},
        {"question": "Что должен сделать ребёнок?", "desc": "Формулируем понятное практическое действие: продеть, открыть, сравнить, подобрать."},
        {"question": "Какой элемент используем?", "desc": "Выбираем подходящий функциональный узел: шнуровка, замок, колёсико или фигура."},
        {"question": "Как определим результат?", "desc": "Критерий успешности: ребёнок самостоятельно выполняет цепочку и может объяснить её словами."}
    ],
    "example_box": {
        "title": "Пример методического планирования",
        "goal": "Развитие мелкой моторики и последовательности действий",
        "element": "Шнуровка",
        "task": "«Продень шнурок через отверстия по порядку»",
        "speech": "«С чего ты начал? Что будешь делать дальше?»",
        "result": "Ребёнок самостоятельно выполняет последовательность действий и может объяснить её."
    },
    "sections": [
        {
            "id": "general_rules",
            "title": "Основные правила работы",
            "items": [
                "Использовать Сибборд только под контролем педагога: на начальном этапе педагог объясняет назначение элементов, маленькие дети не должны оставаться без присмотра.",
                "Учитывать возраст ребёнка: простые и крупные элементы для младших, усложнённые задания для старших дошкольников.",
                "Начинать с простых действий: нажать, повернуть, открыть, соединить; затем переходить к последовательности и решению задач.",
                "Не выполнять задание вместо ребёнка: создавать условия для самостоятельного действия, использовать подсказки и вопросы вместо готового решения.",
                "Формулировать конкретную педагогическую цель: каждое задание направлено на развитие определенного навыка.",
                "Сочетать действие с речевым сопровождением: задавать вопросы («Что делаешь?», «Какой элемент подходит?»), связывая действие с речью.",
                "Постепенно повышать сложность: соблюдать цепочку «знакомство → подражание → самостоятельное действие → проблемная ситуация → творчество».",
                "Предоставлять ребёнку возможность выбора: предлагать самостоятельно выбрать элемент, способ действия или последовательность."
            ]
        },
        {
            "id": "safety_rules",
            "title": "Правила безопасности",
            "items": [
                "Все элементы Сибборда должны быть прочно закреплены.",
                "Поверхность должна быть гладкой, без острых углов и выступающих частей.",
                "Материалы должны быть безопасными и соответствовать возрасту детей.",
                "Мелкие детали нельзя использовать с детьми, которые могут случайно проглотить их.",
                "Необходимо регулярно проверять крепления, замки, кнопки, шнурки и другие подвижные элементы.",
                "Повреждённые или неисправные детали необходимо своевременно заменить.",
                "Во время занятия педагог контролирует правильность использования элементов.",
                "После работы дети должны привести рабочее место в порядок.",
                "Сибборд следует хранить в сухом, чистом и безопасном месте."
            ]
        },
        {
            "id": "support_rules",
            "title": "Правила педагогического сопровождения",
            "items": [
                "Соблюдение принципа: «Не сделать за ребёнка, а помочь ему сделать самостоятельно».",
                "Оптимальная цепочка: постановка цели → объяснение задания → демонстрация (при необходимости) → самостоятельное действие → наблюдение → подсказка → получение результата → обсуждение → рефлексия.",
                "Учёт индивидуального темпа каждого ребёнка без прямого публичного сравнения с другими детьми."
            ]
        },
        {
            "id": "group_rules",
            "title": "Правила организации групповой работы",
            "items": [
                "Распределять роли между детьми при работе в парах и малых группах.",
                "Учить детей договариваться и соблюдать очередность действий.",
                "Предоставлять каждому ребёнку возможность выполнить практическое действие.",
                "Формировать навыки дружелюбного сотрудничества и уважения к действиям товарища.",
                "Обязательно обсуждать общий командный результат после завершения работы."
            ]
        },
        {
            "id": "effective_rules",
            "title": "Правила эффективного использования",
            "items": [
                "Сибборд не должен использоваться как простая развлекательная игрушка — его ценность в методической направленности.",
                "Обязательное проектирование деятельности по 4 ключевым вопросам: Что развиваем? Что делает ребёнок? Какой элемент? Как оценим результат?",
                "Систематичность и осмысленность применения в образовательной программе детского сада."
            ]
        },
        {
            "id": "teacher_role",
            "title": "Роль педагога",
            "items": [
                "Педагог выступает как организатор, консультант, внимательный наблюдатель и развивающий партнёр ребёнка.",
                "Создание проблемных и игровых ситуаций вместо сухих команд.",
                "Стимулирование самостоятельного поиска решений и помощь в рефлексивном осмыслении результатов.",
                "Обязательная связь каждого практического действия с общей образовательной целью."
            ]
        }
    ],
    "checklist": [
        "Прочность и надёжность крепления всех функциональных деталей",
        "Отсутствие сколов, заусенцев, острых кромок и углов",
        "Экологичность и безопасность лакокрасочных покрытий",
        "Соответствие размера деталей возрастной группе детей",
        "Исправность замков, молний, карабинов и подвижных колес",
        "Целостность шнурков, лент и текстильных элементов",
        "Обеспечение постоянного визуального контроля педагогом",
        "Организованность рабочего места и правила порядка",
        "Безопасные условия сухого хранения оборудования"
    ]
}

# ----------------- RULES (UZ) -----------------
rules_uz = {
    "id": "rules",
    "title": "Sibborddan foydalanish qoidalari",
    "cover_image": "assets/images/09_lunge_pose.webp",
    "overview": "Sibbord bilan ishlashni to'g'ri tashkil etish uning maktabgacha ta'limda xavfsiz va pedagogik jihatdan samarali qo'llanilishining muhim shartidir. Sibborddan foydalanish bolaning yoshi, rivojlanish darajasi, individual imkoniyatlari va qo'yilgan ta'lim vazifalarini hisobga olgan holda amalga oshirilishi kerak.",
    "core_principle": "«Bolaning o'rniga bajarmaslik, balki unga mustaqil bajarishga yordam berish»",
    "four_questions": [
        {"question": "Nimani rivojlantiramiz?", "desc": "Aniq qobiliyatni belgilaymiz: mayda motorika, harakatlar ketma-ketligi, nutq yoki mantiq."},
        {"question": "Bola nima qilishi kerak?", "desc": "Tushunarli amaliy harakatni shakllantiramiz: o'tkazish, ochish, taqqoslash, tanlash."},
        {"question": "Qaysi elementdan foydalanamiz?", "desc": "Mos funksional qismni tanlaymiz: shnurovka, qulf, g'ildirakcha yoki shakl."},
        {"question": "Natijani qanday aniqlaymiz?", "desc": "Muvaffaqiyat mezoni: bola mustaqil ravishda zanjirni bajaradi va uni so'z bilan izohlay oladi."}
    ],
    "example_box": {
        "title": "Metodik rejalashtirish namunasi",
        "goal": "Mayda motorika va harakatlar ketma-ketligini rivojlantirish",
        "element": "Shnurovka (bog'ich)",
        "task": "«Bog'ichni teshiklar orqali tartib bilan o'tkaz»",
        "speech": "«Nimadan boshlading? Keyin nima qilasan?»",
        "result": "Bola harakatlar ketma-ketligini mustaqil bajaradi va uni tushuntirib bera oladi."
    },
    "sections": [
        {
            "id": "general_rules",
            "title": "Asosiy ish qoidalari",
            "items": [
                "Sibborddan faqat pedagog nazorati ostida foydalanish: boshlang'ich bosqichda pedagog elementlarning vazifasini tushuntiradi, kichik yoshdagi bolalar qarovsiz qolmasligi kerak.",
                "Bolaning yoshini hisobga olish: kichiklar uchun oddiy va yirik elementlar, katta maktabgacha yoshdagilar uchun murakkablashtirilgan topshiriqlar.",
                "Oddiy harakatlardan boshlash: bosish, burash, ochish, ulash; so'ngra ketma-ketlik va muammolarni yechishga o'tish.",
                "Topshiriqni bolaning o'rniga bajarmaslik: mustaqil harakat uchun sharoit yaratish, tayyor yechim o'rniga maslahat va savollardan foydalanish.",
                "Aniq pedagogik maqsadni belgilash: har bir topshiriq ma'lum bir ko'nikmani rivojlantirishga qaratiladi.",
                "Harakatni nutqiy hamrohlik bilan uyg'unlashtirish: savollar berish («Nima qilyapsan?», «Qaysi detal mos keladi?»), harakatni nutq bilan bog'lash.",
                "Murakkablikni bosqichma-bosqich oshirish: «tanishuv → taqlid → mustaqil harakat → muammoli vaziyat → ijod» zanjiriga rioya qilish.",
                "Bolaga tanlash imkoniyatini berish: elementni, harakat usulini yoki ketma-ketlikni mustaqil tanlashni taklif qilish."
            ]
        },
        {
            "id": "safety_rules",
            "title": "Xavfsizlik qoidalari",
            "items": [
                "Sibbordning barcha elementlari mustahkam mahkamlangan bo'lishi kerak.",
                "Yuzasi silliq, o'tkir burchaklar va turtib chiqqan qismlarsiz bo'lishi shart.",
                "Materiallar xavfsiz va bolalarning yoshiga mos bo'lishi lozim.",
                "Mayda detallarni tasodifan yutib yuborishi mumkin bo'lgan bolalar bilan ishlatish taqiqlanadi.",
                "Mahkamlagichlar, qulflar, tugmalar, bog'ichlar va boshqa harakatlanuvchi qismlarni muntazam tekshirib turish kerak.",
                "Shikastlangan yoki nosoz qismlar o'z vaqtida almashtirilishi lozim.",
                "Mashg'ulot davomida pedagog elementlardan to'g'ri foydalanilayotganini nazorat qiladi.",
                "Ishdan so'ng bolalar ish joyini tartibga keltirishlari kerak.",
                "Sibbord quruq, toza va xavfsiz joyda saqlanishi kerak."
            ]
        },
        {
            "id": "support_rules",
            "title": "Pedagogik hamrohlik qoidalari",
            "items": [
                "«Bolaning o'rniga bajarmaslik, balki unga mustaqil bajarishga yordam berish» tamoyiliga rioya qilish.",
                "Optimal zanjir: maqsad qo'yish → topshiriqni tushuntirish → namoyish qilish (zarur bo'lsa) → mustaqil harakat → kuzatish → yo'naltiruvchi maslahat → natija olish → muhokama → refleksiya.",
                "Har bir bolaning individual sur'atini hisobga olish, boshqa bolalar natijalari bilan ochiq taqqoslamaslik."
            ]
        },
        {
            "id": "group_rules",
            "title": "Guruh ishini tashkil etish qoidalari",
            "items": [
                "Juftlik va kichik guruhlarda ishlaganda bolalar o'rtasida rollarni taqsimlash.",
                "Bolalarni kelishishga va harakatlar navbatiga rioya qilishga o'rgatish.",
                "Har bir bolaga amaliy harakatni bajarish imkoniyatini berish.",
                "Do'stona hamkorlik va tengdoshining harakatlariga hurmat ko'nikmalarini shakllantirish.",
                "Ish yakunlangach, jamoaviy umumiy natijani albatta muhokama qilish."
            ]
        },
        {
            "id": "effective_rules",
            "title": "Samarali foydalanish qoidalari",
            "items": [
                "Sibborddan shunchaki ko'ngilochar o'yinchoq sifatida foydalanmaslik kerak — uning qiymati metodik yo'naltirilganligidadir.",
                "Faoliyatni 4 asosiy savol bo'yicha loyihalash: Nimani rivojlantiramiz? Bola nima qiladi? Qaysi element? Natijani qanday baholaymiz?",
                "Bog'chaning ta'lim dasturida tizimli va ongli ravishda qo'llash."
            ]
        },
        {
            "id": "teacher_role",
            "title": "Pedagogning roli",
            "items": [
                "Pedagog tashkilotchi, maslahatchi, e'tiborli kuzatuvchi va bolaning rivojlantiruvchi hamkori sifatida namoyon bo'ladi.",
                "Quruq buyruqlar o'rniga muammoli va o'yin vaziyatlarini yaratish.",
                "Yechimlarni mustaqil izlashni rag'batlantirish va natijalarni refleksiv anglashga yordam berish.",
                "Har bir amaliy harakatni umumiy ta'limiy maqsad bilan uzviy bog'lash."
            ]
        }
    ],
    "checklist": [
        "Barcha funksional detallarning mustahkam va ishonchli mahkamlanganligi",
        "Yuzada yoriqlar, qipiqlar, o'tkir qirralar va burchaklar yo'qligi",
        "Bo'yoq va lak qoplamalarining ekologik tozaligi va xavfsizligi",
        "Detallar o'lchamining bolalar yosh guruhiga mosligi",
        "Qulflar, molniyalar, karabinlar va harakatlanuvchi g'ildiraklarning sozligi",
        "Bog'ichlar, tasmalar va to'qimachilik elementlarining butunligi",
        "Pedagog tomonidan doimiy ko'rish nazoratining ta'minlanganligi",
        "Ish joyining to'g'ri tashkil etilganligi va tartib qoidalariga rioya qilinishi",
        "Uskunaning quruq va xavfsiz joyda saqlanish sharoitlari"
    ]
}

# Write files
files = {
    'assets/content/ru/home.json': home_ru,
    'assets/content/uz/home.json': home_uz,
    'assets/content/ru/goals.json': goals_ru,
    'assets/content/uz/goals.json': goals_uz,
    'assets/content/ru/capabilities.json': capabilities_ru,
    'assets/content/uz/capabilities.json': capabilities_uz,
    'assets/content/ru/work.json': work_ru,
    'assets/content/uz/work.json': work_uz,
    'assets/content/ru/rules.json': rules_ru,
    'assets/content/uz/rules.json': rules_uz,
}

for path, data in files.items():
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f'Wrote {path} ({os.path.getsize(path)} bytes)')

print('All 10 content JSON files successfully generated!')
