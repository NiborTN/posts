import 'package:posts/features/postapp/date/models/album_model.dart';
import 'package:posts/features/postapp/date/models/comments_model.dart';
import 'package:posts/features/postapp/date/models/photo_model.dart';
import 'package:posts/features/postapp/date/models/post_model.dart';
import 'package:posts/features/postapp/date/models/user_model.dart';

const photoModel = [PhotoModel(albumId: 1, id: 1, image: 'test')];
const commnetsModel = [
  CommentsModel(postId: 1, id: 1, name: 'test', body: 'test')
];
var albumModel = AlbumModel(userId: 1, id: 1, title: 'test');
var postModel = PostModel(userId: 1, id: 1, title: 'test', body: 'test');
const userModel = UserModel(id: 1, userName: 'test');
