import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'stores/main_store.dart';
import 'stores/user_store.dart';
import 'stores/products_store.dart';
import 'stores/documents_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserStore>(create: (_) => UserStore()),
        Provider<MainStore>(create: (_) => MainStore()),
        Provider<ProductsStore>(create: (_) => ProductsStore()),
        Provider<DocumentStore>(create: (_) => DocumentStore())
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Складской учёт',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            routerConfig: AppRouter().router,
          );
        },
      ),
    );
  }
}