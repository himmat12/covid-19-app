import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FAQ {
  String lang;
  String question;
  String answer;
  String question_np;
  String answer_np;
  String category;

  FAQ({
    this.lang,
    this.question,
    this.answer,
    this.question_np,
    this.answer_np,
    this.category,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) => _$FAQFromJson(json);
}
