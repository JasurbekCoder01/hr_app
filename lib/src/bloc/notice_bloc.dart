import 'package:hr_app/src/api/repository.dart';
import 'package:hr_app/src/jsons/notice_json.dart';
import 'package:hr_app/src/model/notice_model.dart';
import 'package:rxdart/rxdart.dart';

class NoticeBloc {
  Repository repository = Repository();
  final _noticeFetch = PublishSubject<NoticeModel>();

  Stream<NoticeModel> get allNotice => _noticeFetch.stream;

  getAllNotice() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        NoticeModel data = NoticeModel.fromJson(
          noticeJson,
        );
        _noticeFetch.sink.add(data);
      },
    );
  }
}
final noticeBloc = NoticeBloc();
