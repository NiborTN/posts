import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/features/postapp/domain/usescases/get_user.dart';
import '../../../../../core/usescases/usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../presentation/bloc/map_to_faliure.dart' as fail;
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  final int userId;

  UserBloc({required this.getUser, required this.userId})
      : super(const UserLoading()) {
    on<LoadUser>((event, emit) async {
      emit(const UserLoading());
      final faliureOruser = await getUser(Params(id: userId));
      emit(faliureOruser.fold(
          (faliure) => Error(message: fail.mapFailureToMessage(faliure)),
          (user) => UserLoaded(user: user)));
    });
  }
}
