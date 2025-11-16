import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final senha = TextEditingController();
  String? erro;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "E-mail"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: senha,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            if (erro != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  erro!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final msg = await auth.login(email.text, senha.text);

                if (msg != null) {
                  setState(() => erro = msg);
                } else {
                  if (!mounted) return;
                  Navigator.of(context).pushReplacementNamed("/home");
                }
              },
              child: const Text("Entrar"),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/register"),
              child: const Text("Criar conta"),
            ),
          ],
        ),
      ),
    );
  }
}
