abstract class ProfileStates{}

class GetUserInit extends ProfileStates{}

class GetUserLoading extends ProfileStates{}

class GetUserSuccess extends ProfileStates{}

class GetUserError extends ProfileStates{
  final String error;
  GetUserError( this.error);
}
class ShopProfilePickedSuccessState extends ProfileStates{}

class ShopProfilePickedErrorState extends ProfileStates{}

class ShopCoverPickedSuccessState extends ProfileStates{}

class ShopCoverPickedErrorState extends ProfileStates{}

class ShopimagePickedSuccessState extends ProfileStates{}

class ShopimagePickedErrorState extends ProfileStates{}

class ShopUploadimageSuccessState extends ProfileStates{}

class ShopUploadimageErrorState extends ProfileStates{}

class ShopUploadCoverSuccessState extends ProfileStates{}

class ShopUploadCoverErrorState extends ProfileStates{}

class ShopUpdateLoadingstate extends ProfileStates{}
