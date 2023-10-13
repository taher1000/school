import 'package:equatable/equatable.dart';

import '../../data/models/question_choice.dart';

class Choice extends Equatable {
  final String questionChoiceId;
  final String text;

  const Choice({
    required this.questionChoiceId,
    required this.text,
  });

  ChoiceModel toModel() => ChoiceModel(
        questionChoiceId: questionChoiceId,
        text: text,
      );

  @override
  List<Object?> get props => [
        questionChoiceId,
        text,
      ];
}
