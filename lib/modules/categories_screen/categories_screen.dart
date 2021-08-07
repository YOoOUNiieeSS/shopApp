import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ShopCubit.get(context).categoryModel==null?Center(child: CircularProgressIndicator()):BlocConsumer<ShopCubit,ShopStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        return ListView.separated(
          itemBuilder: (ctx,index)=>buildCatItem(ShopCubit.get(context).categoryModel!.data!.data[index]),
          separatorBuilder: (ctx,index)=>myDivider(),
          itemCount: ShopCubit.get(context).categoryModel!.data!.data.length,
        );
      },
    );
  }
  Widget buildCatItem(DataModel cat)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(cat.image!),
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
        SizedBox(width: 20,),
        Text(cat.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
