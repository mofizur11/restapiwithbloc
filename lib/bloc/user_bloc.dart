import 'package:bloc_rest_api/bloc/user_event.dart';
import 'package:bloc_rest_api/bloc/user_state.dart';
import 'package:bloc_rest_api/repos/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  final UserRepository _userRepository;


  UserBloc(this._userRepository) : super(UserLoadingState()){
    on<LoadUserEvent>((event, emit) async{
      emit(UserLoadingState());
      print("Emitted the first state");
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch(e){
        emit(UserErrorState(e.toString()));
      }

      print("Emitted the second state");
    });
  }
}