import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/theme.dart';

import 'layout/onboarding_screen/onboardind_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  runApp(MyApp());
}
//test
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
          home: OnBoardingScreen(),
        ),
      ),
    );
  }
}

