import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/apptheme.dart';
import 'firebase_options.dart';
import 'data/repositories/auth.dart';
import 'pages/auth/login.dart';
import 'pages/auth/register.dart';
import 'pages/home/home.dart';
import 'data/repositories/veiculos_repository.dart';
import 'data/repositories/abastecimentos_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthRepository()),

            Provider<AbastecimentosRepository>(
              create: (_) => AbastecimentosRepository(),
            ),

            if (user != null)
              Provider<VeiculosRepository>(create: (_) => VeiculosRepository()),
          ],
          child: MaterialApp(
            title: "Meu App",
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            home: _buildHome(snapshot),
            routes: {
              '/login': (_) => const LoginPage(),
              '/register': (_) => const RegisterPage(),
              '/home': (_) => const HomePage(),
            },
          ),
        );
      },
    );
  }

  Widget _buildHome(AsyncSnapshot<User?> snap) {
    if (snap.connectionState == ConnectionState.waiting) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (snap.hasData) {
      return const HomePage();
    }

    return const LoginPage();
  }
}
