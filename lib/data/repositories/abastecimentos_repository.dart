import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/abastecimento.dart';

class AbastecimentosRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Abastecimento>> listar() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('users/$uid/abastecimentos')
        .orderBy('data', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => Abastecimento.fromMap(d.id, d.data()))
              .toList(),
        );
  }

  Future<void> adicionar(Abastecimento ab) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users/$uid/abastecimentos').add(ab.toMap());
  }

  Future<void> editar(Abastecimento ab) async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users/$uid/abastecimentos')
        .doc(ab.id)
        .update(ab.toMap());
  }

  Future<void> remover(String id) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users/$uid/abastecimentos').doc(id).delete();
  }
}
