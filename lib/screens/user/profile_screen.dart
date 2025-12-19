import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../stores/user_store.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удаление аккаунта'),
        content: const Text('Вы уверены, что хотите удалить аккаунт? Это действие нельзя отменить.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Удалить',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      final userStore = Provider.of<UserStore>(context, listen: false);
      await userStore.deleteAccount();
      context.go('/authorization');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль')
      ),
      body: Observer(
        builder: (_) {
          if (userStore.currentUser == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = userStore.currentUser!;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Аватар и информация
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          user.login,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (user.registrationDate != null)
                          Text(
                            'Зарегистрирован: ${user.registrationDate!.day}.${user.registrationDate!.month}.${user.registrationDate!.year}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Кнопка выхода
                ElevatedButton.icon(
                  onPressed: () {
                    userStore.clear();
                    context.go('/authorization');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.orange,
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Выйти из аккаунта',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 15),

                // Кнопка удаления аккаунта
                ElevatedButton.icon(
                  onPressed: userStore.isLoading
                      ? null
                      : () => _showDeleteConfirmation(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: userStore.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Icon(Icons.delete),
                  label: const Text(
                    'Удалить аккаунт',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const Spacer(),

                // Информация
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Информация о профиле',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Здесь вы можете управлять данными своего аккаунта. '
                            'Удаление аккаунта приведет к безвозвратной потере всех данных.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}