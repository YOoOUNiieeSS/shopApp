import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/login_cubit/login_cubit.dart';
import 'package:shop_app/shared/cubit/login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
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
                      Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          )),
                      Text('Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          )),
                      SizedBox(height: 30,),
                      defaultFormField(
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        label: 'Email Address',
                        validate: (String? v){
                          if(v!.isEmpty)return 'Please enter your email';
                          return null;
                        },
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        label: 'Password',
                        validate: (String? v){
                          if(v!.isEmpty)return 'Password is too short';
                          return null;
                        },
                        prefix: Icons.lock_outline,
                        suffix: ShopLoginCubit.get(context).visibilityIcon,
                        suffixPressed: (){
                          ShopLoginCubit.get(context).changePrefixVisibility();
                        },
                        onSubmit: (n){
                          (state is ShopLoginLoadingState)?Center(child: CircularProgressIndicator()):defaultButton(text: 'login', function: (){
                            if(formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          });
                        }
                      ),
                      SizedBox(height: 30,),
                      (state is ShopLoginLoadingState)?Center(child: CircularProgressIndicator()):defaultButton(text: 'login', function: (){
                        if(formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },isUpperCase: true,),
                      SizedBox(height: 30,),
                      Row(children: [
                        Text('Don\'t have an account? '),
                        defaultTextButton(function: (){navigateTo(context, ShopRegisterScreen());},text: 'Register'.toUpperCase())
                      ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        listener: (context,state){},
      ),
    );
  }
}
