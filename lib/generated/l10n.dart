// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Join us as a `
  String get join {
    return Intl.message(
      'Join us as a ',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get patient {
    return Intl.message(
      'Patient',
      name: 'patient',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy`
  String get pharmacy {
    return Intl.message(
      'Pharmacy',
      name: 'pharmacy',
      desc: '',
      args: [],
    );
  }

  /// `Lets Get You In`
  String get getin {
    return Intl.message(
      'Lets Get You In',
      name: 'getin',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcome {
    return Intl.message(
      'Welcome Back',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get regester {
    return Intl.message(
      'Register Now',
      name: 'regester',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Information Below`
  String get info {
    return Intl.message(
      'Enter Your Information Below',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already {
    return Intl.message(
      'Already have an account?',
      name: 'already',
      desc: '',
      args: [],
    );
  }

  /// `You dont have an account `
  String get dont {
    return Intl.message(
      'You dont have an account ',
      name: 'dont',
      desc: '',
      args: [],
    );
  }

  /// `please enter your phone number`
  String get enterphone {
    return Intl.message(
      'please enter your phone number',
      name: 'enterphone',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy Name`
  String get pharname {
    return Intl.message(
      'Pharmacy Name',
      name: 'pharname',
      desc: '',
      args: [],
    );
  }

  /// `please enter the pharmacy name`
  String get enterpharname {
    return Intl.message(
      'please enter the pharmacy name',
      name: 'enterpharname',
      desc: '',
      args: [],
    );
  }

  /// `email format is incorrect`
  String get wrongemail {
    return Intl.message(
      'email format is incorrect',
      name: 'wrongemail',
      desc: '',
      args: [],
    );
  }

  /// `MediQuick`
  String get appname {
    return Intl.message(
      'MediQuick',
      name: 'appname',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Medicine name`
  String get searcherror {
    return Intl.message(
      'Please enter Medicine name',
      name: 'searcherror',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacies`
  String get pharmacies {
    return Intl.message(
      'Pharmacies',
      name: 'pharmacies',
      desc: '',
      args: [],
    );
  }

  /// `categories`
  String get categories {
    return Intl.message(
      'categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Antibiotics`
  String get Antibiotics {
    return Intl.message(
      'Antibiotics',
      name: 'Antibiotics',
      desc: '',
      args: [],
    );
  }

  /// `Tuberculosis`
  String get tuberculosis {
    return Intl.message(
      'Tuberculosis',
      name: 'tuberculosis',
      desc: '',
      args: [],
    );
  }

  /// `Galand diseases`
  String get galanddiseases {
    return Intl.message(
      'Galand diseases',
      name: 'galanddiseases',
      desc: '',
      args: [],
    );
  }

  /// `Blood diseases`
  String get blooddiseases {
    return Intl.message(
      'Blood diseases',
      name: 'blooddiseases',
      desc: '',
      args: [],
    );
  }

  /// `torhinolaryngology`
  String get Otorhinolaryngology {
    return Intl.message(
      'torhinolaryngology',
      name: 'Otorhinolaryngology',
      desc: '',
      args: [],
    );
  }

  /// `Pressure disease`
  String get pressuredisease {
    return Intl.message(
      'Pressure disease',
      name: 'pressuredisease',
      desc: '',
      args: [],
    );
  }

  /// `Diabetes`
  String get diabetes {
    return Intl.message(
      'Diabetes',
      name: 'diabetes',
      desc: '',
      args: [],
    );
  }

  /// `Immune diseases`
  String get immunediseases {
    return Intl.message(
      'Immune diseases',
      name: 'immunediseases',
      desc: '',
      args: [],
    );
  }

  /// `Heart and vascular diseses`
  String get heartvasculardiseses {
    return Intl.message(
      'Heart and vascular diseses',
      name: 'heartvasculardiseses',
      desc: '',
      args: [],
    );
  }

  /// `Kidney diseases`
  String get kidneydiseases {
    return Intl.message(
      'Kidney diseases',
      name: 'kidneydiseases',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `How to use`
  String get use {
    return Intl.message(
      'How to use',
      name: 'use',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get cart {
    return Intl.message(
      'Add to cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorite {
    return Intl.message(
      'Favorites',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Payment Summary`
  String get PaymentSumary {
    return Intl.message(
      'Payment Summary',
      name: 'PaymentSumary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fee`
  String get deliveryfee {
    return Intl.message(
      'Delivery Fee',
      name: 'deliveryfee',
      desc: '',
      args: [],
    );
  }

  /// `Service Fee`
  String get Servicefee {
    return Intl.message(
      'Service Fee',
      name: 'Servicefee',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalamount {
    return Intl.message(
      'Total Amount',
      name: 'totalamount',
      desc: '',
      args: [],
    );
  }

  /// `Add More`
  String get addmore {
    return Intl.message(
      'Add More',
      name: 'addmore',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get Checkout {
    return Intl.message(
      'Checkout',
      name: 'Checkout',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalinfo {
    return Intl.message(
      'Personal Information',
      name: 'personalinfo',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryaddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryaddress',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `please enter your name`
  String get entername {
    return Intl.message(
      'please enter your name',
      name: 'entername',
      desc: '',
      args: [],
    );
  }

  /// `please enter your email`
  String get enteremail {
    return Intl.message(
      'please enter your email',
      name: 'enteremail',
      desc: '',
      args: [],
    );
  }

  /// `please enter your address`
  String get enteraddress {
    return Intl.message(
      'please enter your address',
      name: 'enteraddress',
      desc: '',
      args: [],
    );
  }

  /// `please enter your password`
  String get enterpassword {
    return Intl.message(
      'please enter your password',
      name: 'enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `New Medicine `
  String get adddrug {
    return Intl.message(
      'New Medicine ',
      name: 'adddrug',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name`
  String get drugname {
    return Intl.message(
      'Medicine Name',
      name: 'drugname',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Front Image`
  String get frontImage {
    return Intl.message(
      'Medicine Front Image',
      name: 'frontImage',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Rear Image`
  String get backImage {
    return Intl.message(
      'Medicine Rear Image',
      name: 'backImage',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Is a Perscription Needed`
  String get Perscription {
    return Intl.message(
      'Is a Perscription Needed',
      name: 'Perscription',
      desc: '',
      args: [],
    );
  }

  /// `Description In Arabic`
  String get descriptionarabic {
    return Intl.message(
      'Description In Arabic',
      name: 'descriptionarabic',
      desc: '',
      args: [],
    );
  }

  /// `Description In English`
  String get descriptionenglish {
    return Intl.message(
      'Description In English',
      name: 'descriptionenglish',
      desc: '',
      args: [],
    );
  }

  /// `How To Use In Arabic`
  String get usearabic {
    return Intl.message(
      'How To Use In Arabic',
      name: 'usearabic',
      desc: '',
      args: [],
    );
  }

  /// `How To Use In English`
  String get useenglish {
    return Intl.message(
      'How To Use In English',
      name: 'useenglish',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Quantatity`
  String get quantity {
    return Intl.message(
      'Quantatity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy Name`
  String get pharmacyname {
    return Intl.message(
      'Pharmacy Name',
      name: 'pharmacyname',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Main Information`
  String get main {
    return Intl.message(
      'Main Information',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `please uploaud your perscription image`
  String get uploadperscription {
    return Intl.message(
      'please uploaud your perscription image',
      name: 'uploadperscription',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get status {
    return Intl.message(
      'Order Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Please uploud the pharmacy health permission`
  String get permission {
    return Intl.message(
      'Please uploud the pharmacy health permission',
      name: 'permission',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get request {
    return Intl.message(
      'Send Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Already got the approval email??`
  String get Aproval {
    return Intl.message(
      'Already got the approval email??',
      name: 'Aproval',
      desc: '',
      args: [],
    );
  }

  /// `Request To Join As A Pharmacy`
  String get sendrequest {
    return Intl.message(
      'Request To Join As A Pharmacy',
      name: 'sendrequest',
      desc: '',
      args: [],
    );
  }

  /// `Set Your Address`
  String get setaddress {
    return Intl.message(
      'Set Your Address',
      name: 'setaddress',
      desc: '',
      args: [],
    );
  }

  /// `Set Current Location`
  String get currentlocation {
    return Intl.message(
      'Set Current Location',
      name: 'currentlocation',
      desc: '',
      args: [],
    );
  }

  /// `There are no products yet in this category`
  String get noproducts {
    return Intl.message(
      'There are no products yet in this category',
      name: 'noproducts',
      desc: '',
      args: [],
    );
  }

  /// `There are no saved products yet`
  String get nosaved {
    return Intl.message(
      'There are no saved products yet',
      name: 'nosaved',
      desc: '',
      args: [],
    );
  }

  /// `There are no confirmed orders yet`
  String get noorders {
    return Intl.message(
      'There are no confirmed orders yet',
      name: 'noorders',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been placed Successfuly`
  String get placeorder {
    return Intl.message(
      'Your order has been placed Successfuly',
      name: 'placeorder',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Product Added Successfuly to your cart`
  String get addproduct {
    return Intl.message(
      'Product Added Successfuly to your cart',
      name: 'addproduct',
      desc: '',
      args: [],
    );
  }

  /// `confirm your pending cart first`
  String get pendingcart {
    return Intl.message(
      'confirm your pending cart first',
      name: 'pendingcart',
      desc: '',
      args: [],
    );
  }

  /// `View Cart`
  String get viewcart {
    return Intl.message(
      'View Cart',
      name: 'viewcart',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Select Photo Source`
  String get photosource {
    return Intl.message(
      'Select Photo Source',
      name: 'photosource',
      desc: '',
      args: [],
    );
  }

  /// `Delete Order`
  String get deleteorder {
    return Intl.message(
      'Delete Order',
      name: 'deleteorder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to withdrow your order After it has been confirmed??!`
  String get deletewarnning {
    return Intl.message(
      'Are you sure you want to withdrow your order After it has been confirmed??!',
      name: 'deletewarnning',
      desc: '',
      args: [],
    );
  }

  /// `Search Results`
  String get searchresults {
    return Intl.message(
      'Search Results',
      name: 'searchresults',
      desc: '',
      args: [],
    );
  }

  /// `No search results found`
  String get nosearch {
    return Intl.message(
      'No search results found',
      name: 'nosearch',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pendingorder {
    return Intl.message(
      'Pending',
      name: 'pendingorder',
      desc: '',
      args: [],
    );
  }

  /// `Delivery is in progress`
  String get delivery {
    return Intl.message(
      'Delivery is in progress',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get done {
    return Intl.message(
      'Delivered',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Declined`
  String get declined {
    return Intl.message(
      'Declined',
      name: 'declined',
      desc: '',
      args: [],
    );
  }

  /// `please check your email \n to know why your order has been declined`
  String get reasons {
    return Intl.message(
      'please check your email \n to know why your order has been declined',
      name: 'reasons',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product??!`
  String get deleteproduct {
    return Intl.message(
      'Are you sure you want to delete this product??!',
      name: 'deleteproduct',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfuly`
  String get updated {
    return Intl.message(
      'Updated Successfuly',
      name: 'updated',
      desc: '',
      args: [],
    );
  }

  /// `order has been accepted Successfuly`
  String get acceptorder {
    return Intl.message(
      'order has been accepted Successfuly',
      name: 'acceptorder',
      desc: '',
      args: [],
    );
  }

  /// `order has been declined Successfuly`
  String get declineorder {
    return Intl.message(
      'order has been declined Successfuly',
      name: 'declineorder',
      desc: '',
      args: [],
    );
  }

  /// `why do you want to decline this order???`
  String get declinereason {
    return Intl.message(
      'why do you want to decline this order???',
      name: 'declinereason',
      desc: '',
      args: [],
    );
  }

  /// `Difficulties in the delivery process`
  String get deliverycomplications {
    return Intl.message(
      'Difficulties in the delivery process',
      name: 'deliverycomplications',
      desc: '',
      args: [],
    );
  }

  /// `The perscription is incorrect`
  String get perscriptionisincorect {
    return Intl.message(
      'The perscription is incorrect',
      name: 'perscriptionisincorect',
      desc: '',
      args: [],
    );
  }

  /// `The product is unavailable`
  String get drugnotavailable {
    return Intl.message(
      'The product is unavailable',
      name: 'drugnotavailable',
      desc: '',
      args: [],
    );
  }

  /// `please set your address for delivery first!!!`
  String get addresserror {
    return Intl.message(
      'please set your address for delivery first!!!',
      name: 'addresserror',
      desc: '',
      args: [],
    );
  }

  /// `are you sure you want to remove this cart??`
  String get deletecart {
    return Intl.message(
      'are you sure you want to remove this cart??',
      name: 'deletecart',
      desc: '',
      args: [],
    );
  }

  /// `you removed all of the carts items please add new items or delete the cart it self!!`
  String get noitems {
    return Intl.message(
      'you removed all of the carts items please add new items or delete the cart it self!!',
      name: 'noitems',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to Signup`
  String get continuesignup {
    return Intl.message(
      'Proceed to Signup',
      name: 'continuesignup',
      desc: '',
      args: [],
    );
  }

  /// `check your email because you havent been accepted yet!!!`
  String get emailcheck {
    return Intl.message(
      'check your email because you havent been accepted yet!!!',
      name: 'emailcheck',
      desc: '',
      args: [],
    );
  }

  /// `you have already sent your request before... please wait for the responde email!!`
  String get emailwait {
    return Intl.message(
      'you have already sent your request before... please wait for the responde email!!',
      name: 'emailwait',
      desc: '',
      args: [],
    );
  }

  /// `Full Page View`
  String get fullpage {
    return Intl.message(
      'Full Page View',
      name: 'fullpage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
