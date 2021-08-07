import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/cubit/search_cubit/search_cubit.dart';
import 'package:shop_app/shared_1/cubit/search_cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  final formKey=GlobalKey<FormState>();
  final searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      child: defaultFormField(
                          type: TextInputType.text,
                          controller: searchController,
                          label: 'Search',
                          validate: (String? v){
                            if(v!.isEmpty)return 'search must not be empty';
                            return null;
                          },
                          prefix: Icons.search,
                          onSubmit: (text){
                            SearchCubit.get(context).search(text);
                          }
                      ),
                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        itemBuilder: (ctx,index)=>buildListItem(SearchCubit.get(context).searchModel!.data!.data![index],context,oldPrice: false),
                        separatorBuilder: (ctx,index)=>myDivider(),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
