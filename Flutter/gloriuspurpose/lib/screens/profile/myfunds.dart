import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gloriuspurpose/services/sharedprefsservice.dart';
import '../../colors.dart';
import '../../models/campaignmodel.dart';
import '../../widgets/campaigncard.dart';

class MyFunds extends StatelessWidget {

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Funds"),
      ),
      body: StreamBuilder(
        stream: firestore.collection("Campaigns").doc("allCampaigns").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: myGreen,
              ),
            );
          }

          List data = [];
          try {
            data = snapshot.data!.data()!['Campaigns'];
          }catch(e){
            return const Center(child: Text("You havent raised any Campaigns yet",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),);
          }
          final accountAddress = SharedPreferencesServices.getAccountAddress();

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final campaign = CampaignModel.fromJson(data[index]);
              if(campaign.accountAddress == accountAddress)
                return CampaignCard(
                model: campaign,
              );
              else
                SizedBox();
            },
          );
        },
      ),
    );
  }
}
