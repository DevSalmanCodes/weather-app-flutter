import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';

class LocationService {
  final location.Location _location = location.Location();

  Future<location.LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    location.PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == location.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != location.PermissionStatus.granted) {
        throw Exception('Location permissions are denied.');
      }
    }

    return await _location.getLocation();
  }

  Future<String> getCityName() async {
    try {
      location.LocationData locationData = await getCurrentLocation();
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        return placemarks.first.locality ?? "Unknown City";
      } else {
        return "City not found";
      }
    } catch (e) {
      throw Exception('Failed to get city name: $e');
    }
  }
}
