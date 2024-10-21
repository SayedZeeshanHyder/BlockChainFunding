import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gloriuspurpose/services/sharedprefsservice.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService
{

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final storage = FirebaseStorage.instance.ref("profilePhotos");

  static Future<bool> signInUsingGoogle()async{

    final googleUser = await _googleSignIn.signIn();
    if(googleUser == null){
      return false;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = await _auth.signInWithCredential(credential);
    if(user.user == null){
      return false;
    }
    await SharedPreferencesServices.setGoogleSignIn(true);
    return true;
  }

  static logOut()async{
    await _googleSignIn.signOut();
    await _auth.signOut();
    await SharedPreferencesServices.setGoogleSignIn(false);
  }

  static Future<bool> createAccountUsingEmail(String email,String password,String imgPath)async{

    final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if(user.user == null){
      return false;
    }
    final uploadedPhoto = await uploadingProfileUrl(imgPath);
    await user.user!.updatePhotoURL(uploadedPhoto);
    return true;
  }

  static Future<String> uploadingProfileUrl(String imgPath)async{

    if(imgPath != "") {
      final upload = await storage.child("UserUid").child(_auth.currentUser!.uid).putFile(File(imgPath),);
      final String downloadUrl = await upload.ref.getDownloadURL();
      return downloadUrl;
    }

    return "Did not Pick Image";

  }

  static Future<bool> signUpUsingEmail(String email,String password)async{

    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if(user.user == null){
      return false;
    }
    return true;
  }

}