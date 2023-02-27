import 'package:posts/features/postapp/domain/entities/album.dart';
import 'package:posts/features/postapp/domain/entities/comment.dart';
import 'package:posts/features/postapp/domain/entities/photo.dart';
import 'package:posts/features/postapp/domain/entities/posts.dart';
import 'package:posts/features/postapp/domain/entities/user.dart';

Photo photos = const Photo(albumId: 1, id: 1, image: "test");
List<Photo> photoList = [photos];
Album album = Album(userId: 1, id: 1, title: "test");
Comments comment = const Comments(postId: 1, id: 1, name: 'test', body: "test");
List<Comments> commentsList = [comment];
Post post = Post(userId: 1, id: 1, title: "test", body: "test");
List<Album> albumList = [album];
List<Post> postList = [post];

User user = const User(id: 1, userName: "test");
