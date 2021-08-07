import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout_screen/layout_screen.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/components/constants.dart';
import 'package:shop_app/shared_1/cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/shared_1/cubit/register_cubit/register_states.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared_1/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        builder: (context,state)=>Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          )),
                      Text('Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          )),
                      SizedBox(height: 30,),
                      Container(
                        child: defaultFormField(
                          type: TextInputType.name,
                          controller: nameController,
                          label: 'Name',
                          validate: (String? v){
                            if(v!.isEmpty)return 'Name Must not be empty.';
                            return null;
                          },
                          prefix: Icons.person,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: defaultFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email Address',
                          validate: (String? v){
                            if(v!.isEmpty)return 'Email Address Must not be empty.';
                            return null;
                          },
                          prefix: Icons.email,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: defaultFormField(
                          type: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          validate: (String? v){
                            if(v!.isEmpty)return 'Phone Must not be empty.';
                            return null;
                          },
                          prefix: Icons.phone,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: defaultFormField(
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            label: 'Password',
                            validate: (String? v){
                              if(v!.isEmpty)return 'Password is too short';
                              return null;
                            },
                            prefix: Icons.lock_outline,
                            suffix: ShopRegisterCubit.get(context).visibilityIcon,
                            suffixPressed: (){
                              ShopRegisterCubit.get(context).changePrefixVisibility();
                            },
                            onSubmit: (n){
                              (state is ShopRegisterLoadingState)?Center(child: CircularProgressIndicator()):defaultButton(text: 'register', function: (){
                                if(formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              });
                            }
                        ),
                      ),
                      SizedBox(height: 30,),
                      (state is ShopRegisterLoadingState)?Center(child: CircularProgressIndicator()):
                      Container(
                        child: defaultButton(
                          text: 'register',
                          function: (){
                            if(formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  password: passwordController.text);
                            }
                          },
                          isUpperCase: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.shopLoginModel.status!){

              CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data!.token).then((value){
                token=state.shopLoginModel.data!.token;
                ShopCubit.get(context).changeBottomNavBar(0);
                navigateAndFinish(context, ShopLayoutScreen());
              });

            }else{
              showToast(state: ToastState.ERROR,msg: state.shopLoginModel.message!);
            }
          }
        },
      ),
    );
  }
}
