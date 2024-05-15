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

  /// `Pharma`
  String get appname {
    return Intl.message(
      'Pharma',
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
