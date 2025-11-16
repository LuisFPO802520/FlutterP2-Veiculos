import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/auth.dart';
import '../veiculos/veiculos.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthRepository>(context, listen: false);

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
              "Usuário autenticado com sucesso!",
              style: TextStyle(fontSize: 20),
            ),
          
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VeiculosPage(),
                  ),
                );
              },
              child: const Text("Ir para Veículos"),
              ),
          
          ]   
        ),
      ) 
    );
  }
}