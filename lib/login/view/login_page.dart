import 'package:flexmail_app/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBLoC(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = TextEditingController();
    final accessToken = TextEditingController();
    context.read<LoginBLoC>().add(UserLoggedInEvent());
    return BlocListener<LoginBLoC, MyState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.of(context).pushNamed('/contacts');
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login'),
                TextField(
                  controller: username,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                TextField(
                  controller: accessToken,
                  decoration: const InputDecoration(
                    hintText: 'Access Token',
                  ),
                ),
                MaterialButton(
                  onPressed: () => BlocProvider.of<LoginBLoC>(context).add(
                    LoginEvent(
                      username: username.text,
                      accessToken: accessToken.text,
                    ),
                  ),
                  child: const Text('login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
