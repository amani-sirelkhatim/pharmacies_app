class AuthStates {}

class AuthInitState extends AuthStates {}

// login
class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error;

  LoginErrorState({required this.error});
}

// register
class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String error;

  RegisterErrorState({required this.error});
}

//update
class UpdateLoadingState extends AuthStates {}

class UpdateSuccessState extends AuthStates {}

class UpdateErrorState extends AuthStates {
  final String error;

  UpdateErrorState({required this.error});
}

//about
class AboutLoadingState extends AuthStates {}

class AboutSuccessState extends AuthStates {}

class AboutErrorState extends AuthStates {
  final String error;

  AboutErrorState({required this.error});
}
