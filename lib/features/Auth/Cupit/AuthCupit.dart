import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacies_app/features/Auth/Cupit/AuthStates.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());
  //---------------------------regester-----------------------------------//
  ///---------Admin sign up
  registerPharmacy({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);

      // firestore

      FirebaseFirestore.instance.collection('Pharmacy').doc(user.uid).set({
        'id': user.uid,
        'name': name,
        'image': null,
        'email': email,
        'phone': phone,
        'address': null,
        'language': 'English',
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'كلمة السر ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'الحساب موجود بالفعل'));
      }
    } catch (e) {
      emit(RegisterErrorState(error: 'حدثت مشكله فالتسجيل حاول لاحقا'));
    }
  }

//-----------------user signup-----------------
  regestirCustomer({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    try {
      // firestore

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);

      await FirebaseFirestore.instance
          .collection('Customer')
          .doc(user.uid)
          .set({
        'id': user.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'address': null,
        'language': 'English',
      }, SetOptions(merge: true));

      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'the password is weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'this email is already regestered'));
      }
    } catch (e) {
      emit(RegisterErrorState(
          error: 'there is a problem please try again later'));
    }
  }
  //

//---------------------------login--------------------------------------//
  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        User user = credential.user!;
      }
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'wrong password'));
      } else {
        emit(LoginErrorState(
            error: 'there is a proplem in logging in pleasr try again later'));
      }
    }
  }
}
