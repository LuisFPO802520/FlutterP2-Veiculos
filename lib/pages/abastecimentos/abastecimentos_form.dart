import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/abastecimento.dart';
import '../../data/models/veiculos.dart';
import '../../data/repositories/abastecimentos_repository.dart';
import '../../data/repositories/veiculos_repository.dart';

class AbastecimentoForm extends StatefulWidget {
  final Abastecimento? abastecimento;

  const AbastecimentoForm({super.key, this.abastecimento});

  @override
  State<AbastecimentoForm> createState() => _AbastecimentoFormState();
}

class _AbastecimentoFormState extends State<AbastecimentoForm> {
  String? veiculoId;
  late TextEditingController data;
  late TextEditingController litros;
  late TextEditingController valor;
  late TextEditingController km;
  late TextEditingController combustivel;
  late TextEditingController obs;

  @override
  void initState() {
    super.initState();

    // Preenche os campos se estiver editando
    data = TextEditingController(text: widget.abastecimento?.data ?? "");
    litros = TextEditingController(
      text: widget.abastecimento?.quantidadeLitros ?? "",
    );
    valor = TextEditingController(text: widget.abastecimento?.valorPago ?? "");
    km = TextEditingController(text: widget.abastecimento?.quilometragem ?? "");
    combustivel = TextEditingController(
      text: widget.abastecimento?.tipoCombustivel ?? "",
    );
    obs = TextEditingController(text: widget.abastecimento?.observacao ?? "");

    veiculoId = widget.abastecimento?.veiculoId;
  }

  @override
  Widget build(BuildContext context) {
    final repoVeiculos = Provider.of<VeiculosRepository>(context);
    final repoAb = Provider.of<AbastecimentosRepository>(context);

    final bool isEdicao = widget.abastecimento != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdicao ? "Editar Abastecimento" : "Novo Abastecimento"),
      ),
      body: StreamBuilder<List<Veiculo>>(
        stream: repoVeiculos.listarVeiculos(),
        builder: (_, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final veiculos = snap.data!;
          if (veiculos.isEmpty) {
            return const Center(child: Text("Cadastre um veículo primeiro."));
          }

          // se for novo registro e ainda não tiver veiculoId definido
          veiculoId ??= veiculos.first.id;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButtonFormField<String>(
                value: veiculoId,
                items: veiculos
                    .map(
                      (v) =>
                          DropdownMenuItem(value: v.id, child: Text(v.modelo)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => veiculoId = v),
                decoration: const InputDecoration(labelText: "Veículo"),
              ),

              _campo(data, "Data"),
              _campo(litros, "Quantidade de litros"),
              _campo(valor, "Valor pago"),
              _campo(km, "Quilometragem"),
              _campo(combustivel, "Tipo de combustível"),
              _campo(obs, "Observação"),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  final novo = Abastecimento(
                    id: widget.abastecimento?.id ?? "",
                    veiculoId: veiculoId!,
                    data: data.text.trim(),
                    quantidadeLitros: litros.text.trim(),
                    valorPago: valor.text.trim(),
                    quilometragem: km.text.trim(),
                    tipoCombustivel: combustivel.text.trim(),
                    observacao: obs.text.trim(),
                  );

                  if (isEdicao) {
                    await repoAb.editar(novo);
                  } else {
                    await repoAb.adicionar(novo);
                  }

                  Navigator.pop(context);
                },
                child: Text(isEdicao ? "Salvar alterações" : "Cadastrar"),
              ),
            ],
          );
        },
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
