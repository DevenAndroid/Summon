import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../repositories/user_profile_repository.dart';

class EditProductsController extends GetxController {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController qtyTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController minQtyController = TextEditingController();
  final TextEditingController maxQtyController = TextEditingController();
}
