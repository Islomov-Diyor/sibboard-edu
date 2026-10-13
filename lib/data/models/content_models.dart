import 'package:flutter/foundation.dart';

@immutable
class Section {
  final String id;
  final String title;
  final String? subtitle;
  final String? image;
  final List<Block> blocks;

  const Section({
    required this.id,
    required this.title,
    this.subtitle,
    this.image,
    required this.blocks,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      image: json['image'] as String?,
      blocks: (json['blocks'] as List<dynamic>?)
              ?.map((e) => Block.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'image': image,
        'blocks': blocks.map((e) => e.toJson()).toList(),
      };
}

@immutable
sealed class Block {
  const Block();

  factory Block.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    switch (type) {
      case 'paragraph':
        return ParagraphBlock.fromJson(json);
      case 'bullets':
        return BulletsBlock.fromJson(json);
      case 'quote':
        return QuoteBlock.fromJson(json);
      case 'steps':
        return StepsBlock.fromJson(json);
      default:
        return ParagraphBlock(text: json['text']?.toString() ?? '');
    }
  }

  Map<String, dynamic> toJson();
}

@immutable
class ParagraphBlock extends Block {
  final String text;

  const ParagraphBlock({required this.text});

  factory ParagraphBlock.fromJson(Map<String, dynamic> json) {
    return ParagraphBlock(text: json['text'] as String);
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': 'paragraph',
        'text': text,
      };
}

@immutable
class BulletsBlock extends Block {
  final List<String> items;

  const BulletsBlock({required this.items});

  factory BulletsBlock.fromJson(Map<String, dynamic> json) {
    return BulletsBlock(
      items: (json['items'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': 'bullets',
        'items': items,
      };
}

@immutable
class QuoteBlock extends Block {
  final String text;

  const QuoteBlock({required this.text});

  factory QuoteBlock.fromJson(Map<String, dynamic> json) {
    return QuoteBlock(text: json['text'] as String);
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': 'quote',
        'text': text,
      };
}

@immutable
class StepItem {
  final int step;
  final String title;
  final String description;

  const StepItem({
    required this.step,
    required this.title,
    required this.description,
  });

  factory StepItem.fromJson(Map<String, dynamic> json) {
    return StepItem(
      step: json['step'] as int? ?? 1,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'step': step,
        'title': title,
        'description': description,
      };
}

@immutable
class StepsBlock extends Block {
  final List<StepItem> steps;

  const StepsBlock({required this.steps});

  factory StepsBlock.fromJson(Map<String, dynamic> json) {
    return StepsBlock(
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': 'steps',
        'steps': steps.map((e) => e.toJson()).toList(),
      };
}

@immutable
class CardItem {
  final int no;
  final String title;
  final String develops;
  final String? image;
  final String? back;

  const CardItem({
    required this.no,
    required this.title,
    required this.develops,
    this.image,
    this.back,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      no: json['no'] as int,
      title: json['title'] as String,
      develops: json['develops'] as String,
      image: json['image'] as String?,
      back: json['back'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'no': no,
        'title': title,
        'develops': develops,
        'image': image,
        'back': back,
      };
}

@immutable
class BoardElement {
  final String id;
  final String name;
  final String develops;
  final String task;

  const BoardElement({
    required this.id,
    required this.name,
    required this.develops,
    required this.task,
  });

  factory BoardElement.fromJson(Map<String, dynamic> json) {
    return BoardElement(
      id: json['id'] as String,
      name: json['name'] as String,
      develops: json['develops'] as String,
      task: json['task'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'develops': develops,
        'task': task,
      };
}
