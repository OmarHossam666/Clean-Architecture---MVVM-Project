import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInformation {
  Future<bool> get isConnected;
}

class NetworkInformationImplementation implements NetworkInformation {
  NetworkInformationImplementation({required this.internetConnectionChecker});

  final InternetConnectionChecker internetConnectionChecker;

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
