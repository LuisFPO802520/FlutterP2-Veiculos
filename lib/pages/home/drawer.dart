import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth.dart';
import '../veiculos/veiculos.dart';
import '../abastecimentos/abastecimentos.dart';
import '../abastecimentos/abastecimentos_form.dart';
import '../../core/apptheme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthRepository>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "Usuário";

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: AppTheme.fireOrange,
            child: Text(
              "Bem-vindo,\n$displayName!",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text("Veículos"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VeiculosPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: const Text("Registrar Abastecimento"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AbastecimentoForm()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Histórico de Abastecimentos"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AbastecimentosPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: () {
              auth.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
