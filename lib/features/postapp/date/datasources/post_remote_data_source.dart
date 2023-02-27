import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  /// calls the https://jsonplaceholder.typicode.com/ endpoint
  ///
  /// Throws a [ServerException] for all error codes
  ///
  Future<List<PostModel>> getPostList();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPostList() async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'posts');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return PostModel.listPostModel(response.body);
    } else {
      throw ServerException();
    }
  }
}
