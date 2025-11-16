import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmar = TextEditingController();
  String? erro;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthRepository>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
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
            const SizedBox(height: 16),
            TextField(
              controller: confirmar,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirmar senha"),
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
                if (senha.text != confirmar.text) {
                  setState(() => erro = "As senhas não coincidem");
                  return;
                }

                final msg = await auth.register(email.text, senha.text);

                if (!mounted) return;

                setState(() => erro = msg);

                if (msg == null) {
                  Navigator.pushReplacementNamed(context, "/home");
                }

              },
              child: const Text("Cadastrar"),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"),
              child: const Text("Já tenho conta"),
            ),
          ],
        ),
      ),
    );
  }
}
