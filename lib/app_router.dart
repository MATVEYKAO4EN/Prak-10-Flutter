import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/user/authorization_screen.dart';
import 'screens/user/registration_screen.dart';
import 'screens/user/profile_screen.dart';
import 'screens/main/main_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/documents/documents_screen.dart';
import 'screens/info/info_screen.dart';
import 'screens/logs/logs_screen.dart';
import 'screens/products/products_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/authorization',
    routes: [
      GoRoute(
        path: '/authorization',
        name: 'authorization',
        builder: (context, state) => const AuthorizationScreen(),
      ),
      GoRoute(
        path: '/registration',
        name: 'registration',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/documents',
        name: 'documents',
        builder: (context, state) => const DocumentScreen(),
      ),
      GoRoute(
        path: '/info',
        name: 'info',
        builder: (context, state) => const InfoScreen(),
      ),
      GoRoute(
        path: '/logs',
        name: 'logs',
        builder: (context, state) => const LogsScreen(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],
  );
}