import 'package:fake_store/models/delivery_model.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {

  // delivery list
  List<DeliveryModel> deliveryList = deliveryData;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // select the first delivery method by default
  //   if (deliveryList.isNotEmpty) {
  //     deliveryList[0].isSelected = true;
  //   }
  // }

  // select delivery
  void selectDeliveryMethod(int index) {
    // Unselect all payment methods
    for (var delivery in deliveryList) {
      delivery.isSelected = false;
    }
    
    // Select the chosen delivery method
    deliveryList[index].isSelected = true;

    // Update the UI
    update();
  }

  // Get the selected delivery method
  DeliveryModel? getSelectedDelivery() {
    return deliveryList.firstWhereOrNull((delivery) => delivery.isSelected);
  }

}