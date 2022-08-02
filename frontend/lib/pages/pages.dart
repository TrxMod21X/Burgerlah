import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/base.dart';
import 'package:food_delivery/controllers/controllers.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/routes/routes.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:food_delivery/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/address_model.dart';

part 'splash/splash_page.dart';

part 'home/main_food_page.dart';
part 'home/food_page_body.dart';
part 'home/home_page.dart';

part 'food/popular_food_detail.dart';
part 'food/recommended_food_detail.dart';

part 'cart/cart_page.dart';
part 'cart/cart_history.dart';

part 'profile/profile_page.dart';

part 'auth/sign_up_page.dart';
part 'auth/sign_in_page.dart';

part 'address/add_address_page.dart';
part 'address/pick_address_map.dart';