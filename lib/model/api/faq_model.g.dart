// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQ _$FAQFromJson(Map<String, dynamic> json) {
  return FAQ(
    lang: json['lang'] as String,
    question: json['question'] as String,
    answer: json['answer'] as String,
    question_np: json['question_np'] as String,
    answer_np: json['answer_np'] as String,
    category: json['category'] as String,
  );
}

Map<String, dynamic> _$FAQToJson(FAQ instance) => <String, dynamic>{
      'lang': instance.lang,
      'question': instance.question,
      'answer': instance.answer,
      'question_np': instance.question_np,
      'answer_np': instance.answer_np,
      'category': instance.category,
    };
