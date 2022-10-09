import 'package:bloc_rest_api/bloc/user_bloc.dart';
import 'package:bloc_rest_api/bloc/user_event.dart';
import 'package:bloc_rest_api/bloc/user_state.dart';
import 'package:bloc_rest_api/model/user_model.dart';
import 'package:bloc_rest_api/repos/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BLoC Rest Api"),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserLoadedState) {
            List<UserModel> userList = state.users;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue,
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        "${userList[index].firstName}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "${userList[index].lastName}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                });
          }

          if (state is UserErrorState) {
            return const Center(
              child: Text("error"),
            );
          }

          return Container();
        }),
      ),
    );
  }
}
