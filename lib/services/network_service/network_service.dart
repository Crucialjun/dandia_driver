import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dandia_driver/services/network_service/i_network_service.dart';

class NetworkService implements INetworkService {
  @override
  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
