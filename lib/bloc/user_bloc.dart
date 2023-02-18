import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_test/model/user-model.dart';
import 'package:practical_test/resources/user-repository.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetUserData>((event, emit) async {
      try {
        emit(UserLoading());
        final mList = await _userRepository.fetchUserData();
        emit(UserLoaded(mList));
      } on NetworkError {
        emit(const UserError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
