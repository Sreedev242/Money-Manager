import 'package:flutter/material.dart';
import 'package:personal_money_management_app/Home/Homescreen.dart';
import 'package:personal_money_management_app/Home/Widgets/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


@override
  void initState() {
    checkLoggedIn();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final  mediasizeH=MediaQuery.of(context).size.height;
     final  mediasizeW=MediaQuery.of(context).size.width;
    return Scaffold(body:
    Center(
      child: Container(
height:mediasizeH*1/3 ,
width: mediasizeW*1/3,
decoration:BoxDecoration(image: DecorationImage(fit: BoxFit.cover,image: NetworkImage('https://atlas-content-cdn.pixelsquid.com/stock-images/green-dollar-coin-EKa5yJA-600.jpg'))),
      ),
    ));
  }

  Future gotoLogin()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return LoginScreen();
        }));
  }

    Future<void>checkLoggedIn()async{
      final _sharedprefs= await SharedPreferences.getInstance();
      
    final _userloggedIn=  _sharedprefs.getBool('username');

      if (_userloggedIn==null || _userloggedIn==false) {
        gotoLogin();

      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return Homescreen();
        }));
      }
    }
}