import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../stores/user_store.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Observer(
                builder: (_) => TextFormField(
                  controller: _loginController,
                  decoration: const InputDecoration(
                    labelText: 'Логин',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: userStore.setLogin,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите логин';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) => TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: userStore.setPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) {
                  if (userStore.errorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        userStore.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Observer(
                builder: (_) => ElevatedButton(
                  onPressed: userStore.isLoading ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await userStore.loginUser();
                      if (success) {
                        context.go('/main');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: userStore.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Войти'),
                ),
              ),
              const SizedBox(height: 10),
              Observer(
                builder: (_) => OutlinedButton(
                  onPressed: userStore.isLoading
                      ? null
                      : () {
                    userStore.clear();
                    context.push('/registration');
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Зарегистрироваться'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}