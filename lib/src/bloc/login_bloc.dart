import 'dart:convert';

import 'package:hr_app/src/api/repository.dart';
import 'package:hr_app/src/jsons/home_jsons.dart';
import 'package:hr_app/src/model/http_result.dart';
import 'package:hr_app/src/model/login_model/home_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final Repository _repository = Repository();

  final _homeFetch = PublishSubject<HomeModel>();

  Stream<HomeModel> get getHome => _homeFetch.stream;

  getAllItem(String id, String password) async {
    //HttpResult response = await _repository.loginApi(id, password);
    // if (response.isSuccess) {
    //   List<HomeModel> data = homeModelFromJson(
    //     json.encode(response.result),
    //   );
    List<HomeModel> data = homeModelFromJson(
      json.encode(homeJson),
    );
    for (int i = 0; i < data.length; i++) {
      _homeFetch.sink.add(data[i]);
    }
    // }
  }
}

final homeBloc = HomeBloc();
