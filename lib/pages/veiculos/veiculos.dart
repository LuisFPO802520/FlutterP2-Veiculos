import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/veiculos_repository.dart';
import '../../data/models/veiculos.dart';
import '../veiculos/veiculos_form.dart';

class VeiculosPage extends StatelessWidget {
  const VeiculosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<VeiculosRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Veículos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VeiculoForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Veiculo>>(
        stream: repo.listarVeiculos(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final lista = snap.data!;

          if (lista.isEmpty) {
            return const Center(child: Text("Nenhum veículo cadastrado."));
          }

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (_, i) {
              final v = lista[i];

              return ListTile(
                title: Text("${v.modelo} - ${v.marca}"),
                subtitle: Text("${v.placa} | ${v.ano} | ${v.tipoCombustivel}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => VeiculoForm(veiculo: v)),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VeiculoForm(veiculo: v),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => repo.removerVeiculo(v.id),
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
