import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SIBBOARD EDU - Content & Assets Verification Tests', () {
    final sections = ['home', 'goals', 'capabilities', 'work', 'rules'];

    test('All JSON content files exist and are valid JSON', () {
      for (final sec in sections) {
        final ruFile = File('assets/content/ru/$sec.json');
        final uzFile = File('assets/content/uz/$sec.json');

        expect(ruFile.existsSync(), isTrue, reason: 'Missing assets/content/ru/$sec.json');
        expect(uzFile.existsSync(), isTrue, reason: 'Missing assets/content/uz/$sec.json');

        final ruData = jsonDecode(ruFile.readAsStringSync()) as Map<String, dynamic>;
        final uzData = jsonDecode(uzFile.readAsStringSync()) as Map<String, dynamic>;

        // Verify root IDs match between languages
        expect(ruData['id'], equals(sec));
        expect(uzData['id'], equals(sec));
      }
    });

    test('Capabilities cards have matching counts and numbers', () {
      final ru = jsonDecode(File('assets/content/ru/capabilities.json').readAsStringSync());
      final uz = jsonDecode(File('assets/content/uz/capabilities.json').readAsStringSync());

      final ruCards = (ru['cards'] as List<dynamic>).cast<Map<String, dynamic>>();
      final uzCards = (uz['cards'] as List<dynamic>).cast<Map<String, dynamic>>();

      expect(ruCards.length, equals(10));
      expect(uzCards.length, equals(10));

      for (var i = 0; i < 10; i++) {
        expect(ruCards[i]['no'], equals(uzCards[i]['no']));
        expect(ruCards[i]['no'], equals(i + 1));
      }
    });

    test('Work topics have matching counts and numbers', () {
      final ru = jsonDecode(File('assets/content/ru/work.json').readAsStringSync());
      final uz = jsonDecode(File('assets/content/uz/work.json').readAsStringSync());

      final ruTopics = (ru['topics'] as List<dynamic>).cast<Map<String, dynamic>>();
      final uzTopics = (uz['topics'] as List<dynamic>).cast<Map<String, dynamic>>();

      expect(ruTopics.length, equals(11));
      expect(uzTopics.length, equals(11));

      for (var i = 0; i < 11; i++) {
        expect(ruTopics[i]['no'], equals(uzTopics[i]['no']));
      }
    });

    test('Virtual board elements have matching IDs', () {
      final ru = jsonDecode(File('assets/content/ru/work.json').readAsStringSync());
      final uz = jsonDecode(File('assets/content/uz/work.json').readAsStringSync());

      final ruElements = (ru['virtual_elements'] as List<dynamic>).cast<Map<String, dynamic>>();
      final uzElements = (uz['virtual_elements'] as List<dynamic>).cast<Map<String, dynamic>>();

      expect(ruElements.length, equals(5));
      expect(uzElements.length, equals(5));

      final expectedIds = ['button', 'lock', 'geo_shape', 'wheel', 'lacing'];
      for (var i = 0; i < 5; i++) {
        expect(ruElements[i]['id'], equals(expectedIds[i]));
        expect(uzElements[i]['id'], equals(expectedIds[i]));
      }
    });

    test('All 16 WebP images exist and are under 250 KB each', () {
      final imageNames = [
        '01_board_logo_front',
        '02_board_side_view_1',
        '03_board_side_view_2',
        '04_cork_board',
        '05_group_lesson_hall',
        '06_kids_home_play',
        '07_pair_balance',
        '08_tree_pose',
        '09_lunge_pose',
        '10_pair_exercise',
        '11_child_on_board',
        '12_boy_sticks',
        '13_problem_solving',
        '14_individual_lying',
        '15_pair_lying',
        '16_group_hall'
      ];

      for (final name in imageNames) {
        final imgFile = File('assets/images/$name.webp');
        expect(imgFile.existsSync(), isTrue, reason: 'Image missing: $name.webp');
        final sizeKb = imgFile.lengthSync() / 1024.0;
        expect(sizeKb, lessThanOrEqualTo(250.0),
            reason: '$name.webp is larger than 250 KB ($sizeKb KB)');
      }
    });

    test('Nunito font file exists and is valid', () {
      final fontFile = File('assets/fonts/Nunito.ttf');
      expect(fontFile.existsSync(), isTrue);
      expect(fontFile.lengthSync(), greaterThan(10000));
    });

    test('Author JSON content and photo are valid and verified', () {
      final ruFile = File('assets/content/ru/author.json');
      final uzFile = File('assets/content/uz/author.json');
      expect(ruFile.existsSync(), isTrue);
      expect(uzFile.existsSync(), isTrue);

      final ruData = jsonDecode(ruFile.readAsStringSync()) as Map<String, dynamic>;
      final uzData = jsonDecode(uzFile.readAsStringSync()) as Map<String, dynamic>;

      expect(ruData['id'], equals('author'));
      expect(uzData['id'], equals('author'));
      expect(ruData['orcid'], equals('0009-0004-1667-2538'));
      expect(uzData['orcid'], equals('0009-0004-1667-2538'));

      final photo = File('assets/images/author_farangiz.jpg');
      expect(photo.existsSync(), isTrue);
      expect(photo.lengthSync() / 1024.0, lessThanOrEqualTo(250.0));
    });
  });
}

