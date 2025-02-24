abstract class HomeScreenStates{}

class HomeInitState extends HomeScreenStates{}

class HomeProductsLoadingState extends HomeScreenStates{}

class HomeProductsSuccessState extends HomeScreenStates{}

class HomeProductsErrorState extends HomeScreenStates{
  final String error;
  HomeProductsErrorState(this.error);
}
class HomeCatErrorState extends HomeScreenStates{
  final String error;
  HomeCatErrorState(this.error);
}
class HomecatLoadingState extends HomeScreenStates{}

class HomecatSuccessState extends HomeScreenStates{}

class RemoveFromWishList extends HomecatSuccessState{}

class AddToWishList extends HomecatSuccessState{

}
class ToogleLoading extends HomeScreenStates{}