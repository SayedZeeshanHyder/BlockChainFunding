import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gloriuspurpose/colors.dart';
import 'package:gloriuspurpose/screens/auth/loginscreen.dart';
import 'package:gloriuspurpose/screens/auth/walletscreen.dart';
import 'package:gloriuspurpose/services/authservice.dart';

class SignUpScreen extends StatelessWidget {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor : myGreen,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height*0.1,
              ),
        
              Text("Glorious Purpose",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 23),),
        
              SizedBox(
                height: size.height*0.07,
              ),
        
              Text("SignUp",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
        
              SizedBox(
                height: size.height*0.04,
              ),
        
              Text("Already have an Account?",style: TextStyle(color: Colors.white,fontSize: 17),),
              InkWell(onTap: (){
                Get.off(()=> LoginScreen(),transition: Transition.leftToRight);
              },child: const Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18.5,decoration: TextDecoration.underline,decorationColor: Colors.white),)),

              SizedBox(
                height: size.height*0.07,
              ),
        
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white,),),
                  SizedBox(width: size.width*0.05,),
                  Text("Using Google Account",style: TextStyle(color: Colors.white,fontSize: 18.5),),
                  SizedBox(width: size.width*0.05,),
                  Expanded(child: Divider(color: Colors.white,),),
                ],
              ),
        
              SizedBox(
                height: size.height*0.04,
              ),
        
              SizedBox(
                height: size.height*0.055,
                child: GoogleAuthButton(
                  onPressed: ()async{
                    final isGoogleSignedIn = await AuthService.signInUsingGoogle();
                    if(isGoogleSignedIn){
                      Get.to(()=>WalletScreen(),transition: Transition.rightToLeft);
                    }else{
                      Get.showSnackbar(GetSnackBar(message: "Failed to Sign In",title: "Couldnot Sign in using Google at the Moment",),);
                    }
                  },
                ),
              ),
        
        
              SizedBox(
                height: size.height*0.04,
              ),
        
        
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white,),),
                  SizedBox(width: size.width*0.05,),
                  Text("Using Credentials",style: TextStyle(color: Colors.white,fontSize: 18.5),),
                  SizedBox(width: size.width*0.05,),
                  Expanded(child: Divider(color: Colors.white,),),
                ],
              ),
        
              SizedBox(
                height: size.height*0.04,
              ),
        
        
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                width: size.width*0.8,
                height: size.height*0.07,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Username",
                  ),
                ),
        
              ),
        
              SizedBox(
                height: size.height*0.03,
              ),
        
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                width: size.width*0.8,
                height: size.height*0.07,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Password",
                  ),
                ),
              ),


              SizedBox(
                height: size.height*0.045,
              ),

              CircleAvatar(
                radius: size.width*0.2,
                backgroundColor: Colors.white,
              ),


              SizedBox(
                height: 10,
              ),


              Text("Select a profile Picture",style: TextStyle(color: Colors.white,fontSize: 17),),

              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: (){
                  Get.to(()=>WalletScreen(),transition: Transition.rightToLeft);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                  width: size.width*0.8,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("SignUp",style: TextStyle(color: myGreen,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),


              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
