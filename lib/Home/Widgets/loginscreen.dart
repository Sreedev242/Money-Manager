import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Home/Homescreen.dart';
import 'package:personal_money_management_app/Home/Widgets/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final  ctrlUsername= TextEditingController();
  final  ctrlPassword=  TextEditingController();
  final _formKey=GlobalKey<FormState>();
    return Scaffold(backgroundColor:Color.fromARGB(255, 223, 248, 224) ,
      body: 
      SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column( children: [ SizedBox(height: 16,),
          Text('Login to Start',style: TextStyle(fontSize: 30,color:  Colors.grey),),
            SizedBox(height: 26,),
            TextFormField(
              validator: (value) {
                 if (value==null||  value.isEmpty || ctrlPassword.text==null ) {
                  return "Field can\'t be empty";
                }else if (ctrlPassword.text!=value){
                    return "Username and passwaord are not same";
                }else{
                  return null;
                }
              },
              controller: ctrlUsername,
              decoration: InputDecoration(
             border: OutlineInputBorder(),
                hintText: 'Username'),),
            SizedBox(height: 15,),
             TextFormField(
              controller: ctrlPassword,
              validator: (value) {
                if (value==null||  value.isEmpty || ctrlPassword.text==null) {
                  return "Field can\'t be empty";
                }else if (value!=ctrlUsername.text){
                    return "Username and passwaord are not same";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Use Username as Password'),),
             SizedBox(height: 30,),
             ElevatedButton(onPressed: ()async{
          if ( _formKey.currentState!.validate()) {


              final _sharedprefs=await SharedPreferences.getInstance();
            await  _sharedprefs.setBool('username', true);

             Navigator.pushReplacement(
               context,
                 MaterialPageRoute(builder: (context) => Homescreen()));
          } 
             
             }, child: Text('Login'))
              
          ],),
        ),
      )),
    );
  }
}