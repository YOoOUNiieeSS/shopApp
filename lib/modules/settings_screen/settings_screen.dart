import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared_1/components/components.dart';
import 'package:shop_app/shared_1/components/constants.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_states.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        nameController.text = ShopCubit.get(context).userModel!.data!.name!;
        phoneController.text = ShopCubit.get(context).userModel!.data!.phone!;
        emailController.text = ShopCubit.get(context).userModel!.data!.email!;
        return Center(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(20),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserDataState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: defaultFormField(
                            type: TextInputType.name,
                            controller: nameController,
                            label: 'Name',
                            validate: (String? v) {
                              if (v!.isEmpty) return 'Name Must not be empty.';
                              return null;
                            },
                            prefix: Icons.person,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: defaultFormField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            label: 'Email Address',
                            validate: (String? v) {
                              if (v!.isEmpty)
                                return 'Email Address Must not be empty.';
                              return null;
                            },
                            prefix: Icons.email,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: defaultFormField(
                            type: TextInputType.phone,
                            controller: phoneController,
                            label: 'Phone',
                            validate: (String? v) {
                              if (v!.isEmpty) return 'Phone Must not be empty.';
                              return null;
                            },
                            prefix: Icons.phone,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            text: 'update',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text);
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            text: 'LOGOUT',
                            function: () {
                              signOut(context);
                            })
                      ],
                    ))));
      },
    );
  }
}
