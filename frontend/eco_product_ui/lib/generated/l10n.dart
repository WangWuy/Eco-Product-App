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

  /// `Eco Product UI`
  String get app_name {
    return Intl.message(
      'Eco Product UI',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account`
  String get createNew {
    return Intl.message(
      'Create an Account',
      name: 'createNew',
      desc: '',
      args: [],
    );
  }

  /// `Enter your details information`
  String get SignUpMsg {
    return Intl.message(
      'Enter your details information',
      name: 'SignUpMsg',
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

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Email Address*`
  String get emailAddress {
    return Intl.message(
      'Email Address*',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password*`
  String get password {
    return Intl.message(
      'Password*',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number*`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number*',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
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

  /// `Terms & Condition`
  String get termsAndCondition {
    return Intl.message(
      'Terms & Condition',
      name: 'termsAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `I have accept`
  String get iHaveAccept {
    return Intl.message(
      'I have accept',
      name: 'iHaveAccept',
      desc: '',
      args: [],
    );
  }

  /// `Have an Account?`
  String get haveAnAccount {
    return Intl.message(
      'Have an Account?',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an Account?`
  String get donHaveAnAccount {
    return Intl.message(
      'Don\'t have an Account?',
      name: 'donHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Let's Sign You In`
  String get signYouIn {
    return Intl.message(
      'Let\'s Sign You In',
      name: 'signYouIn',
      desc: '',
      args: [],
    );
  }

  /// `To Continue, first verify that it's you.`
  String get SignInMsg {
    return Intl.message(
      'To Continue, first verify that it\'s you.',
      name: 'SignInMsg',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Office furniture`
  String get officeFurniture {
    return Intl.message(
      'Office furniture',
      name: 'officeFurniture',
      desc: '',
      args: [],
    );
  }

  /// `Use filler text that has been edited for length an\nformat to match on a characteristics of real\ncontent as closely as possible.`
  String get officeDesc {
    return Intl.message(
      'Use filler text that has been edited for length an\nformat to match on a characteristics of real\ncontent as closely as possible.',
      name: 'officeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Relaxing furniture`
  String get relaxingFurniture {
    return Intl.message(
      'Relaxing furniture',
      name: 'relaxingFurniture',
      desc: '',
      args: [],
    );
  }

  /// `Use filler text helps your design process,but use\nreal content if you have got it as long as it does distract and\nslow down your design process.`
  String get relaxingDesc {
    return Intl.message(
      'Use filler text helps your design process,but use\nreal content if you have got it as long as it does distract and\nslow down your design process.',
      name: 'relaxingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Home furniture`
  String get homeFurniture {
    return Intl.message(
      'Home furniture',
      name: 'homeFurniture',
      desc: '',
      args: [],
    );
  }

  /// `Design is an evolutionary process,and filter text is just\none tool in your process-pushing arsenal.`
  String get homeDesc {
    return Intl.message(
      'Design is an evolutionary process,and filter text is just\none tool in your process-pushing arsenal.',
      name: 'homeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get discover {
    return Intl.message(
      'Discover',
      name: 'discover',
      desc: '',
      args: [],
    );
  }

  /// `Shop Now`
  String get shopNow {
    return Intl.message(
      'Shop Now',
      name: 'shopNow',
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

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Trending`
  String get trending {
    return Intl.message(
      'Trending',
      name: 'trending',
      desc: '',
      args: [],
    );
  }

  /// `Colors`
  String get colorsString {
    return Intl.message(
      'Colors',
      name: 'colorsString',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkOut {
    return Intl.message(
      'Checkout',
      name: 'checkOut',
      desc: '',
      args: [],
    );
  }

  /// `Deliver To`
  String get deliverTo {
    return Intl.message(
      'Deliver To',
      name: 'deliverTo',
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

  /// `Continue`
  String get continueString {
    return Intl.message(
      'Continue',
      name: 'continueString',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressTitle {
    return Intl.message(
      'Address',
      name: 'addressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Fee`
  String get shippingFee {
    return Intl.message(
      'Shipping Fee',
      name: 'shippingFee',
      desc: '',
      args: [],
    );
  }

  /// `Estimating Tax`
  String get estimatingTax {
    return Intl.message(
      'Estimating Tax',
      name: 'estimatingTax',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get total {
    return Intl.message(
      'Total Price',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Full Name*`
  String get fullName {
    return Intl.message(
      'Full Name*',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number*`
  String get phoneNumber {
    return Intl.message(
      'Phone Number*',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Card Number*`
  String get cardNumber {
    return Intl.message(
      'Card Number*',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `On Delivery`
  String get onDelivery {
    return Intl.message(
      'On Delivery',
      name: 'onDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `ReSend`
  String get resend {
    return Intl.message(
      'ReSend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Product Added...`
  String get productAdded {
    return Intl.message(
      'Product Added...',
      name: 'productAdded',
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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buyNow {
    return Intl.message(
      'Buy Now',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `You may also like`
  String get youMayAlsoLike {
    return Intl.message(
      'You may also like',
      name: 'youMayAlsoLike',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder Name*`
  String get cardHolderName {
    return Intl.message(
      'Card Holder Name*',
      name: 'cardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `City/District*`
  String get cityDistrict {
    return Intl.message(
      'City/District*',
      name: 'cityDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Zip*`
  String get zip {
    return Intl.message(
      'Zip*',
      name: 'zip',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Track Order`
  String get trackOrder {
    return Intl.message(
      'Track Order',
      name: 'trackOrder',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Find Coupon`
  String get findCoupon {
    return Intl.message(
      'Find Coupon',
      name: 'findCoupon',
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

  /// `Save Cards`
  String get savedCards {
    return Intl.message(
      'Save Cards',
      name: 'savedCards',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `New Card`
  String get newCard {
    return Intl.message(
      'New Card',
      name: 'newCard',
      desc: '',
      args: [],
    );
  }

  /// `New Address`
  String get newAddress {
    return Intl.message(
      'New Address',
      name: 'newAddress',
      desc: '',
      args: [],
    );
  }

  /// `House/Apartment`
  String get houseApartment {
    return Intl.message(
      'House/Apartment',
      name: 'houseApartment',
      desc: '',
      args: [],
    );
  }

  /// `Agency/Company`
  String get agencyCompany {
    return Intl.message(
      'Agency/Company',
      name: 'agencyCompany',
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

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderId {
    return Intl.message(
      'Order ID',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `ReOrder`
  String get reOrder {
    return Intl.message(
      'ReOrder',
      name: 'reOrder',
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

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Card No`
  String get cardNo {
    return Intl.message(
      'Card No',
      name: 'cardNo',
      desc: '',
      args: [],
    );
  }

  /// `Order Tracking`
  String get orderTracking {
    return Intl.message(
      'Order Tracking',
      name: 'orderTracking',
      desc: '',
      args: [],
    );
  }

  /// `Exp. Date`
  String get expDate {
    return Intl.message(
      'Exp. Date',
      name: 'expDate',
      desc: '',
      args: [],
    );
  }

  /// `Exp. Date*`
  String get expDateHint {
    return Intl.message(
      'Exp. Date*',
      name: 'expDateHint',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message(
      'CVV',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `CVV*`
  String get cvvHint {
    return Intl.message(
      'CVV*',
      name: 'cvvHint',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Save the Cards`
  String get saveTheCards {
    return Intl.message(
      'Save the Cards',
      name: 'saveTheCards',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message(
      'Place Order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Promo Code`
  String get promoCode {
    return Intl.message(
      'Promo Code',
      name: 'promoCode',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
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

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
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

  /// `My Order History`
  String get myOrderHistory {
    return Intl.message(
      'My Order History',
      name: 'myOrderHistory',
      desc: '',
      args: [],
    );
  }

  /// `My Order`
  String get myOrder {
    return Intl.message(
      'My Order',
      name: 'myOrder',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourite {
    return Intl.message(
      'Favourites',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `My Favourites`
  String get myFavourite {
    return Intl.message(
      'My Favourites',
      name: 'myFavourite',
      desc: '',
      args: [],
    );
  }

  /// `My Vouchers`
  String get myVouchers {
    return Intl.message(
      'My Vouchers',
      name: 'myVouchers',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `My Saved Cards`
  String get mySavedCards {
    return Intl.message(
      'My Saved Cards',
      name: 'mySavedCards',
      desc: '',
      args: [],
    );
  }

  /// `Gift Cards & Vouchers`
  String get giftCard {
    return Intl.message(
      'Gift Cards & Vouchers',
      name: 'giftCard',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profiles`
  String get editProfiles {
    return Intl.message(
      'Edit Profiles',
      name: 'editProfiles',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get userInformation {
    return Intl.message(
      'User Information',
      name: 'userInformation',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddressHint {
    return Intl.message(
      'Email Address',
      name: 'emailAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
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

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Exp`
  String get exp {
    return Intl.message(
      'Exp',
      name: 'exp',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Minimum characters:250`
  String get minimumCharacter {
    return Intl.message(
      'Minimum characters:250',
      name: 'minimumCharacter',
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

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search Categories`
  String get searchHint {
    return Intl.message(
      'Search Categories',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Write your review`
  String get writeYourReview {
    return Intl.message(
      'Write your review',
      name: 'writeYourReview',
      desc: '',
      args: [],
    );
  }

  /// `Write Reviews`
  String get writeReviewPage {
    return Intl.message(
      'Write Reviews',
      name: 'writeReviewPage',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Material`
  String get material {
    return Intl.message(
      'Material',
      name: 'material',
      desc: '',
      args: [],
    );
  }

  /// `Personal info`
  String get personalInfo {
    return Intl.message(
      'Personal info',
      name: 'personalInfo',
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

  /// `Most popular`
  String get mostPopular {
    return Intl.message(
      'Most popular',
      name: 'mostPopular',
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

  /// `Set your Password?`
  String get setYourPassword {
    return Intl.message(
      'Set your Password?',
      name: 'setYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address.You will receive a link to create a new password via email.`
  String get passwordDesc {
    return Intl.message(
      'Please enter your email address.You will receive a link to create a new password via email.',
      name: 'passwordDesc',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
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

  /// `Splash Screen`
  String get splashScreen {
    return Intl.message(
      'Splash Screen',
      name: 'splashScreen',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `What is Lorem Ipsum?\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nWhy do we use it?\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n\n\nWhere does it come from?\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.\n\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.`
  String get loremText {
    return Intl.message(
      'What is Lorem Ipsum?\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nWhy do we use it?\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n\n\nWhere does it come from?\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.\n\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
      name: 'loremText',
      desc: '',
      args: [],
    );
  }

  /// `It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.`
  String get introText {
    return Intl.message(
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
      name: 'introText',
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
