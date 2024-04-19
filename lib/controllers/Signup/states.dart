abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangeUserIconState extends ShopRegisterStates{}

class ShopRegisterChangePasswordIconState extends ShopRegisterStates{}

class ShopRegisterChangeEmailIconState extends ShopRegisterStates{}

class ShopRegisterChangeEyeIconState extends ShopRegisterStates{}

class ShopRegisterChangeSwitch extends ShopRegisterStates{}


