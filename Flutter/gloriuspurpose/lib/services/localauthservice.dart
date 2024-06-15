import 'package:local_auth/local_auth.dart';

class LocalAuthService{

  static LocalAuthentication localAuthentication = LocalAuthentication();

  static checkForBioMetric()async{
    final bool canCheckBioMetrics = await localAuthentication.canCheckBiometrics;
  }

  static viewAllBiometrics() async{
    final List allBiometrics = await localAuthentication.getAvailableBiometrics();
  }

  static checkIfDeviceSupported() async{
    final bool isDeviceSupported = await localAuthentication.isDeviceSupported();
  }

  static Future<bool> authenticateLocalAuth() async{
    try {
      final bool didAuthenticate = await localAuthentication.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      return didAuthenticate;
      // ···
    } catch(e) {
      print(e);
      return false;
    }
  }
}