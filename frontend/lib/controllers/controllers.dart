import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'popular_product_controllers.dart';
part 'recommended_product_controller.dart';
part 'cart_controller.dart';
part 'auth_controller.dart';
part 'user_controller.dart';
part 'location_controller.dart';