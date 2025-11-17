class Abastecimento {
  final String id;
  final String veiculoId;
  final String data;
  final String quantidadeLitros;
  final String valorPago;
  final String quilometragem;
  final String tipoCombustivel;
  final String observacao;

  Abastecimento({
    required this.id,
    required this.veiculoId,
    required this.data,
    required this.quantidadeLitros,
    required this.valorPago,
    required this.quilometragem,
    required this.tipoCombustivel,
    required this.observacao,
  });

  Map<String, dynamic> toMap() => {
    'veiculoId': veiculoId,
    'data': data,
    'quantidadeLitros': quantidadeLitros,
    'valorPago': valorPago,
    'quilometragem': quilometragem,
    'tipoCombustivel': tipoCombustivel,
    'observacao': observacao,
  };

  factory Abastecimento.fromMap(String id, Map<String, dynamic> map) {
    return Abastecimento(
      id: id,
      veiculoId: map['veiculoId'] ?? '',
      data: map['data'] ?? '',
      quantidadeLitros: map['quantidadeLitros'] ?? '',
      valorPago: map['valorPago'] ?? '',
      quilometragem: map['quilometragem'] ?? '',
      tipoCombustivel: map['tipoCombustivel'] ?? '',
      observacao: map['observacao'] ?? '',
    );
  }
}
