// ignore: constant_identifier_names
import '../../../../core/error/faliures.dart';

const String SERVER_FALIURE_MESSAGE = 'server faliure';
// ignore: constant_identifier_names
const String CACHE_FALIURE_MESSAGE = 'cache faliure';

String mapFailureToMessage(Faliure faliure) {
  switch (faliure.runtimeType) {
    case ServerFaliure:
      return SERVER_FALIURE_MESSAGE;
    case CacheFaliure:
      return CACHE_FALIURE_MESSAGE;
    default:
      return 'UNEXPRECTED_ERROR';
  }
}
