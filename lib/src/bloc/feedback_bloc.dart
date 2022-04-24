import 'dart:convert';

import 'package:hr_app/src/api/repository.dart';
import 'package:hr_app/src/jsons/feedback_json.dart';
import 'package:hr_app/src/model/feedback_model/feedback_model.dart';
import 'package:hr_app/src/model/http_result.dart';
import 'package:rxdart/rxdart.dart';

class FeedbackBloc {
  final Repository _repository = Repository();

  final _feedbackFetch = PublishSubject<FeedbackModel>();

  Stream<FeedbackModel> get getAllFeedback => _feedbackFetch.stream;

  getFeedback() async {
    //HttpResult response = await _repository.getAllFeedback();
    // if (response.isSuccess) {
    //   FeedbackModel data = feedbackModelFromJson(
    //     json.encode(response.result),
    //   );

    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        FeedbackModel data = FeedbackModel.fromJson(
          feedbackJson,
        );
        _feedbackFetch.sink.add(data);
      },
    );

    //}
  }
}

final feedbackBloc = FeedbackBloc();
