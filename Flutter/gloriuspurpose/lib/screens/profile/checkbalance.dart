import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gloriuspurpose/apivariables.dart';
import 'package:gloriuspurpose/colors.dart';
import 'package:gloriuspurpose/services/sharedprefsservice.dart';
import 'package:http/http.dart' as http;

class CheckBalance extends StatefulWidget {

  @override
  State<CheckBalance> createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {
  
  double balance = 0.0;
  bool isLoading = true;
  String privateKey = "";
  String accountAddress = "";

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  getBalance()async{
    privateKey = SharedPreferencesServices.getPrivateKey();
    accountAddress = SharedPreferencesServices.getAccountAddress();
    print(privateKey);
    final resp = await http.get(Uri.parse("$getBalanceApi/0x6fe670fcce1af7c72adf2ba0130380b1c1cdfc5df88668f8b848ce48dd741df2"),headers: headers);
    balance = jsonDecode(resp.body).toDouble();
    isLoading = false;
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: myGreen,
      body: Center(
        child: isLoading ? const CircularProgressIndicator(color: Colors.white,) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Balance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.white),),
              Text("$balance ETH",style: TextStyle(fontSize: 38,color: Colors.white,fontWeight: FontWeight.w600),),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Public Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.white),),
                  SizedBox(width: 13,),
                  InkWell(onTap: ()async{
                    await Clipboard.setData(ClipboardData(text: accountAddress),);
                    messageCopied(context);
                  },child: Icon(Icons.copy,color: Colors.white,)),
                ],
              ),
              Text("$accountAddress",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Private Key",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.white),),
                  SizedBox(width: 13,),
                  InkWell(onTap: ()async{
                    await Clipboard.setData(ClipboardData(text: privateKey),);
                    messageCopied(context);
                  },child: Icon(Icons.copy,color: Colors.white,)),
                ],
              ),
              Text("$privateKey",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
      ),
    );
  }

  messageCopied(context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),content: Text("Successfully copied to Clipboard",style: TextStyle(color: myGreen),),backgroundColor: Colors.white,),);
  }
}
