import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacies_app/features/pharmacy/add%20drug/Cupit/AddDrugStates.dart';

class AddDrugCubit extends Cubit<AddDrugStates> {
  AddDrugCubit() : super(AddDrugInitState());

  AddDrug(
      {required String pharmacyid,
      required String cat,
      required String name,
      required List descriptionArabic,
      required List descriptionEnglish,
      required List howtouseArabic,
      required List howtouseEnglish,
      required String frontimage,
      required String backimage,
      required int? price,
      required bool perscription,
      required final String pharmacyname}) async {
    emit(AddDrugLoadingState());
    try {
      // firestore

      var documentReference =
          await FirebaseFirestore.instance.collection('Products').add({
        'pharmacyid': pharmacyid,
        'pharmacyname': pharmacyname,
        'name': name,
        'cattegory': cat,
        'price': price,
        'perscription': perscription,
        'descriptionArabic': descriptionArabic,
        'descriptionEnglish': descriptionEnglish,
        'howtouseArabic': howtouseArabic,
        'howtouseEnglish': howtouseEnglish,
        'frontimage': frontimage,
        'backimage': backimage
      });

// Access the auto-generated document ID
      var drugid = documentReference.id;

// Update the document with the document ID
      await documentReference.update({'drugid': drugid});

      emit(AddDrugSuccessState());
    } catch (e) {
      emit(AddDrugErrorState(
          error: '$e' + 'Encountered a problem, try again later!'));
    }
  }

//'incaontered a proplem try again later!!'
}
