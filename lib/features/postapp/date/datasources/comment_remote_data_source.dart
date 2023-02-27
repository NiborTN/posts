import '../../../../core/error/exceptions.dart';
import '../models/comments_model.dart';
import 'package:http/http.dart' as http;

abstract class CommentRemoteDataSource {
  /// calls the https://jsonplaceholder.typicode.com/ endpoint
  ///
  /// Throws a [ServerException] for all error codes
  ///

  Future<List<CommentsModel>> getCommentList(postId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final http.Client client;

  CommentRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CommentsModel>> getCommentList(postId) async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'comments',
        {'postId': postId.toString()});
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return CommentsModel.listcommentsModel(response.body);
    } else {
      throw ServerException();
    }
  }
}
