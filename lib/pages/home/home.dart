import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth.dart';
import '../veiculos/veiculos.dart';
import '../abastecimentos/abastecimentos.dart';
import '../abastecimentos/abastecimentos_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthRepository>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "Usuário";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          children: [
            Text(
              "Bem-vindo, $displayName!",
              style: const TextStyle(fontSize: 20),
            ),

            ListTile(
              title: const Text("Ir para Veículos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VeiculosPage()),
                );
              },
            ),
            ListTile(
              title: const Text("Registrar Abastecimento"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AbastecimentoForm()),
                );
              },
            ),

            ListTile(
              title: const Text("Histórico de Abastecimentos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AbastecimentosPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
