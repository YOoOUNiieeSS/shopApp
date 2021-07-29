abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginSuccessState extends ShopLoginStates {}
class ShopLoginErrorState extends ShopLoginStates {
  String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePrefixVisibilityState extends ShopLoginStates {}
