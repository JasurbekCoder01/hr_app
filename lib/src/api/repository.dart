import 'package:hr_app/src/model/http_result.dart';

import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProver();

  Future<HttpResult> getAllBalance() => apiProvider.getAllBalance();

  Future<HttpResult> getAllHoliday() => apiProvider.getAllHoliday();

  Future<HttpResult> getLeaves() => apiProvider.getLeaves();

  Future<HttpResult> getAllFeedback() => apiProvider.getAllFeedback();

  Future<HttpResult> loginApi(String id, String password) =>
      apiProvider.setLogin(id, password);
}
