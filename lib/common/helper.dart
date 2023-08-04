import 'dart:convert' as convert;
import 'dart:io' as io;


import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'package:doctors_appointments/app/models/address_model.dart' as addressModel;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:location_geocoder/location_geocoder.dart';


import '../app/services/settings_service.dart';
import 'ui.dart';

class Helper {
  DateTime? currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static Future<dynamic> getFilesInDirectory(String path) async {
    var files = io.Directory(path).listSync();
    print(files);
    // return rootBundle.(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "Tap again to leave!".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
  static PhoneNumber getPhoneNumber(String _phoneNumber) {
    if (_phoneNumber.length > 4) {
      _phoneNumber = _phoneNumber.replaceAll(' ', '');
      String dialCode1 = _phoneNumber.substring(1, 2);
      String dialCode2 = _phoneNumber.substring(1, 3);
      String dialCode3 = _phoneNumber.substring(1, 4);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].dialCode == dialCode1) {
          return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode1, number: _phoneNumber.substring(2));
        } else if (countries[i].dialCode == dialCode2) {
          return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode2, number: _phoneNumber.substring(3));
        } else if (countries[i].dialCode == dialCode3) {
          return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode3, number: _phoneNumber.substring(4));
        }
      }
    }
    return new PhoneNumber(countryISOCode: Get.find<SettingsService>().setting.value.defaultCountryCode ?? '', countryCode: '1', number: '');
  }


  static Future<addressModel.Address?> getCurrentLocation() async {
    LocationPermission? permission;
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      final location = await Geolocator.getCurrentPosition();
      final LocatitonGeocoder geocoder = LocatitonGeocoder(Get.find<SettingsService>().setting.value.googleMapsKey ?? '');
      final address = await geocoder.findAddressesFromCoordinates(Coordinates(location.latitude, location.longitude));
      return addressModel.Address(latitude: location.latitude, longitude: location.longitude,address: address.first.addressLine);
    } else {
      return null;
    }
  }

}
