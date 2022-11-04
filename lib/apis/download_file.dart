import 'package:dio/dio.dart';

var dio = Dio();

download(String url) async {
  final response = await dio.download(url, 'Download/episodes');
  if (response.statusCode == 200) {
    print('Success!');
  } else {
    throw Exception('Download error!');
  }
}
