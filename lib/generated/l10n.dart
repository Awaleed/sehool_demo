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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Guest`
  String get login_as_guest {
    return Intl.message(
      'Guest',
      name: 'login_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `the entered code is invalid`
  String get the_entered_code_is_invalid {
    return Intl.message(
      'the entered code is invalid',
      name: 'the_entered_code_is_invalid',
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

  /// `Thank you for registering. Your account will be activated after reviewing the attachments ..`
  String get account_not_active_msg {
    return Intl.message(
      'Thank you for registering. Your account will be activated after reviewing the attachments ..',
      name: 'account_not_active_msg',
      desc: '',
      args: [],
    );
  }

  /// `Choose an association`
  String get choose_an_association {
    return Intl.message(
      'Choose an association',
      name: 'choose_an_association',
      desc: '',
      args: [],
    );
  }

  /// `Please choose an association`
  String get please_choose_an_association {
    return Intl.message(
      'Please choose an association',
      name: 'please_choose_an_association',
      desc: '',
      args: [],
    );
  }

  /// `Kingdom of Saudi Arabia, Riyadh`
  String get kingdom_of_saudi_arabia_riyadh {
    return Intl.message(
      'Kingdom of Saudi Arabia, Riyadh',
      name: 'kingdom_of_saudi_arabia_riyadh',
      desc: '',
      args: [],
    );
  }

  /// `Contact us on all social networks at`
  String get contact_us_on_all_social_networks_at {
    return Intl.message(
      'Contact us on all social networks at',
      name: 'contact_us_on_all_social_networks_at',
      desc: '',
      args: [],
    );
  }

  /// `Your notes on the order`
  String get your_notes_on_the_order {
    return Intl.message(
      'Your notes on the order',
      name: 'your_notes_on_the_order',
      desc: '',
      args: [],
    );
  }

  /// `Designed by Panda, Khartoum - Sudan`
  String get about_msg_p2 {
    return Intl.message(
      'Designed by Panda, Khartoum - Sudan',
      name: 'about_msg_p2',
      desc: '',
      args: [],
    );
  }

  /// `Sehool app version`
  String get about_msg_p1 {
    return Intl.message(
      'Sehool app version',
      name: 'about_msg_p1',
      desc: '',
      args: [],
    );
  }

  /// `The chosen method of payment is not counted under the Neqaty program`
  String get not_in_my_points_program {
    return Intl.message(
      'The chosen method of payment is not counted under the Neqaty program',
      name: 'not_in_my_points_program',
      desc: '',
      args: [],
    );
  }

  /// `Who are we`
  String get who_are_we {
    return Intl.message(
      'Who are we',
      name: 'who_are_we',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, the quantity is not enough`
  String get qyt_not_enough_message {
    return Intl.message(
      'Sorry, the quantity is not enough',
      name: 'qyt_not_enough_message',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this product is not available`
  String get not_available_message {
    return Intl.message(
      'Sorry, this product is not available',
      name: 'not_available_message',
      desc: '',
      args: [],
    );
  }

  /// `The selected payment method is not currently active, please choose another method.`
  String get payment_not_active {
    return Intl.message(
      'The selected payment method is not currently active, please choose another method.',
      name: 'payment_not_active',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Name of the address of the home, rest .. etc.`
  String get address_title {
    return Intl.message(
      'Name of the address of the home, rest .. etc.',
      name: 'address_title',
      desc: '',
      args: [],
    );
  }

  /// `Saved addresses`
  String get saved_addresses {
    return Intl.message(
      'Saved addresses',
      name: 'saved_addresses',
      desc: '',
      args: [],
    );
  }

  /// `The driver`
  String get driver {
    return Intl.message(
      'The driver',
      name: 'driver',
      desc: '',
      args: [],
    );
  }

  /// `Buy another item`
  String get choose_another_item {
    return Intl.message(
      'Buy another item',
      name: 'choose_another_item',
      desc: '',
      args: [],
    );
  }

  /// `You cannot order less than this quantity. Contact your administrator for more information`
  String get delivery_qyt_msg {
    return Intl.message(
      'You cannot order less than this quantity. Contact your administrator for more information',
      name: 'delivery_qyt_msg',
      desc: '',
      args: [],
    );
  }

  /// `), and you will receive a letter from the association confirming receipt of the order after delivery`
  String get org_delivery_msg_p2 {
    return Intl.message(
      '), and you will receive a letter from the association confirming receipt of the order after delivery',
      name: 'org_delivery_msg_p2',
      desc: '',
      args: [],
    );
  }

  /// `This request will be delivered with our knowledge of the association (`
  String get org_delivery_msg_p1 {
    return Intl.message(
      'This request will be delivered with our knowledge of the association (',
      name: 'org_delivery_msg_p1',
      desc: '',
      args: [],
    );
  }

  /// `Add recipient address`
  String get add_recipient_address {
    return Intl.message(
      'Add recipient address',
      name: 'add_recipient_address',
      desc: '',
      args: [],
    );
  }

  /// `My points`
  String get my_points {
    return Intl.message(
      'My points',
      name: 'my_points',
      desc: '',
      args: [],
    );
  }

  /// `Net bill`
  String get net_bill {
    return Intl.message(
      'Net bill',
      name: 'net_bill',
      desc: '',
      args: [],
    );
  }

  /// `Discounted total`
  String get discounted_total {
    return Intl.message(
      'Discounted total',
      name: 'discounted_total',
      desc: '',
      args: [],
    );
  }

  /// `Customer address`
  String get customer_address {
    return Intl.message(
      'Customer address',
      name: 'customer_address',
      desc: '',
      args: [],
    );
  }

  /// `Request received`
  String get request_received {
    return Intl.message(
      'Request received',
      name: 'request_received',
      desc: '',
      args: [],
    );
  }

  /// `Under treatment`
  String get under_treatment {
    return Intl.message(
      'Under treatment',
      name: 'under_treatment',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `The recipient is someone else`
  String get the_recipient_is_someone_else {
    return Intl.message(
      'The recipient is someone else',
      name: 'the_recipient_is_someone_else',
      desc: '',
      args: [],
    );
  }

  /// `Association`
  String get association {
    return Intl.message(
      'Association',
      name: 'association',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Coupon name`
  String get coupon_name {
    return Intl.message(
      'Coupon name',
      name: 'coupon_name',
      desc: '',
      args: [],
    );
  }

  /// `Sorry we can not deliver to this area`
  String get sorry_we_can_not_deliver_to_this_area {
    return Intl.message(
      'Sorry we can not deliver to this area',
      name: 'sorry_we_can_not_deliver_to_this_area',
      desc: '',
      args: [],
    );
  }

  /// `Choose an image`
  String get choose_an_image {
    return Intl.message(
      'Choose an image',
      name: 'choose_an_image',
      desc: '',
      args: [],
    );
  }

  /// `Commercial register`
  String get commercial_register {
    return Intl.message(
      'Commercial register',
      name: 'commercial_register',
      desc: '',
      args: [],
    );
  }

  /// `Association name`
  String get association_name {
    return Intl.message(
      'Association name',
      name: 'association_name',
      desc: '',
      args: [],
    );
  }

  /// `Association official`
  String get association_official {
    return Intl.message(
      'Association official',
      name: 'association_official',
      desc: '',
      args: [],
    );
  }

  /// `Official number`
  String get official_number {
    return Intl.message(
      'Official number',
      name: 'official_number',
      desc: '',
      args: [],
    );
  }

  /// `Applicant name`
  String get applicant_name {
    return Intl.message(
      'Applicant name',
      name: 'applicant_name',
      desc: '',
      args: [],
    );
  }

  /// `Charities discount`
  String get charities_discount {
    return Intl.message(
      'Charities discount',
      name: 'charities_discount',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message(
      'Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message(
      'Remember me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  /// `Back to shopping`
  String get back_to_shopping {
    return Intl.message(
      'Back to shopping',
      name: 'back_to_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Discounts`
  String get discounts {
    return Intl.message(
      'Discounts',
      name: 'discounts',
      desc: '',
      args: [],
    );
  }

  /// `Bank name`
  String get bank_name {
    return Intl.message(
      'Bank name',
      name: 'bank_name',
      desc: '',
      args: [],
    );
  }

  /// `Account number`
  String get account_number {
    return Intl.message(
      'Account number',
      name: 'account_number',
      desc: '',
      args: [],
    );
  }

  /// `I-ban number`
  String get iban_number {
    return Intl.message(
      'I-ban number',
      name: 'iban_number',
      desc: '',
      args: [],
    );
  }

  /// `Bank info`
  String get bank_info {
    return Intl.message(
      'Bank info',
      name: 'bank_info',
      desc: '',
      args: [],
    );
  }

  /// `Pinned orders`
  String get pinned_orders {
    return Intl.message(
      'Pinned orders',
      name: 'pinned_orders',
      desc: '',
      args: [],
    );
  }

  /// `Deduction from wallet balance`
  String get deduction_from_wallet_balance {
    return Intl.message(
      'Deduction from wallet balance',
      name: 'deduction_from_wallet_balance',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Check that you filled all fields correctly`
  String get check_that_you_filled_all_fields_correctly {
    return Intl.message(
      'Check that you filled all fields correctly',
      name: 'check_that_you_filled_all_fields_correctly',
      desc: '',
      args: [],
    );
  }

  /// `Write custom message`
  String get write_custom_message {
    return Intl.message(
      'Write custom message',
      name: 'write_custom_message',
      desc: '',
      args: [],
    );
  }

  /// `Occasion`
  String get occasion {
    return Intl.message(
      'Occasion',
      name: 'occasion',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Is gift?`
  String get is_gift {
    return Intl.message(
      'Is gift?',
      name: 'is_gift',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Active employees`
  String get active_employees {
    return Intl.message(
      'Active employees',
      name: 'active_employees',
      desc: '',
      args: [],
    );
  }

  /// `Active offers`
  String get active_offers {
    return Intl.message(
      'Active offers',
      name: 'active_offers',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Add a new address`
  String get add_a_new_address {
    return Intl.message(
      'Add a new address',
      name: 'add_a_new_address',
      desc: '',
      args: [],
    );
  }

  /// `Add coupon`
  String get add_coupon {
    return Intl.message(
      'Add coupon',
      name: 'add_coupon',
      desc: '',
      args: [],
    );
  }

  /// `Add Employee`
  String get add_emp {
    return Intl.message(
      'Add Employee',
      name: 'add_emp',
      desc: '',
      args: [],
    );
  }

  /// `Add a new product`
  String get add_new_product {
    return Intl.message(
      'Add a new product',
      name: 'add_new_product',
      desc: '',
      args: [],
    );
  }

  /// `Add Offer`
  String get add_offer {
    return Intl.message(
      'Add Offer',
      name: 'add_offer',
      desc: '',
      args: [],
    );
  }

  /// `Add Options`
  String get add_options {
    return Intl.message(
      'Add Options',
      name: 'add_options',
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

  /// `Addresses`
  String get addresses {
    return Intl.message(
      'Addresses',
      name: 'addresses',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message(
      'Add to Cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Ad Time`
  String get ad_time {
    return Intl.message(
      'Ad Time',
      name: 'ad_time',
      desc: '',
      args: [],
    );
  }

  /// `All employees`
  String get all_employees {
    return Intl.message(
      'All employees',
      name: 'all_employees',
      desc: '',
      args: [],
    );
  }

  /// `All Menu`
  String get all_menu {
    return Intl.message(
      'All Menu',
      name: 'all_menu',
      desc: '',
      args: [],
    );
  }

  /// `All offers`
  String get all_offers {
    return Intl.message(
      'All offers',
      name: 'all_offers',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get app_language {
    return Intl.message(
      'App Language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get app_settings {
    return Intl.message(
      'App Settings',
      name: 'app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Available quantity`
  String get available_quantity {
    return Intl.message(
      'Available quantity',
      name: 'available_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `By brand`
  String get by_brand {
    return Intl.message(
      'By brand',
      name: 'by_brand',
      desc: '',
      args: [],
    );
  }

  /// `By category`
  String get by_category {
    return Intl.message(
      'By category',
      name: 'by_category',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel the request`
  String get cancel_the_request {
    return Intl.message(
      'Cancel the request',
      name: 'cancel_the_request',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Cart contents`
  String get cart_contents {
    return Intl.message(
      'Cart contents',
      name: 'cart_contents',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cash_on_delivery {
    return Intl.message(
      'Cash on delivery',
      name: 'cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Change account`
  String get change_account {
    return Intl.message(
      'Change account',
      name: 'change_account',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Cites`
  String get cites {
    return Intl.message(
      'Cites',
      name: 'cites',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `City section`
  String get city_section {
    return Intl.message(
      'City section',
      name: 'city_section',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Collected`
  String get collected {
    return Intl.message(
      'Collected',
      name: 'collected',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Payment`
  String get confirm_payment {
    return Intl.message(
      'Confirm Payment',
      name: 'confirm_payment',
      desc: '',
      args: [],
    );
  }

  /// `Conform Password`
  String get conform_password {
    return Intl.message(
      'Conform Password',
      name: 'conform_password',
      desc: '',
      args: [],
    );
  }

  /// `Continue shopping`
  String get continue_shopping {
    return Intl.message(
      'Continue shopping',
      name: 'continue_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Continue to checkout`
  String get continue_to_checkout {
    return Intl.message(
      'Continue to checkout',
      name: 'continue_to_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get current_password {
    return Intl.message(
      'Current password',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get default_address {
    return Intl.message(
      'Default',
      name: 'default_address',
      desc: '',
      args: [],
    );
  }

  /// `Default Credit Card`
  String get default_credit_card {
    return Intl.message(
      'Default Credit Card',
      name: 'default_credit_card',
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

  /// `Delete Address`
  String get delete_address {
    return Intl.message(
      'Delete Address',
      name: 'delete_address',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivery date`
  String get delivery_date {
    return Intl.message(
      'Delivery date',
      name: 'delivery_date',
      desc: '',
      args: [],
    );
  }

  /// `Delivery price`
  String get delivery_price {
    return Intl.message(
      'Delivery price',
      name: 'delivery_price',
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

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Disable`
  String get disable {
    return Intl.message(
      'Disable',
      name: 'disable',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Discounted`
  String get discounted {
    return Intl.message(
      'Discounted',
      name: 'discounted',
      desc: '',
      args: [],
    );
  }

  /// `Discover & Explorer`
  String get discover__explorer {
    return Intl.message(
      'Discover & Explorer',
      name: 'discover__explorer',
      desc: '',
      args: [],
    );
  }

  /// `You do not have any address`
  String get dont_have_any_address {
    return Intl.message(
      'You do not have any address',
      name: 'dont_have_any_address',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any item in the notification list`
  String get dont_have_any_item_in_the_notification_list {
    return Intl.message(
      'Don\'t have any item in the notification list',
      name: 'dont_have_any_item_in_the_notification_list',
      desc: '',
      args: [],
    );
  }

  /// `You do not have any item in the request list`
  String get dont_have_any_item_in_the_orders_list {
    return Intl.message(
      'You do not have any item in the request list',
      name: 'dont_have_any_item_in_the_orders_list',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any item in your cart`
  String get dont_have_any_item_in_your_cart {
    return Intl.message(
      'Don\'t have any item in your cart',
      name: 'dont_have_any_item_in_your_cart',
      desc: '',
      args: [],
    );
  }

  /// `Double click on the food to add it to the cart`
  String get double_click_on_the_food_to_add_it_to_the {
    return Intl.message(
      'Double click on the food to add it to the cart',
      name: 'double_click_on_the_food_to_add_it_to_the',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log out and switch account?`
  String get do_you_want_to_log_out_and_switch_account {
    return Intl.message(
      'Do you want to log out and switch account?',
      name: 'do_you_want_to_log_out_and_switch_account',
      desc: '',
      args: [],
    );
  }

  /// `Driver App`
  String get driver_app {
    return Intl.message(
      'Driver App',
      name: 'driver_app',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
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

  /// `Employee Mail`
  String get emp_mail {
    return Intl.message(
      'Employee Mail',
      name: 'emp_mail',
      desc: '',
      args: [],
    );
  }

  /// `Employee Name`
  String get emp_name {
    return Intl.message(
      'Employee Name',
      name: 'emp_name',
      desc: '',
      args: [],
    );
  }

  /// `Employees`
  String get emps {
    return Intl.message(
      'Employees',
      name: 'emps',
      desc: '',
      args: [],
    );
  }

  /// `Employees Management`
  String get emps_managment {
    return Intl.message(
      'Employees Management',
      name: 'emps_managment',
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

  /// `Enter a valid number`
  String get enter_a_valid_number {
    return Intl.message(
      'Enter a valid number',
      name: 'enter_a_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code`
  String get enter_the_code {
    return Intl.message(
      'Enter the code',
      name: 'enter_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Extras`
  String get extras {
    return Intl.message(
      'Extras',
      name: 'extras',
      desc: '',
      args: [],
    );
  }

  /// `Faq`
  String get faq {
    return Intl.message(
      'Faq',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Foods`
  String get favorite_foods {
    return Intl.message(
      'Favorite Foods',
      name: 'favorite_foods',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Featured Foods`
  String get featured_foods {
    return Intl.message(
      'Featured Foods',
      name: 'featured_foods',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Food Categories`
  String get food_categories {
    return Intl.message(
      'Food Categories',
      name: 'food_categories',
      desc: '',
      args: [],
    );
  }

  /// `Free delivery`
  String get free_delivery {
    return Intl.message(
      'Free delivery',
      name: 'free_delivery',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `g`
  String get g {
    return Intl.message(
      'g',
      name: 'g',
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

  /// `Help & Support`
  String get help_support {
    return Intl.message(
      'Help & Support',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `Help & Supports`
  String get help_supports {
    return Intl.message(
      'Help & Supports',
      name: 'help_supports',
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

  /// `I don't have an account?`
  String get i_dont_have_an_account {
    return Intl.message(
      'I don\'t have an account?',
      name: 'i_dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `I forgot password ?`
  String get i_forgot_password {
    return Intl.message(
      'I forgot password ?',
      name: 'i_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `I have account?`
  String get i_have_account_back_to_login {
    return Intl.message(
      'I have account?',
      name: 'i_have_account_back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Inactive employees`
  String get inactive_employees {
    return Intl.message(
      'Inactive employees',
      name: 'inactive_employees',
      desc: '',
      args: [],
    );
  }

  /// `Inactive offers`
  String get inactive_offers {
    return Intl.message(
      'Inactive offers',
      name: 'inactive_offers',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `It can not be undone at this stage`
  String get it_can_not_be_undone_at_this_stage {
    return Intl.message(
      'It can not be undone at this stage',
      name: 'it_can_not_be_undone_at_this_stage',
      desc: '',
      args: [],
    );
  }

  /// `John Doe`
  String get john_doe {
    return Intl.message(
      'John Doe',
      name: 'john_doe',
      desc: '',
      args: [],
    );
  }

  /// `Kosh Stroe`
  String get koshstore {
    return Intl.message(
      'Kosh Stroe',
      name: 'koshstore',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Latest Products`
  String get latest_products {
    return Intl.message(
      'Latest Products',
      name: 'latest_products',
      desc: '',
      args: [],
    );
  }

  /// `Let's Start with Login`
  String get lets_start_with_login {
    return Intl.message(
      'Let\'s Start with Login',
      name: 'lets_start_with_login',
      desc: '',
      args: [],
    );
  }

  /// `Let's Start with register!`
  String get lets_start_with_register {
    return Intl.message(
      'Let\'s Start with register!',
      name: 'lets_start_with_register',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message(
      'Level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
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

  /// `Please login`
  String get login_please {
    return Intl.message(
      'Please login',
      name: 'login_please',
      desc: '',
      args: [],
    );
  }

  /// `You can get an account to manage sales\non the Kosh™ store by completing the data registration with the application management`
  String get login_slogin {
    return Intl.message(
      'You can get an account to manage sales\non the Kosh™ store by completing the data registration with the application management',
      name: 'login_slogin',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Longpress on the food to add suplements`
  String get longpress_on_the_food_to_add_suplements {
    return Intl.message(
      'Longpress on the food to add suplements',
      name: 'longpress_on_the_food_to_add_suplements',
      desc: '',
      args: [],
    );
  }

  /// `Maps Explorer`
  String get maps_explorer {
    return Intl.message(
      'Maps Explorer',
      name: 'maps_explorer',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Merchant`
  String get merchant {
    return Intl.message(
      'Merchant',
      name: 'merchant',
      desc: '',
      args: [],
    );
  }

  /// `Merchants`
  String get merchants {
    return Intl.message(
      'Merchants',
      name: 'merchants',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get most_popular {
    return Intl.message(
      'Most Popular',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `اكلاتنا`
  String get multirestaurants {
    return Intl.message(
      'اكلاتنا',
      name: 'multirestaurants',
      desc: '',
      args: [],
    );
  }

  /// `Must not be empty`
  String get must_not_be_empty {
    return Intl.message(
      'Must not be empty',
      name: 'must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get my_orders {
    return Intl.message(
      'My Orders',
      name: 'my_orders',
      desc: '',
      args: [],
    );
  }

  /// `Neighborhood`
  String get neighborhood {
    return Intl.message(
      'Neighborhood',
      name: 'neighborhood',
      desc: '',
      args: [],
    );
  }

  /// `New comment`
  String get new_comment {
    return Intl.message(
      'New comment',
      name: 'new_comment',
      desc: '',
      args: [],
    );
  }

  /// `New Order's`
  String get new_order {
    return Intl.message(
      'New Order\'s',
      name: 'new_order',
      desc: 'new order from merchent app',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `New user`
  String get new_user {
    return Intl.message(
      'New user',
      name: 'new_user',
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

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No comments`
  String get no_comments {
    return Intl.message(
      'No comments',
      name: 'no_comments',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `No product`
  String get no_product {
    return Intl.message(
      'No product',
      name: 'no_product',
      desc: '',
      args: [],
    );
  }

  /// `There are no products`
  String get no_products {
    return Intl.message(
      'There are no products',
      name: 'no_products',
      desc: '',
      args: [],
    );
  }

  /// `There are no results.`
  String get no_results {
    return Intl.message(
      'There are no results.',
      name: 'no_results',
      desc: '',
      args: [],
    );
  }

  /// `There are no suggestions`
  String get no_suggestions {
    return Intl.message(
      'There are no suggestions',
      name: 'no_suggestions',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid slicing method`
  String get not_a_valid_slicing_method {
    return Intl.message(
      'Not a valid slicing method',
      name: 'not_a_valid_slicing_method',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid address`
  String get not_a_valid_address {
    return Intl.message(
      'Not a valid address',
      name: 'not_a_valid_address',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid biography`
  String get not_a_valid_biography {
    return Intl.message(
      'Not a valid biography',
      name: 'not_a_valid_biography',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid full name`
  String get not_a_valid_full_name {
    return Intl.message(
      'Not a valid full name',
      name: 'not_a_valid_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid phone`
  String get not_a_valid_phone {
    return Intl.message(
      'Not a valid phone',
      name: 'not_a_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Not delivered`
  String get not_delivered {
    return Intl.message(
      'Not delivered',
      name: 'not_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition`
  String get nutrition {
    return Intl.message(
      'Nutrition',
      name: 'nutrition',
      desc: '',
      args: [],
    );
  }

  /// `Offers Management`
  String get offer_management {
    return Intl.message(
      'Offers Management',
      name: 'offer_management',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Ordered by Nearby first`
  String get ordered_by_nearby_first {
    return Intl.message(
      'Ordered by Nearby first',
      name: 'ordered_by_nearby_first',
      desc: '',
      args: [],
    );
  }

  /// `Order Id`
  String get order_id {
    return Intl.message(
      'Order Id',
      name: 'order_id',
      desc: '',
      args: [],
    );
  }

  /// `Order management`
  String get order_management {
    return Intl.message(
      'Order management',
      name: 'order_management',
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

  /// `Order status`
  String get order_status {
    return Intl.message(
      'Order status',
      name: 'order_status',
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

  /// `Payment Mode`
  String get payment_mode {
    return Intl.message(
      'Payment Mode',
      name: 'payment_mode',
      desc: '',
      args: [],
    );
  }

  /// `Payment Options`
  String get payment_options {
    return Intl.message(
      'Payment Options',
      name: 'payment_options',
      desc: '',
      args: [],
    );
  }

  /// `Payments Settings`
  String get payments_settings {
    return Intl.message(
      'Payments Settings',
      name: 'payments_settings',
      desc: '',
      args: [],
    );
  }

  /// `PayPal Payment`
  String get paypal_payment {
    return Intl.message(
      'PayPal Payment',
      name: 'paypal_payment',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `pickup`
  String get pickup {
    return Intl.message(
      'pickup',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Pickup method`
  String get pickup_method {
    return Intl.message(
      'Pickup method',
      name: 'pickup_method',
      desc: '',
      args: [],
    );
  }

  /// `Piece`
  String get piece {
    return Intl.message(
      'Piece',
      name: 'piece',
      desc: '',
      args: [],
    );
  }

  /// `Please choose one`
  String get please_choose_one {
    return Intl.message(
      'Please choose one',
      name: 'please_choose_one',
      desc: '',
      args: [],
    );
  }

  /// `Please state the reason`
  String get please_state_the_reason {
    return Intl.message(
      'Please state the reason',
      name: 'please_state_the_reason',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get please_wait {
    return Intl.message(
      'Please wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
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

  /// `{count, plural, zero{products} one{product} other{products}}`
  String product(num count) {
    return Intl.plural(
      count,
      zero: 'products',
      one: 'product',
      other: 'products',
      name: 'product',
      desc: '',
      args: [count],
    );
  }

  /// `Product Description`
  String get product_description {
    return Intl.message(
      'Product Description',
      name: 'product_description',
      desc: '',
      args: [],
    );
  }

  /// `Product management`
  String get product_management {
    return Intl.message(
      'Product management',
      name: 'product_management',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get product_name {
    return Intl.message(
      'Product Name',
      name: 'product_name',
      desc: '',
      args: [],
    );
  }

  /// `Product price`
  String get product_price {
    return Intl.message(
      'Product price',
      name: 'product_price',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Products in cart`
  String get products_in_cart {
    return Intl.message(
      'Products in cart',
      name: 'products_in_cart',
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

  /// `Profile picture has been successfully updated`
  String get profile_picture_has_been_successfully_updated {
    return Intl.message(
      'Profile picture has been successfully updated',
      name: 'profile_picture_has_been_successfully_updated',
      desc: '',
      args: [],
    );
  }

  /// `Profile Settings`
  String get profile_settings {
    return Intl.message(
      'Profile Settings',
      name: 'profile_settings',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Rate this product`
  String get rate_this_product {
    return Intl.message(
      'Rate this product',
      name: 'rate_this_product',
      desc: '',
      args: [],
    );
  }

  /// `Ready for delivery`
  String get ready_for_delivery {
    return Intl.message(
      'Ready for delivery',
      name: 'ready_for_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Reason for cancellation`
  String get reason_for_cancellation {
    return Intl.message(
      'Reason for cancellation',
      name: 'reason_for_cancellation',
      desc: '',
      args: [],
    );
  }

  /// `Recent Orders`
  String get recent_orders {
    return Intl.message(
      'Recent Orders',
      name: 'recent_orders',
      desc: '',
      args: [],
    );
  }

  /// `Recent Reviews`
  String get recent_reviews {
    return Intl.message(
      'Recent Reviews',
      name: 'recent_reviews',
      desc: '',
      args: [],
    );
  }

  /// `We will send your plain-text password to this email account.`
  String get recoverPasswordDescription {
    return Intl.message(
      'We will send your plain-text password to this email account.',
      name: 'recoverPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Reset your password here`
  String get recoverPasswordIntro {
    return Intl.message(
      'Reset your password here',
      name: 'recoverPasswordIntro',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Related products`
  String get related_products {
    return Intl.message(
      'Related products',
      name: 'related_products',
      desc: '',
      args: [],
    );
  }

  /// `Remove from cart`
  String get remove_from_cart {
    return Intl.message(
      'Remove from cart',
      name: 'remove_from_cart',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message(
      'Restore',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Returned products`
  String get returned_products {
    return Intl.message(
      'Returned products',
      name: 'returned_products',
      desc: 'Returned products',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Rial`
  String get rial {
    return Intl.message(
      'Rial',
      name: 'rial',
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

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search for restaurants or foods`
  String get search_for_restaurants_or_foods {
    return Intl.message(
      'Search for restaurants or foods',
      name: 'search_for_restaurants_or_foods',
      desc: '',
      args: [],
    );
  }

  /// `secluded`
  String get secluded {
    return Intl.message(
      'secluded',
      name: 'secluded',
      desc: '',
      args: [],
    );
  }

  /// `Choose Brand`
  String get select_brand {
    return Intl.message(
      'Choose Brand',
      name: 'select_brand',
      desc: '',
      args: [],
    );
  }

  /// `Was selected`
  String get selected {
    return Intl.message(
      'Was selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Select extras to add them on the food`
  String get select_extras_to_add_them_on_the_food {
    return Intl.message(
      'Select extras to add them on the food',
      name: 'select_extras_to_add_them_on_the_food',
      desc: '',
      args: [],
    );
  }

  /// `Select shipping address`
  String get select_shipping_address {
    return Intl.message(
      'Select shipping address',
      name: 'select_shipping_address',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred languages`
  String get select_your_preferred_languages {
    return Intl.message(
      'Select your preferred languages',
      name: 'select_your_preferred_languages',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred payment mode`
  String get select_your_preferred_payment_mode {
    return Intl.message(
      'Select your preferred payment mode',
      name: 'select_your_preferred_payment_mode',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shipping_address {
    return Intl.message(
      'Shipping Address',
      name: 'shipping_address',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Should be a valid email`
  String get should_be_a_valid_email {
    return Intl.message(
      'Should be a valid email',
      name: 'should_be_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 3 letters`
  String get should_be_more_than_3_letters {
    return Intl.message(
      'Should be more than 3 letters',
      name: 'should_be_more_than_3_letters',
      desc: '',
      args: [],
    );
  }

  /// `Password should be 6 letters or more`
  String get password_should_be_more_than_6_letters {
    return Intl.message(
      'Password should be 6 letters or more',
      name: 'password_should_be_more_than_6_letters',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 6 letters`
  String get should_be_more_than_6_letters {
    return Intl.message(
      'Should be more than 6 letters',
      name: 'should_be_more_than_6_letters',
      desc: '',
      args: [],
    );
  }

  /// `Show All Comments`
  String get show_all_comments {
    return Intl.message(
      'Show All Comments',
      name: 'show_all_comments',
      desc: '',
      args: [],
    );
  }

  /// `Show on map`
  String get show_on_map {
    return Intl.message(
      'Show on map',
      name: 'show_on_map',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Slicing Method`
  String get slicing_method {
    return Intl.message(
      'Slicing Method',
      name: 'slicing_method',
      desc: '',
      args: [],
    );
  }

  /// `Sorry,\nthis product is not available with these options`
  String get sorry_this_product_is_not_available_with_these_options {
    return Intl.message(
      'Sorry,\nthis product is not available with these options',
      name: 'sorry_this_product_is_not_available_with_these_options',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, your balance is not enough`
  String get sorry_your_balance_is_not_enough {
    return Intl.message(
      'Sorry, your balance is not enough',
      name: 'sorry_your_balance_is_not_enough',
      desc: '',
      args: [],
    );
  }

  /// `Sort alphabetically`
  String get sort_by_name {
    return Intl.message(
      'Sort alphabetically',
      name: 'sort_by_name',
      desc: '',
      args: [],
    );
  }

  /// `Sorted by newest`
  String get sort_by_new {
    return Intl.message(
      'Sorted by newest',
      name: 'sort_by_new',
      desc: '',
      args: [],
    );
  }

  /// `Start Exploring`
  String get start_exploring {
    return Intl.message(
      'Start Exploring',
      name: 'start_exploring',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
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

  /// `Summery`
  String get summery {
    return Intl.message(
      'Summery',
      name: 'summery',
      desc: '',
      args: [],
    );
  }

  /// `Tap back again to leave`
  String get tap_back_again_to_leave {
    return Intl.message(
      'Tap back again to leave',
      name: 'tap_back_again_to_leave',
      desc: '',
      args: [],
    );
  }

  /// `TAX`
  String get tax {
    return Intl.message(
      'TAX',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `The code has been sent to your phone`
  String get the_code_has_been_sent_to {
    return Intl.message(
      'The code has been sent to your phone',
      name: 'the_code_has_been_sent_to',
      desc: '',
      args: [],
    );
  }

  /// `The product has been added to favorite`
  String get the_product_has_been_added_to_favorite {
    return Intl.message(
      'The product has been added to favorite',
      name: 'the_product_has_been_added_to_favorite',
      desc: '',
      args: [],
    );
  }

  /// `The product has been added to the cart`
  String get the_product_has_been_added_to_the_cart {
    return Intl.message(
      'The product has been added to the cart',
      name: 'the_product_has_been_added_to_the_cart',
      desc: '',
      args: [],
    );
  }

  /// `The product has been removed from the cart`
  String get the_product_has_been_removed_from_the_cart {
    return Intl.message(
      'The product has been removed from the cart',
      name: 'the_product_has_been_removed_from_the_cart',
      desc: '',
      args: [],
    );
  }

  /// `The product was not found`
  String get the_product_was_not_found {
    return Intl.message(
      'The product was not found',
      name: 'the_product_was_not_found',
      desc: '',
      args: [],
    );
  }

  /// `There is no internet connection`
  String get there_is_no_internet_connection {
    return Intl.message(
      'There is no internet connection',
      name: 'there_is_no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `This product is already in the cart`
  String get this_product_is_already_in_the_cart {
    return Intl.message(
      'This product is already in the cart',
      name: 'this_product_is_already_in_the_cart',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Top Restaurants`
  String get top_restaurants {
    return Intl.message(
      'Top Restaurants',
      name: 'top_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Order`
  String get tracking_order {
    return Intl.message(
      'Tracking Order',
      name: 'tracking_order',
      desc: '',
      args: [],
    );
  }

  /// `Trending This Week`
  String get trending_this_week {
    return Intl.message(
      'Trending This Week',
      name: 'trending_this_week',
      desc: '',
      args: [],
    );
  }

  /// `Under Delivery`
  String get under_delivery {
    return Intl.message(
      'Under Delivery',
      name: 'under_delivery',
      desc: 'Under Delivery in merchent app',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `unsecluded`
  String get unsecluded {
    return Intl.message(
      'unsecluded',
      name: 'unsecluded',
      desc: '',
      args: [],
    );
  }

  /// `Variations`
  String get variations {
    return Intl.message(
      'Variations',
      name: 'variations',
      desc: '',
      args: [],
    );
  }

  /// `Vat number`
  String get vat_number {
    return Intl.message(
      'Vat number',
      name: 'vat_number',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Verify your quantity and click checkout`
  String get verify_your_quantity_and_click_checkout {
    return Intl.message(
      'Verify your quantity and click checkout',
      name: 'verify_your_quantity_and_click_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Watch`
  String get watch {
    return Intl.message(
      'Watch',
      name: 'watch',
      desc: '',
      args: [],
    );
  }

  /// `We are here for you`
  String get we_are_here_for_you {
    return Intl.message(
      'We are here for you',
      name: 'we_are_here_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `We speak more than one language`
  String get we_speak_more_than_one_language {
    return Intl.message(
      'We speak more than one language',
      name: 'we_speak_more_than_one_language',
      desc: '',
      args: [],
    );
  }

  /// `What They Say ?`
  String get what_they_say {
    return Intl.message(
      'What They Say ?',
      name: 'what_they_say',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get with_options {
    return Intl.message(
      'Options',
      name: 'with_options',
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

  /// `You can discover restaurants & fastfood arround you and choose you best meal after few minutes we prepare and delivere it for you`
  String get you_can_discover_restaurants {
    return Intl.message(
      'You can discover restaurants & fastfood arround you and choose you best meal after few minutes we prepare and delivere it for you',
      name: 'you_can_discover_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `You must login first`
  String get you_must_login_first {
    return Intl.message(
      'You must login first',
      name: 'you_must_login_first',
      desc: '',
      args: [],
    );
  }

  /// `Your addresses that you want us to deliver to`
  String get your_addresses_that_you_want_us_to_reach_you {
    return Intl.message(
      'Your addresses that you want us to deliver to',
      name: 'your_addresses_that_you_want_us_to_reach_you',
      desc: '',
      args: [],
    );
  }

  /// `Your application your rules`
  String get your_application_your_rules {
    return Intl.message(
      'Your application your rules',
      name: 'your_application_your_rules',
      desc: '',
      args: [],
    );
  }

  /// `Your biography`
  String get your_biography {
    return Intl.message(
      'Your biography',
      name: 'your_biography',
      desc: '',
      args: [],
    );
  }

  /// `Your journey with us`
  String get your_journey_with_us {
    return Intl.message(
      'Your journey with us',
      name: 'your_journey_with_us',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been successfully submitted!`
  String get your_order_has_been_successfully_submitted {
    return Intl.message(
      'Your order has been successfully submitted!',
      name: 'your_order_has_been_successfully_submitted',
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
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}