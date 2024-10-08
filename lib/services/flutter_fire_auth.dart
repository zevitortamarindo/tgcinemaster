import 'package:cinemaster_app/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FlutterFireAuth {
  FlutterFireAuth(this._context);

  late final BuildContext _context;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserData?> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      return UserData(name: name, email: email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Ocorreu um erro desconhecido'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    return null;
  }

  Future<UserData?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return UserData(
          name: credential.user?.displayName, email: credential.user?.email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Ocorreu um erro desconhecido'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    return null;
  }

  UserData? getLoggedUser() {
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    return UserData(
      name: user.displayName,
      email: user.email,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
