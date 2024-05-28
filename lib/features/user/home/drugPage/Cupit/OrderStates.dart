class OrderStates {}

class OrderInitState extends OrderStates {}

class OrderLoadingState extends OrderStates {}

class OrderSuccessState extends OrderStates {}

class OrderErrorState extends OrderStates {
  final String error;

  OrderErrorState({required this.error});
}
