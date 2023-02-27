import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/postapp/date/datasources/album_local_data_source.dart';
import 'package:posts/features/postapp/date/datasources/album_remote_data_source.dart';
import 'package:posts/features/postapp/date/repository/album_repository_impl.dart';
import 'package:posts/features/postapp/domain/repositories/album_repository.dart';
import 'package:posts/features/postapp/domain/usescases/get_album_list.dart';
import 'package:posts/features/postapp/domain/usescases/get_comment_list.dart';
import 'package:posts/features/postapp/domain/usescases/get_photo_list.dart';
import 'package:posts/features/postapp/domain/usescases/get_post_list.dart';
import 'package:posts/features/postapp/domain/usescases/get_user.dart';
import 'package:posts/features/postapp/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:posts/features/postapp/presentation/bloc/comment_bloc/comment_bloc.dart';
import 'package:posts/features/postapp/presentation/bloc/photo_bloc/photo_bloc.dart';
import 'package:posts/features/postapp/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:posts/features/postapp/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/postapp/date/datasources/comment_local_data_source.dart';
import 'features/postapp/date/datasources/comment_remote_data_source.dart';
import 'features/postapp/date/datasources/photo_local_data_source.dart';
import 'features/postapp/date/datasources/photo_remote_data_source.dart';
import 'features/postapp/date/datasources/post_local_data_source.dart';
import 'features/postapp/date/datasources/post_remote_data_source.dart';
import 'features/postapp/date/datasources/user_local_data_source.dart';
import 'features/postapp/date/datasources/user_remote_data_source.dart';
import 'features/postapp/date/repository/comment_repository_impl.dart';
import 'features/postapp/date/repository/photo_repository_impl.dart';
import 'features/postapp/date/repository/post_repository_impl.dart';
import 'features/postapp/date/repository/user_repository_impl_test.dart';
import 'features/postapp/domain/repositories/comment_repository.dart';
import 'features/postapp/domain/repositories/photo_repository.dart';
import 'features/postapp/domain/repositories/post_repository.dart';
import 'features/postapp/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

@override
Future<void> init() async {
  //! Features - Album
  //Bloc
  //album
  sl.registerFactory<AlbumBloc>(() => AlbumBloc(getAlbumList: sl()));
  //post
  sl.registerFactory<PostBloc>(() => PostBloc(getPostList: sl()));
  //photo
  sl.registerFactory<PhotoBloc>(() => PhotoBloc(getPhotoList: sl()));
  //comment
  sl.registerFactory<CommentBloc>(() => CommentBloc(getCommentList: sl()));
  //user
  sl.registerFactory<UserBloc>(() => UserBloc(getUser: sl(), userId: sl()));

  //Use cases
  //album
  sl.registerLazySingleton(() => GetAlbumList(sl()));
  //post
  sl.registerLazySingleton(() => GetPostList(sl()));
  //photo
  sl.registerLazySingleton(() => GetPhotoList(sl()));
  //comment
  sl.registerLazySingleton(() => GetCommentList(sl()));
  //user
  sl.registerLazySingleton(() => GetUser(sl()));

  //presentation

  //repository
  //album
  sl.registerLazySingleton<AlbumRepository>(() => AlbumRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //post
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //photo
  sl.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //comment
  sl.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //user
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //data source
  //Album
  sl.registerLazySingleton<AlbumRemoteDataSource>(
      () => AlbumRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AlbumLocalDataSource>(
      () => AlbumLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(
      //post
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));
  //photo
  sl.registerLazySingleton<PhotoRemoteDataSource>(
      () => PhotoRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PhotoLocalDataSource>(
      () => PhotoLocalDataSourceImpl(sharedPreferences: sl()));
  //comment
  sl.registerLazySingleton<CommentRemoteDataSource>(
      () => CommentRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CommentLocalDataSource>(
      () => CommentLocalDataSourceImpl(sharedPreferences: sl()));
  //User
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //!external
  sl.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
