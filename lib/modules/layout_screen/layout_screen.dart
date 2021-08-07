import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_states.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text('Salla'),
          actions: [
            IconButton(onPressed: ()=>navigateTo(context, SearchScreen()), icon: Icon(Icons.search))
          ],
        ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
            onTap: (index)=>cubit.changeBottomNavBar(index),
            currentIndex: cubit.currentIndex,
          ),
      );
      },
    );
  }
}
