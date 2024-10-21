import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SharedPreferencesServices
{

  static final messaging = FirebaseMessaging.instance;

  static late SharedPreferences prefs;

  static initializePrefs() async{
    prefs = await SharedPreferences.getInstance();
    print("Initialized Shared Preferences");
  }

  static Future<bool> storeKeys(String privateKey,String accountAddress) async{
    await prefs.setString("privateKey", privateKey);
    await prefs.setString("accountAddress", accountAddress);
    print("Keys Successfully Stored");
    return true;
  }

  static String getPrivateKey() {
    String privateKey = prefs.getString("privateKey") ?? "";
    return privateKey;
  }

  static String getAccountAddress() {
    String accountAddress = prefs.getString("accountAddress") ?? "";
    return accountAddress;
  }

  static storeDeviceToken() async{
    final String deviceToken = await messaging.getToken() ?? "";
    prefs.setString("deviceToken", deviceToken);
    print("Device Token Successfully Stored");
    print("Device Token = $deviceToken");
  }

  static String getDeviceToken() {
    final String deviceToken = prefs.getString("deviceToken") ?? "";
    return deviceToken;
  }

  static setGoogleSignIn(bool signInStatus) async{
    await prefs.setBool("googleAuth",signInStatus);
  }

  static bool getGoogleSignIn(){
    return prefs.getBool("googleAuth") ?? false;
  }


}