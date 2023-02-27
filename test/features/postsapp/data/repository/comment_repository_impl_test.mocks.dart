// Mocks generated by Mockito 5.3.2 from annotations
// in posts/test/features/postsapp/date/repository/comment_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:posts/core/network/network_info.dart' as _i6;
import 'package:posts/features/postapp/date/datasources/comment_local_data_source.dart'
    as _i5;
import 'package:posts/features/postapp/date/datasources/comment_remote_data_source.dart'
    as _i2;
import 'package:posts/features/postapp/date/models/comments_model.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CommentRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommentRemoteDataSource extends _i1.Mock
    implements _i2.CommentRemoteDataSource {
  MockCommentRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.CommentsModel>> getCommentList(dynamic postId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCommentList,
          [postId],
        ),
        returnValue:
            _i3.Future<List<_i4.CommentsModel>>.value(<_i4.CommentsModel>[]),
      ) as _i3.Future<List<_i4.CommentsModel>>);
}

/// A class which mocks [CommentLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommentLocalDataSource extends _i1.Mock
    implements _i5.CommentLocalDataSource {
  MockCommentLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.CommentsModel>> getLastCommentList() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLastCommentList,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.CommentsModel>>.value(<_i4.CommentsModel>[]),
      ) as _i3.Future<List<_i4.CommentsModel>>);
  @override
  _i3.Future<void> cacheCommentList(List<_i4.CommentsModel>? commentToCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheCommentList,
          [commentToCache],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
