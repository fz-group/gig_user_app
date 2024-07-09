
import 'package:get/get.dart';
import 'package:gic_client/Features/Order/presentation/Manager/order_controller.dart';

class MyBinding implements Bindings{
  @override
  void dependencies() {
     Get.lazyPut(() => OrderController(),fenix: true);
  }
}