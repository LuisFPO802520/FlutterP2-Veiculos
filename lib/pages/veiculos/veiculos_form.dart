import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/veiculos_repository.dart';
import '../../data/models/veiculos.dart';

class VeiculoForm extends StatefulWidget {
  final Veiculo? veiculo;

  const VeiculoForm({super.key, this.veiculo});

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  late TextEditingController modelo;
  late TextEditingController marca;
  late TextEditingController placa;
  late TextEditingController ano;
  late TextEditingController tipoCombustivel;

  @override
  void initState() {
    super.initState();

    modelo = TextEditingController(text: widget.veiculo?.modelo ?? "");
    marca = TextEditingController(text: widget.veiculo?.marca ?? "");
    placa = TextEditingController(text: widget.veiculo?.placa ?? "");
    ano = TextEditingController(text: widget.veiculo?.ano ?? "");
    tipoCombustivel = TextEditingController(
      text: widget.veiculo?.tipoCombustivel ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<VeiculosRepository>(context, listen: false);
    final bool isEdicao = widget.veiculo != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdicao ? "Editar Veículo" : "Novo Veículo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _campo(modelo, "Modelo"),
            _campo(marca, "Marca"),
            _campo(placa, "Placa"),
            _campo(ano, "Ano"),
            _campo(tipoCombustivel, "Tipo de Combustível"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final novo = Veiculo(
                  id: widget.veiculo?.id ?? "",
                  modelo: modelo.text.trim(),
                  marca: marca.text.trim(),
                  placa: placa.text.trim(),
                  ano: ano.text.trim(),
                  tipoCombustivel: tipoCombustivel.text.trim(),
                );

                if (isEdicao) {
                  await repo.editarVeiculo(novo);
                } else {
                  await repo.adicionarVeiculo(novo);
                }

                Navigator.pop(context);
              },
              child: Text(isEdicao ? "Salvar alterações" : "Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
