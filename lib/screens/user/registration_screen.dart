import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../stores/user_store.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация')
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
                    if (value.length < 6) {
                      return 'Пароль должен быть не менее 6 символов';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) => TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Подтвердите пароль',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: userStore.setConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Подтвердите пароль';
                    }
                    if (value != userStore.password) {
                      return 'Пароли не совпадают';
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
                      final success = await userStore.register();
                      if (success) {
                        userStore.clear();
                        context.go('/main');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: userStore.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Создать аккаунт'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}