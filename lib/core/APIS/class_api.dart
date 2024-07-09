// ignore_for_file: constant_identifier_names

import 'dart:convert';


class API {

  static const hostConnection =
      'http://10.0.2.2:8000';
  //'http://192.168.1.11/eco';
  // 'http://192.168.8.100/eco';
  //'http://192.168.8.100/eco';
  // 'http://192.168.1.14/eco';
  static const hostConnectionUser = '$hostConnection/user';
  static const validateEmail = '$hostConnection/user/validate_email.php';
  static const signup = '$hostConnection/users';
  static const updateData= '$hostConnection/users';
  static const GetUserData= '$hostConnection/users';
  static const login = '$hostConnection/user/login.php';
  static const ChangePassword = '$hostConnection/user/change_pass.php';
  static const ChangeEmail = '$hostConnection/user/change_email.php';
  static const ChangeName = '$hostConnection/user/change_name.php';
  static const admin_login = '$hostConnection/admin/login.php';
  static const adminGetAllOrders = "$hostConnection/admin/read_orders.php";
  static const SellerAllOrders = "$hostConnection/admin/get_seller_orders.php";
  static const SellerAllProducts = "$hostConnection/admin/seller_items.php";
  static const AdminRegister = '$hostConnection/admin/register.php';
  static const SendMsg = '$hostConnection/msgs/user_send_msg.php';
  static const AllMsgs = '$hostConnection/msgs/get_msgs.php';
  static const Response = '$hostConnection/msgs/response.php';
  //upload new items
  static const uploadItem = '$hostConnection/items/upload.php';
  static const GETUSERMSGS = '$hostConnection/msgs/get_user_msgs.php';

  static const EditItem = '$hostConnection/admin/edit_item.php';
  static const DELETE_ITEM = '$hostConnection/items/delete_item.php';
  //upload new items
  static const StoreItems = '$hostConnection/items/store_item.php';
  static const GetSellerData= "$hostConnection/admin/get_seller_data.php";
  static const GetSellers= "$hostConnection/admin/get_all_stores.php";
  static const DELETESeller= "$hostConnection/admin/delete_seller.php";
  static const DELETESellerItems= "$hostConnection/admin/delete-seller_item.php";
  //clothesItem
  static const GetTrendingProducts = '$hostConnection/clothes/trending.php';
  static const GetAllProducts =  '$hostConnection/clothes/all_items.php';
  static const GetAllAds =  '$hostConnection/ads/read_ads.php';

  static const addToCart = '$hostConnection/cart/add.php';
  static const deleteFromCart = '$hostConnection/cart/delete.php';
  static const RateOrder = '$hostConnection/order/rate.php';
  static const getCart = '$hostConnection/cart/read.php';
  static const updateQuantity = '$hostConnection/cart/update.php';
  static const addFav = '$hostConnection/fav/add.php';
  static const deleteFav = '$hostConnection/fav/delete.php';
  static const validateFav = '$hostConnection/fav/validate.php';
  static const getFav = '$hostConnection/fav/read.php';

  static const SEARCH = '$hostConnection/items/search.php';
  static const SEARCHSELLERS = '$hostConnection/items/search_sellers.php';
  // static const addToCart = "$hostCart/add.php";
  static const getCartList = "$hostConnection/cart/read.php";
  static const deleteSelectedItemsFromCartList = "$hostConnection/cart/delete.php";
  static const updateItemInCartList = "$hostConnection/cart/update.php";
  static const addOrder = "$hostConnection/order/add.php";
  static const hostImages = "$hostConnection/transactions_proof_images/";
  static const readOrders = "$hostConnection/order/read.php";
  static const updateStatus = "$hostConnection/order/update_status.php";
  static const CancelOrder= "$hostConnection/order/cancel_order.php";
  static const HistoryOrders = "$hostConnection/order/read_history.php";
  static const Pay = "$hostConnection/pay/pay.php";
  static const GetPay = "$hostConnection/pay/get_pay.php";
  static const GetMode = "$hostConnection/pay/mode.php";
  static const GetProductById = "$hostConnection/order/get_product_id.php";
  static const GetCat = "$hostConnection/cat/get_cat.php";
  static const GetCatItems = "$hostConnection/cat/get_items_by_cat.php";
}
//192.168.1.10
//255.255.255.0 mask
//192.168.1.1

String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'elbldappkey:elbld123@2023'));

Map<String, String> myheaders = {
  'authorization': basicAuth
};
