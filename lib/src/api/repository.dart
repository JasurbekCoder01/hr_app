import 'package:hr_app/src/model/http_result.dart';

import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProver();

  Future<HttpResult> getAllBalance() => apiProvider.getAllBalance();


}