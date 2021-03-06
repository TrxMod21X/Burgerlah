import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

part 'api/api_client.dart';

part 'repository/popular_product_repo.dart';
part 'repository/recommended_product_repo.dart';
part 'repository/cart_repo.dart';
part 'repository/auth_repo.dart';
part 'repository/user_repo.dart';
part 'repository/location_repo.dart';