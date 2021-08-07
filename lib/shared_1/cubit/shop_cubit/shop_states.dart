import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
  ChangeFavoritesModel changeFavoritesModel;
  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}
class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessFavoritesDataState extends ShopStates {}
class ShopLoadingFavoritesDataState extends ShopStates {}
class ShopErrorFavoritesDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}
class ShopErrorUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {}
class ShopLoadingUpdateUserDataState extends ShopStates {}
class ShopErrorUpdateUserDataState extends ShopStates {}