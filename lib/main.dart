import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared_1/components/constants.dart';
import 'package:shop_app/shared_1/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared_1/cubit/app_cubit/app_states.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared_1/network/local/cache_helper.dart';
import 'package:shop_app/shared_1/network/remote/dio_helper.dart';
import 'package:shop_app/shared_1/styles/theme.dart';

import 'layout/onboarding_screen/onboardind_screen.dart';
import 'modules/layout_screen/layout_screen.dart';
import 'modules/login_screen/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  token=CacheHelper.getData(key: 'token')??'';
  bool onBoarding=CacheHelper.getData(key: 'onBoarding')??false;
  if(onBoarding){
    if(token!.isNotEmpty) widget=ShopLayoutScreen();
    else widget=LoginScreen();
  }else
    widget=OnBoardingScreen();
  runApp(MyApp(home: widget,));
}
//test
class MyApp extends StatelessWidget {
  Widget home;
  MyApp({required this.home});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>AppCubit()),
      BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavData()..getUserData()),
    ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
          home: home,
        ),
      ),
    );
  }
}

