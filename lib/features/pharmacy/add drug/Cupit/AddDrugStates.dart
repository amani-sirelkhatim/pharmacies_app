class AddDrugStates {}

class AddDrugInitState extends AddDrugStates {}

class AddDrugLoadingState extends AddDrugStates {}

class AddDrugSuccessState extends AddDrugStates {}

class AddDrugErrorState extends AddDrugStates {
  final String error;

  AddDrugErrorState({required this.error});
}
