import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/abastecimentos_repository.dart';
import '../../data/models/abastecimento.dart';
import '../home/drawer.dart';
import 'abastecimentos_form.dart';

class AbastecimentosPage extends StatelessWidget {
  const AbastecimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<AbastecimentosRepository>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Histórico de Abastecimentos")),
      drawer: const AppDrawer(),
      body: StreamBuilder<List<Abastecimento>>(
        stream: repo.listar(),
        builder: (_, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final lista = snap.data!;
          if (lista.isEmpty) {
            return const Center(
              child: Text("Nenhum abastecimento registrado."),
            );
          }

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (_, i) {
              final a = lista[i];

              return ListTile(
                title: Text("Data: ${a.data} - R\$ ${a.valorPago}"),
                subtitle: Text(
                  "Litros: ${a.quantidadeLitros} | KM: ${a.quilometragem}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AbastecimentoForm(abastecimento: a),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => repo.remover(a.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
