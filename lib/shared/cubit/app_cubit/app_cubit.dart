import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);
  bool isDark = false;
  void changeThemeMode({bool? fromShared}){
    if(fromShared!=null)
      {
        isDark=fromShared;
        emit(AppThemeMode());
      }
    else{
    isDark=!isDark;
    CacheHelper.setBoolean(key: 'isDark',value: isDark).then((value) {
      emit(AppThemeMode());
    });
    }
  }
}