import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:test/test.dart';

@GenerateMocks([InternetConnectionChecker])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('is connected', () {
    test(
      'Should forward the call to the InternetConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = networkInfoImpl.isConnected;
        // assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
