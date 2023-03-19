import 'package:http/http.dart';
import 'package:sample/globle_files/constants/constant_values.dart';
import 'package:sample/globle_files/network/exceptions.dart';
import 'package:sample/globle_files/utils/helper.dart';

class NetworkRequests {
  static final NetworkRequests _singleton = NetworkRequests._internal();

  factory NetworkRequests() {
    return _singleton;
  }

  NetworkRequests._internal();

  Future<Response> getRequest({required String endPointUrl}) async {
    try {
      final url = Uri.parse(baseUrl+endPointUrl);
      final response = await get(url);
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        String message = "Client error occurred while making request : ${response.reasonPhrase}";
        errorLog(endPointUrl, message: response.reasonPhrase, statusCode: response.statusCode);
        throw ClientException(message);
      } else if (response.statusCode >= 500 && response.statusCode <= 599)  {
        String message = "Server error occurred while making request: ${response.reasonPhrase}";
        errorLog(endPointUrl, message: response.reasonPhrase, statusCode: response.statusCode);
        throw ServerException(message);
      }
      else {
        String message = "Unknown error occurred while making request: ${response.reasonPhrase}";
        errorLog(endPointUrl, message: response.reasonPhrase, statusCode: response.statusCode);
        throw UnknownException(message);
      }
    } on Exception catch (exception) {
      errorLog(endPointUrl, message: exception.toString());
      throw UnknownException(exception.toString());
    }
  }
}
