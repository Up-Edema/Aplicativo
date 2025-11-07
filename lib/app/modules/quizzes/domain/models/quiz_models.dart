class OptionModel {
  final String id;
  final String text;
  final String? emoji;
  final int? value;

  const OptionModel({
    required this.id,
    required this.text,
    this.emoji,
    this.value,
  });

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      id: map['id'] as String,
      text: map['text'] ?? '',
      emoji: map['emoji'] as String?,
      value: map['value'] as int?,
    );
  }
}

class QuestionModel {
  final String id;
  final String formId;
  final String title;
  final String type;
  final bool allowMultiple;
  final int orderIndex;
  final List<OptionModel> options;

  const QuestionModel({
    required this.id,
    required this.formId,
    required this.title,
    required this.type,
    required this.allowMultiple,
    required this.orderIndex,
    required this.options,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> rawOptions =
        (map['options'] as List<dynamic>?) ?? const [];

    final optionsList = rawOptions
        .map(
          (optionJson) =>
              OptionModel.fromMap(optionJson as Map<String, dynamic>),
        )
        .toList();

    return QuestionModel(
      id: map['id'] as String,
      formId: map['form_id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      allowMultiple: map['allow_multiple'] as bool,
      orderIndex: map['order_index'] as int,
      options: optionsList,
    );
  }
}

class FormModel {
  final String id;
  final String title;
  final String? subtitle;
  final String status;
  final String? category;

  const FormModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.status,
    this.category,
  });

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      id: map['id'] as String,
      title: map['title'] ?? '',
      status: map['status'] as String,
      subtitle: map['subtitle'] as String?,
      category: map['category'] as String?,
    );
  }
}

class QuizModel {
  final FormModel form;
  final List<QuestionModel> questions;

  const QuizModel({required this.form, required this.questions});

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    final form = FormModel.fromMap(map);

    final List<dynamic> rawQuestions =
        (map['questions'] as List<dynamic>?) ?? const [];

    final questionsList = rawQuestions
        .map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
        .toList();

    return QuizModel(form: form, questions: questionsList);
  }
}
