import 'package:flutter/material.dart';

class VeiculosPage extends StatelessWidget {
  const VeiculosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veículos"),
      ),
      body: const Center(
        child: Text("Tela de veículos"),
      ),
    );
  }
}