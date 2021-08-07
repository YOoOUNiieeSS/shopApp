import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_states.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ShopCubit.get(context).favoritesModel==null?Center(child: CircularProgressIndicator()):BlocConsumer<ShopCubit,ShopStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        return state is ShopLoadingFavoritesDataState? Center(child: CircularProgressIndicator()):ListView.separated(
          itemBuilder: (ctx,index)=>buildListItem(ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
          separatorBuilder: (ctx,index)=>myDivider(),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
        );
      },
    );
  }
}
