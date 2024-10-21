import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gloriuspurpose/apivariables.dart';
import 'package:gloriuspurpose/models/TransactionResponse.dart';
import 'package:gloriuspurpose/screens/profile/transactionscreen.dart';
import 'package:gloriuspurpose/services/localauthservice.dart';
import 'package:gloriuspurpose/services/sharedprefsservice.dart';
import '../../colors.dart';
import 'package:http/http.dart' as http;
import '../../controllers/bottomnavcontroller.dart';
import '../../models/campaignmodel.dart';
import '../../services/notificationservices/localnotificationservice.dart';

class ContributionScreen extends StatelessWidget {

  final CampaignModel campaign;
  final int ethers;

  ContributionScreen({required this.ethers,required this.campaign});

  final bottomNavController = Get.put(BottomNavController());
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contribute"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [

              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Amount",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),
                        trailing: Text("$ethers ETH",style: TextStyle(fontSize: 16,color: Colors.grey.shade500,),),
                      ),
                      ListTile(
                        title: Text("Gas Price",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),
                        trailing: Text("0.00064 ETH",style: TextStyle(fontSize: 16,color: Colors.grey.shade500,),),
                      ),
                      ListTile(
                        title: Text("Total",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),
                        trailing: Text("${ethers + 0.00064} ETH",style: TextStyle(fontSize: 16,color: Colors.grey.shade500,),),
                      ),
                      ListTile(
                        title: Text("Date",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),
                        trailing: Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",style: TextStyle(fontSize: 16,color: Colors.grey.shade500,),),
                      ),
                      ListTile(
                        title: Text("From",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),
                        trailing: Text("${SharedPreferencesServices.getAccountAddress().substring(0,4)}******************",style: TextStyle(fontSize: 16,color: Colors.grey.shade500,),),
                      ),
                      ListTile(
                        title: Text("To",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),
                        trailing: Text("${campaign.accountAddress.substring(0,4)}******************",style: TextStyle(fontSize: 16,color: Colors.grey.shade500,),),
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: size.height*0.25,
              ),

              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: ()async{
                  final isAuthenticated = await LocalAuthService.authenticateLocalAuth("Authentication Required before transaction");
                  if(isAuthenticated){

                    await transferMoney(campaign.accountAddress);
                    //Hit the Transaction Api
                    //The Transaction API

                    Get.back();
                    Get.back();
                    bottomNavController.currentIndex.value = 3;
                    Get.to(()=> TransactionScreen(),);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Authentication Successfull"),backgroundColor: myGreen,),);
                    NotificationService.showLocalNotification("Transaction Successful", "Thank You for contribution to the ${campaign.title} Campaign,Your Contribution is Apprciated", "payload");
                  }else{
                    print(SharedPreferencesServices.getDeviceToken());
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width*0.85,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: myGreen,
                  ),
                  child: Text("Confirm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),

              SizedBox(
                height: 13,
              ),

              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width*0.85,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.red,width: 1.5),
                  ),
                  child: Text("Cancel",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                ),
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  transferMoney(String accountAddress)async{
    final body = {
      "amount":ethers,
      "privateKey":SharedPreferencesServices.getPrivateKey(),
      "recipent":accountAddress
    };
    final resp = await http.post(Uri.parse(transferApi),headers:headers,body: jsonEncode(body),);
    final transactionJson = jsonDecode(resp.body);
    transactionJson['amount']=ethers;
    TransactionResponse response = TransactionResponse.fromJson(transactionJson);
    await updateTransaction(response);
  }

  updateTransaction(TransactionResponse response)async{
    final get = await firestore.collection("Users").doc(auth.currentUser!.uid).get();
    List listOfTransactions = get.exists ? get.data()!['transactions'] : [];
    listOfTransactions.add(response.toJson());
    await firestore.collection("Users").doc(auth.currentUser!.uid).set({
      "transactions":listOfTransactions
    });
  }
}
