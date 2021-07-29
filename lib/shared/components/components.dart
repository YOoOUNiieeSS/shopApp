import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

Widget defaultFormField({
  @required TextInputType? type,
  @required TextEditingController? controller,
  bool isPassword = false,
  @required String? label,
  @required String? Function(String? x)? validate,
  void Function(String v)? onSubmit,
  void Function(String? x)? onChanged,
  void Function()? onTap,
  void Function()? suffixPressed,
  @required IconData? prefix,
  IconData? suffix,
}) {
  return TextFormField(
    onTap: onTap,
    keyboardType: type,
    controller: controller,
    obscureText: isPassword,
    validator: validate,
    onFieldSubmitted: onSubmit,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(icon: Icon(suffix),onPressed: suffixPressed,),
      border: OutlineInputBorder(),
    ),
  );
}

Widget defaultTextButton({
  required String text,
  required void Function()? function
})=>TextButton(onPressed: function, child: Text(text));
Widget defaultButton({
  @required String? text,
  Color background = Colors.blue,
  double width = double.infinity,
  @required void Function()? function,
  bool isUpperCase = true,
  double radius = 0.0,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: background, borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text!.toUpperCase() : text!,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget loadingItem(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,size: 100,color: Colors.grey,),
        Text('No Tasks Yet, Please Add Some Tasks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey),)
      ],
    ),
  );
}


Widget myDivider()=>Container(height: 1,color: Colors.grey,);

void navigateTo(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));

void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget),(route)=>false);


