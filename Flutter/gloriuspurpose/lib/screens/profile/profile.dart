import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gloriuspurpose/colors.dart';
import 'package:gloriuspurpose/screens/auth/signupscreen.dart';
import 'package:gloriuspurpose/screens/profile/myfunds.dart';
import 'package:gloriuspurpose/screens/profile/settingscreen.dart';
import 'package:gloriuspurpose/screens/profile/transactionscreen.dart';
import 'package:gloriuspurpose/services/authservice.dart';
import 'package:gloriuspurpose/services/localauthservice.dart';

import 'checkbalance.dart';

class Profile extends StatelessWidget {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.05,
            ),
            CircleAvatar(
              radius: size.width*0.23,
              //backgroundImage: NetworkImage(auth.currentUser!.photoURL.toString()),
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Text("Sayed Zeeshan Hyder",style: TextStyle(fontWeight: FontWeight.w700,fontSize: size.width*0.06),),
            Text("15th December 2004",style: TextStyle(fontWeight: FontWeight.w400,fontSize: size.width*0.04,color: Colors.grey),),

            SizedBox(
              height: size.height*0.03,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: myGreen,
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.height*0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: size.width*0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("12 ETH",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                            Text("Funds\nRaised",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        width: size.width*0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("12 ETH",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                            Text("Funds\nContributed",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height*0.01,
            ),


            //My Transaction
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: myGreen,
                elevation: 5,
                child: ListTile(
                  onTap: (){
                    Get.to(()=> TransactionScreen(),transition: Transition.rightToLeft);
                  },
                  textColor: Colors.white,
                  title: Text("My Transaction"),
                ),
              ),
            ),


            //My Funds
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: myGreen,
                elevation: 5,
                child: ListTile(
                  splashColor: Colors.transparent,
                  onTap: (){
                    Get.to(()=> MyFunds(),transition: Transition.rightToLeft);
                  },
                  textColor: Colors.white,
                  title: Text("My Funds"),
                ),
              ),
            ),


            //My Blogs
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: myGreen,
                elevation: 5,
                child: ListTile(
                  textColor: Colors.white,
                  title: Text("My Blogs"),
                ),
              ),
            ),

            //Check Balance
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: myGreen,
                elevation: 5,
                child: ListTile(
                  onTap: ()async{
                    // Check Balance through Local Authentication
                    final bool didAuthenticate = await LocalAuthService.authenticateLocalAuth("Authentication Required for Checking Balance");
                    if(didAuthenticate) {
                      Get.to(() => CheckBalance(),
                          transition: Transition.rightToLeft);
                    }
                  },
                  textColor: Colors.white,
                  title: const Text("Check Balance"),
                ),
              ),
            ),



            //Settings
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: myGreen,
                elevation: 5,
                child: ListTile(
                  onTap: (){
                    Get.to(()=> SettingsScreen(),transition: Transition.rightToLeft);
                  },
                  textColor: Colors.white,
                  title: const Text("Settings"),
                ),
              ),
            ),


            //Log Out
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: redColor,
                elevation: 5,
                child: ListTile(
                  onTap: ()async{
                    // Log Out Function
                    await AuthService.logOut();
                    Get.off(()=> SignUpScreen(),transition: Transition.leftToRight);
                  },
                  textColor: Colors.white,
                  title: Text("LogOut"),
                ),
              ),
            ),

            SizedBox(
              height: size.height*0.05,
            ),
          ],
        ),
      ),
    );
  }
}
