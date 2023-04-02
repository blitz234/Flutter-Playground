import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String? id;
  String? title;
  String? imageUrl;
  String? description;
  int? timeSeconds;
  List<Questions>? questions;
  int? questionCount;

  QuestionPaperModel(
      {this.id,
      this.title,
      this.imageUrl,
      this.description,
      this.timeSeconds,
      this.questions,
      this.questionCount});

  QuestionPaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    title = json['title'] as String;
    imageUrl = json['image_url'] as String;
    description = json['Description'] as String;
    timeSeconds = json['time_seconds'];
    questionCount = 0;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json['title'];
    imageUrl = json['image_url'];
    description = json['description'];
    timeSeconds = json['time_seconds'];
    questionCount = json['questions_count'] as int;
    questions = [];
  }
  String timeInMinutes() => '${(timeSeconds! / 60).ceil()} mins';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = this.imageUrl;
    data['Description'] = this.description;
    data['time_seconds'] = this.timeSeconds;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  String? question;
  List<Answers>? answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions({this.id, this.question, this.answers, this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
    correctAnswer = json['correct_answer'];
  }
  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['question'] = this.question;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    answer = json['Answer'];
  }

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    identifier = json['identifier'] as String?;
    answer = json['answer'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['Answer'] = this.answer;
    return data;
  }
}
