import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gloriuspurpose/controllers/bottomnavcontroller.dart';
import 'package:gloriuspurpose/screens/blog/writeblogscreen.dart';
import 'package:gloriuspurpose/screens/createcampaign/introcreation.dart';
import 'package:gloriuspurpose/services/notificationservices/localnotificationservice.dart';
import 'package:gloriuspurpose/colors.dart';
import 'package:gloriuspurpose/screens/home/homescreen.dart';
import 'package:gloriuspurpose/screens/profile/profile.dart';

class NavigationScreen extends StatefulWidget {
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final bottomNavController = Get.put(BottomNavController());

  List<Widget> pages = [
    HomeScreen(),
    IntroCreation(),
    WriteBlogScreen(),
    Profile(),
  ];

  String appTitle = "Home";

  @override
  void initState() {
    super.initState();
    NotificationService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: ()async{
        if(bottomNavController.currentIndex.value == 0){
          print("BackPressed at Home");
        }else{
          bottomNavController.currentIndex.value = 0;
          bottomNavController.appBarTitle.value = "Home";
        }
        return false;
      },
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: myGreen,
          child: Column(
            children: [

              Container(
                height: size.height*0.3,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: NetworkImage('https://assets.smfgindiacredit.com/sites/default/files/Options-to-Raise-Funds-For-Business-In-India.jpg?VersionId=5H52e0H6AwpYoaDNZWMzXNlpOnAm.8W2'),fit: BoxFit.cover),
                ),
              ),
              Divider(color: Colors.white,),

              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.info),
                title: Text("About Us"),
              ),

              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.phone),
                title: Text("Contact Us"),
              ),

              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: Icon(Icons.web),
                title: Text("Visit our Website"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: myGreen,
          foregroundColor: Colors.white,
          title: Obx(()=> Text(bottomNavController.appBarTitle.value),),
          centerTitle: true,
        ),
        body: Obx(()=> pages[bottomNavController.currentIndex.value]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: myGreen,
          tooltip: 'Increment',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: startScan,
          child: const Icon(
            Icons.qr_code_scanner,
            size: 28,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: myGreen,
          notchMargin: 5,
          shadowColor: Colors.transparent,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  bottomNavController.currentIndex.value = 0;
                  bottomNavController.appBarTitle.value = "Home";
                },
                icon: Obx(
                  ()=> Icon(
                    Icons.home,
                    color: bottomNavController.currentIndex.value == 0 ? Colors.white : Colors.grey.shade400,
                    size: 30,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomNavController.currentIndex.value = 1;
                  bottomNavController.appBarTitle.value = "Raise Campaign";
                },
                icon: Obx(
                  ()=> Icon(
                    Icons.money,
                    color: bottomNavController.currentIndex.value == 1 ? Colors.white : Colors.grey.shade400,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {
                  bottomNavController.currentIndex.value = 2;
                  bottomNavController.appBarTitle.value = "Blogs";
                },
                icon: Obx(
                  ()=> Icon(
                    Icons.edit,
                    color: bottomNavController.currentIndex.value == 2 ? Colors.white : Colors.grey.shade400,
                    size: 30,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomNavController.currentIndex.value = 3;
                  bottomNavController.appBarTitle.value = "Profile";
                },
                icon: Obx(
                  ()=> Icon(
                    Icons.person,
                    color: bottomNavController.currentIndex.value == 3 ? Colors.white : Colors.grey.shade400,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  startScan() async {
    print("started Scan");
    /*final scanQr =  await scanner.scan();
    if (scanQr != null) {
      print(scanQr);
    } else {
      print("Some Error Occured");
    }*/
  }
}
