
abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}

class ShopLoginChangeSwitch extends ShopLoginStates{}

class ShopLoginChangePasswordIconState extends ShopLoginStates{}

class ShopLoginChangeEmailIconState extends ShopLoginStates{}
