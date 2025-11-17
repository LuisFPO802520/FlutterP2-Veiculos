import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/veiculos.dart';

class VeiculosRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Veiculo>> listarVeiculos() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('users/$uid/veiculos')
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => Veiculo.fromMap(d.id, d.data())).toList(),
        );
  }

  Future<void> adicionarVeiculo(Veiculo veiculo) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users/$uid/veiculos').add(veiculo.toMap());
  }

  Future<void> editarVeiculo(Veiculo veiculo) async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users/$uid/veiculos')
        .doc(veiculo.id)
        .update(veiculo.toMap());
  }

  Future<void> removerVeiculo(String id) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users/$uid/veiculos').doc(id).delete();
  }
}
