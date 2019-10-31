//import 'package:daily_drive/location.dart';
//import 'package:location/location.dart';
//
//class LocationService {
//  UserLocation _currentLocation;
//
//  var location = Location();
//
//  Future<UserLocation> getLocation() async {
//    try {
//      var userLocation = await location.getLocation();
//      _currentLocation = UserLocation(
//        latitude: userLocation.latitude,
//        longitude: userLocation.longitude,
//      );
//    } on Exception catch (e) {
//      print('Could not get location: ${e.toString()}');
//    }
//
//    return _currentLocation;
//  }
//}
