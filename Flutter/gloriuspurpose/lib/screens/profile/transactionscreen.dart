import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloriuspurpose/colors.dart';
import 'package:gloriuspurpose/models/TransactionResponse.dart';

class TransactionScreen extends StatelessWidget
{

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: myGreen,
        foregroundColor: Colors.white,
        title: Text("Transactions"),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator(color: myGreen,);
          }

          final data = snapshot.data!.data();
          List listOfTransactions = data!['transactions'];
          return ListView.builder(itemCount: listOfTransactions.length,itemBuilder: (context,index){
            TransactionResponse response = TransactionResponse.fromJson(listOfTransactions[index]);
            return Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              child: Card(
                color: myGreen,
                elevation: 5,
                child: ListTile(
                  textColor: Colors.white,

                  leading: Icon(CupertinoIcons.arrow_up_right,color: Colors.white,),

                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gas Used : ${response.effectiveGasPrice}",maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Text("Transaction Id : ${response.transactionHash}",maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Text("To : ${response.to}",maxLines: 1,overflow: TextOverflow.ellipsis,),
                      Text("Status : Successful")
                    ],
                  ),

                  trailing: Column(
                    children: [
                      Text(response.amount.toString(),style: TextStyle(fontSize: 23),),
                      Text("ETH",style: TextStyle(fontSize: 15),)
                    ],
                  ),
                ),
              ),
            );
          });
        }
      ),

    );
  }

}