
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LocationResult> getLocationPicker(BuildContext  context) async {
  LocationResult result =  await LocationPicker.pickLocation(context, "AIzaSyCUdsOTOLRGowHCKl_zMK6Egtr0ixeRd-U");

  return result ;
}