import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:gloriuspurpose/controllers/viewcampaigncontroller.dart';
import 'package:gloriuspurpose/models/campaignmodel.dart';
import 'package:gloriuspurpose/screens/home/contributionscreen.dart';
import 'package:gloriuspurpose/services/firestoreservices/addcampaign.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../colors.dart';

class ViewCampaign extends StatelessWidget {
  final CampaignModel campaign;

  ViewCampaign({required this.campaign});

  final buttonController = Get.put(ViewCampaignButtonController(),);

  @override
  Widget build(BuildContext context) {
    print(campaign.toJson());
    DateTime endTime = DateTime.now();
    if(!campaign.isAimAmt) {
      final endYear = int.parse(campaign.endDate.toString().substring(6),);
      final endDay = int.parse(campaign.endDate.toString().substring(0, 2),);
      final endMonth = int.parse(campaign.endDate.toString().substring(3, 4),);
      final DateTime endTime = DateTime(endYear, endMonth, endDay);
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myGreen,
        foregroundColor: Colors.white,
        title: Text(campaign.title.toString()),
      ),
      body: campaign.isLive ? SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: campaign.campaignId.toString(),
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.33,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    image: DecorationImage(
                        image: NetworkImage(
                          campaign.imgUrl.toString(),
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: size.width * 0.9,
                child: Text(
                  campaign.title.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: size.width * 0.9,
                child: Text(
                  campaign.description.toString(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: size.width * 0.9,
                child: Text(
                  "Campaign Raised by",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: size.width * 0.9,
                child: Text("Name of the Owner",style: TextStyle(fontSize: 17),),
              ),

              SizedBox(
                height: 15,
              ),

              Container(
                width: size.width * 0.9,
                child: Text(
                  campaign.isAimAmt ? "Aim" : "Campaign Ending in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              campaign.isAimAmt ? Container(
                width: size.width * 0.9,
                child: Text(campaign.aim.toString(),style: TextStyle(fontSize: 17),),
              ) : TimerCountdown(endTime: endTime,onEnd: (){
                CampaignServices.campaignEnd(campaign.campaignId).then((val){
                  if(val) Navigator.pop(context);
                });
              },),

              SizedBox(
                height: 15,
              ),

              Container(
                width: size.width * 0.9,
                child: Text(
                  "Account Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: size.width * 0.9,
                child: Text(campaign.accountAddress.toString(),style: TextStyle(fontSize: 17),),
              ),

              SizedBox(
                height: 15,
              ),


              Container(
                width: size.width * 0.9,
                child: Text(
                  "Enter Amount",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),


              Container(
                alignment: Alignment.center,
                width: size.width*0.85,
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  onTapOutside: (val){
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (val){
                    if(val.isEmpty){
                      buttonController.ethers.value = 0;
                    }else{
                      buttonController.ethers.value = int.parse(val);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Eg :- 2.74",
                    border: InputBorder.none,
                    suffixText: "ETH",
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: size.width*0.5,child: Text("Scan the QR Code to share this Campaign"),),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: QrImageView(
                      data: campaign.campaignId.toString(),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),


              Obx(
                  ()=> InkWell(
                  onTap: buttonController.ethers.value!=0 ? (){
                    Get.to(()=> ContributionScreen(ethers: buttonController.ethers.value,campaign: campaign,),transition: Transition.rightToLeft);
                  } : null,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width*0.85,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: buttonController.ethers.value!=0 ? myGreen : Colors.grey.shade400,
                    ),
                    child: Text("Contribute to the Campaign",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),

              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ) : returnBlogScreen(size),
    );
  }

  Widget returnBlogScreen(Size size){
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text("The Campaign has Ended",style: TextStyle(fontSize: size.width*0.055),),
            SizedBox(
              height: 15,
            ),
            campaign.isAimAmt? Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
              child: LinearProgressIndicator(
                value: (campaign.collected/campaign.aim),
              ),
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }

  String returnCampaignStatus(){
    final resultFigure = campaign.collected/campaign.aim;
    if(resultFigure>.5 && resultFigure<0.8){
      return "Campaign was Successful";
    }else if(resultFigure > 0.8){
      return "Campaign was a massive Success";
    }
    return "Campaign didnot reach its goal";
  }
}
