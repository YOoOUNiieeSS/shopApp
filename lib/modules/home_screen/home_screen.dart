import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/components/constants.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState)
          if(!state.changeFavoritesModel.status!)
            showToast(msg: state.changeFavoritesModel.message!, state: ToastState.ERROR);
      },
      builder: (context, state) {
        return ShopCubit.get(context).homeModel == null  ||  ShopCubit.get(context).categoryModel == null ? Center(child: CircularProgressIndicator()) :
        productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoryModel!,context);
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoryModel categoryModel,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners.map((e) =>
                Image(image: NetworkImage(e.image!.toString()), fit: BoxFit.cover,width: double.infinity,))
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              height: 250,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              reverse: false,
              viewportFraction: 1.0,
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
                SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>buildCategoryItem(categoryModel.data!.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 10,),
                      itemCount: categoryModel.data!.data.length),
                ),
                SizedBox(height: 20,),
                Text('New Products',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1/1.58,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,

              children: List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index],context)),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildGridProduct(ProductModel product,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(product.image!),height: 200,width: double.infinity,),
            if(product.discount!=0)Container(color:Colors.red,padding: EdgeInsets.symmetric(horizontal: 5) ,child: Text('DISCOUNT',style: TextStyle(fontSize: 8,color: Colors.white),),)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name!,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(height: 1.3),),
              Row(children: [
                Text('${product.price.round()}',style: TextStyle(fontSize: 12,color: defaultColor),),
                SizedBox(width: 5,),
                if(product.discount!=0)Text('${product.oldPrice.round()}',style: TextStyle(fontSize: 10,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                Spacer(),
                CircleAvatar(
                    radius: 15.0,
                    backgroundColor: ShopCubit.get(context).favorites[product.id!]!?defaultColor : Colors.grey,
                    child: IconButton(padding: EdgeInsets.zero,onPressed: ()=>ShopCubit.get(context).changeFavorites(product.id!), icon: Icon(Icons.favorite_outline),color: Colors.white,))
              ],),
            ],
          ),
        )
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image!),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(color: Colors.white),
        ),
      )
    ],);
}
