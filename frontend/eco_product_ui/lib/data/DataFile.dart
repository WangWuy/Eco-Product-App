
import 'package:flutter/cupertino.dart';

import '../model/AddressModel.dart';
import '../model/CardModel.dart';
import '../model/CategoryModel.dart';
import '../model/IntroModel.dart';
import '../model/ModelNotification.dart';
import '../model/OrderDescModel.dart';
import '../model/OrderModel.dart';
import '../model/PaymentModel.dart';
import '../model/ProfileModel.dart';
import '../model/ReviewModel.dart';
import '../model/SubCategoryModel.dart';
import '../model/VouchersModel.dart';


class DataFile {
  static List<IntroModel> getIntroModel(BuildContext context) {
    List<IntroModel> introList = [];

    IntroModel mainModel = new IntroModel();
    mainModel.id = 1;
    mainModel.name = "We are Sustainable";
    mainModel.image = "assets/images/intro_1.png";
    mainModel.desc =
        "The materials used in our reusable EcoStraws are gathered ethically from sustainable sources.";
    introList.add(mainModel);

    mainModel = new IntroModel();
    mainModel.id = 2;
    mainModel.name = "We are Guaranteed";
    mainModel.image = "assets/images/intro_2.png";
    mainModel.desc =
        "Eco is Irish and proud! We have put every effort in to supporting our local communities and other Irish businesses.";
    introList.add(mainModel);

    mainModel = new IntroModel();
    mainModel.id = 3;
    mainModel.name = "We are Eco-friendly";
    mainModel.image = "assets/images/intro_3.png";
    mainModel.desc =
        "Supplying quality eco-friendly products to our customers is one thing, but we try to go even further by delivering your order in the most sustainable way we can.";
    introList.add(mainModel);

    return introList;
  }

  // static List<DiscModel> getDiscModel() {
  //   List<DiscModel> introList = [];

  //   DiscModel mainModel = new DiscModel();
  //   mainModel.id = 1;
  //   mainModel.name = "Sofa";
  //   mainModel.image = "banner.jpg";
  //   // mainModel.image = "slider_1.jpg";
  //   mainModel.offText = "upto 50% off*";
  //   mainModel.desc = "All furniture discount";
  //   introList.add(mainModel);

  //   mainModel = new DiscModel();
  //   mainModel.id = 2;
  //   mainModel.name = "Sofa";
  //   mainModel.image = "slider_2.jpg";
  //   mainModel.desc = "All furniture discount";
  //   mainModel.offText = "upto 20% off*";
  //   introList.add(mainModel);

  //   mainModel = new DiscModel();
  //   mainModel.id = 3;
  //   mainModel.name = "Sofa";
  //   mainModel.image = "slider_3.jpg";
  //   mainModel.desc = "All furniture discount";
  //   mainModel.offText = "upto 20% off*";
  //   introList.add(mainModel);

  //   return introList;
  // }


  static List<ModelNotification> getNotificationList() {
    List<ModelNotification> introList = [];
    introList.add(ModelNotification("Notification1","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification2","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification3","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification4","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification5","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));

    return introList;
  }





  static List<CategoryModel> getCategoryModel() {
    List<CategoryModel> introList = [];

    CategoryModel mainModel = new CategoryModel();
    mainModel.id = 1;
    mainModel.name = "Eco Cups";
    mainModel.icon = "drink.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_cups.png";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "ToothBrush";
    mainModel.icon = "toothbrushes.png";
    mainModel.image = "collapsible_straws.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 3;
    mainModel.name = "Chair";
    mainModel.icon = "chair.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_bottles.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 4;
    mainModel.name = "Bag";
    mainModel.icon = "shopping-bag.png";
    mainModel.desc = "5 Items";
    mainModel.image = "bamboo_straws.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 5;
    mainModel.name = "Cotton Bag";
    mainModel.image = "cotton_bag.png";
    mainModel.icon = "cotton_bag.png";
    mainModel.desc = "5 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 6;
    mainModel.name = "Pouch";
    mainModel.icon = "pencilcase.png";
    mainModel.image = "stainless_straws.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 1;
    mainModel.name = "Eco Cups";
    mainModel.icon = "drink.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_cups.png";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "ToothBrush";
    mainModel.icon = "toothbrushes.png";
    mainModel.image = "collapsible_straws.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    // mainModel = new CategoryModel();
    // mainModel.id = 3;
    // mainModel.name = "Chair";
    // mainModel.icon = "chair.png";
    // mainModel.desc = "5 Items";
    // mainModel.image = "eco_bottles.jpg";
    // introList.add(mainModel);
    //
    // mainModel = new CategoryModel();
    // mainModel.id = 4;
    // mainModel.name = "Bag";
    // mainModel.icon = "shopping-bag.png";
    // mainModel.desc = "5 Items";
    // mainModel.image = "bamboo_straws.jpg";
    // introList.add(mainModel);
    //
    // mainModel = new CategoryModel();
    // mainModel.id = 5;
    // mainModel.name = "Cotton Bag";
    // mainModel.image = "cotton_bag.png";
    // mainModel.icon = "cotton_bag.png";
    // mainModel.desc = "5 Items";
    // introList.add(mainModel);
    //
    // mainModel = new CategoryModel();
    // mainModel.id = 6;
    // mainModel.name = "Pouch";
    // mainModel.icon = "pencilcase.png";
    // mainModel.image = "stainless_straws.jpg";
    // mainModel.desc = "4 Items";
    // introList.add(mainModel);

    return introList;
  }

  static List<CategoryModel> getDataCategoryModel() {
    List<CategoryModel> introList = [];

    CategoryModel mainModel = new CategoryModel();
    mainModel.id = 1;
    mainModel.name = "Eco Cups";
    mainModel.icon = "drink.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_cups.png";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "ToothBrush";
    mainModel.icon = "toothbrushes.png";
    mainModel.image = "collapsible_straws.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 3;
    mainModel.name = "Chair";
    mainModel.icon = "chair.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_bottles.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 4;
    mainModel.name = "Bag";
    mainModel.icon = "shopping-bag.png";
    mainModel.desc = "5 Items";
    mainModel.image = "bamboo_straws.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 5;
    mainModel.name = "Cotton Bag";
    mainModel.image = "cotton_bag.png";
    mainModel.icon = "hay.png";
    mainModel.desc = "5 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 6;
    mainModel.name = "Pouch";
    mainModel.icon = "pencilcase.png";
    mainModel.image = "stainless_straws.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 1;
    mainModel.name = "Eco Cups";
    mainModel.icon = "drink.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_cups.png";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "ToothBrush";
    mainModel.icon = "toothbrushes.png";
    mainModel.image = "collapsible_straws.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    // mainModel = new CategoryModel();
    // mainModel.id = 3;
    // mainModel.name = "Chair";
    // mainModel.icon = "chair.png";
    // mainModel.desc = "5 Items";
    // mainModel.image = "eco_bottles.jpg";
    // introList.add(mainModel);
    //
    // mainModel = new CategoryModel();
    // mainModel.id = 4;
    // mainModel.name = "Bag";
    // mainModel.icon = "shopping-bag.png";
    // mainModel.desc = "5 Items";
    // mainModel.image = "bamboo_straws.jpg";
    // introList.add(mainModel);
    //
    // mainModel = new CategoryModel();
    // mainModel.id = 5;
    // mainModel.name = "Cotton Bag";
    // mainModel.image = "cotton_bag.png";
    // mainModel.icon = "cotton_bag.png";
    // mainModel.desc = "5 Items";
    // introList.add(mainModel);
    //
    // mainModel = new CategoryModel();
    // mainModel.id = 6;
    // mainModel.name = "Pouch";
    // mainModel.icon = "pencilcase.png";
    // mainModel.image = "stainless_straws.jpg";
    // mainModel.desc = "4 Items";
    // introList.add(mainModel);

    return introList;
  }

  static String getTitleFromCat(int id) {
    List<CategoryModel> allList = getCategoryModel();

    print("id===$id");
    String title="";

    for (int i = 0; i < allList.length; i++) {
      if (allList[i].id == id) {
        title = allList[i].name;
      }
    }

    return title;
  }

  static List<SubCategoryModel> getSubCategoryListFromId(int id) {
    List<SubCategoryModel> subList = [];
    List<SubCategoryModel> allList = getSubCategoryModel();

    print("id----$id");
    if (id == 0) {
      subList.addAll(allList);
    } else {
      for (int i = 0; i < allList.length; i++) {
        if (allList[i].catId == id) {
          subList.add(allList[i]);
        }
      }
    }

    return subList;
  }

  static List<SubCategoryModel> getFavList() {
    List<SubCategoryModel> subList = [];
    List<SubCategoryModel> allList = getSubCategoryModel();

    for (int i = 0; i < allList.length; i++) {
      if (allList[i].isFav == 1) {
        subList.add(allList[i]);
      }
    }

    return subList;
  }

  static List<String> getSearchList() {
    List<String> subList = [];
    List<CategoryModel> allList = getCategoryModel();

    for (int i = 0; i < allList.length; i++) {
      if (!subList.contains(allList[i].name)) {
        subList.add(allList[i].name);
      }
    }

    return subList;
  }

  static List<String> getFilterList(bool isLess) {
    List<String> subList = [];
    List<CategoryModel> allList = getCategoryModel();

    for (int i = 0; i < allList.length; i++) {
      if (isLess) {
        if (subList.length < 5) {
          if (!subList.contains(allList[i].name)) {
            subList.add(allList[i].name);
          }
        }
      } else {
        if (!subList.contains(allList[i].name)) {
          subList.add(allList[i].name);
        }
      }
    }
    if (isLess) {
      subList.add("More");
    } else {
      subList.add("Less");
    }

    return subList;
  }

  static List<String> getMaterialList() {
    List<String> subList = [];
    subList.add("Canvas");
    subList.add("Wooden");
    subList.add("Leather");
    subList.add("Linen");
    subList.add("Tweed");

    return subList;
  }

  // https://ecostraws.ie/
  static List<SubCategoryModel> getSubCategoryModel() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Selection Box";
    mainModel.image = "cat_1.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped edible Sorbos EcoStraws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws - Chocolate";
    mainModel.image = "cat_2.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 3;
    mainModel.name = "Sorbos Edible Straws – Strawberry";
    mainModel.image = "cat_3.png";
    mainModel.price = "€5.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 4;
    mainModel.name = "Sorbos Edible Straws – Lime";
    mainModel.image = "cat_4.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped lime flavoured Sorbos Straws.";
    subList.add(mainModel);

    // mainModel = new SubCategoryModel();
    // mainModel.catId = 5;
    //
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.id = 5;
    // mainModel.isFav = 1;
    // mainModel.name = "Sorbos Edible Straws – Lemon";
    // mainModel.image = "cat_5.png";
    // mainModel.price = "€5.95";
    // mainModel.desc =
    //     "Each box contains 10 individually wrapped lemon flavoured Sorbos Straws.";
    // subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;

    mainModel.id = 6;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Trade Packs";
    mainModel.image = "cat_6.png";
    mainModel.price = "€50.95";
    mainModel.desc =
        "Each box contains 200 individually wrapped edible Sorbos EcoStraws, plus 1 display stand.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 7;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Pasta Straws – 230mm x 8mm";
    mainModel.image = "cat_7.png";
    mainModel.price = "€9.95";
    mainModel.desc = "Box of 60 Large Pasta Straws";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 8;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Apple";
    mainModel.image = "cat_8.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped apple flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 9;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Natural";
    mainModel.image = "cat_9.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped edible Sorbos EcoStraws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 10;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Cinnamon";
    mainModel.image = "cat_10.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped cinnamon flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Collapsible Straw";
    mainModel.image = "cat_11.png";
    mainModel.price = "€11.95";
    mainModel.desc =
        "Join us in a global movement to eliminate plastic drinking straws from our cities, bars, restaurants, oceans, and beaches.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 2;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_12.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 3;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_56.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 4;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_57.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 5;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_58.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 6;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_59.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 7;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_60.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 8;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_61.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 9;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_62.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 10;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_63.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 11;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_64.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 12;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_65.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 13;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_66.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 14;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_67.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);
    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 15;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_68.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 16;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_69.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 2;
    mainModel.id = 17;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "The Ultimate Party Straw";
    mainModel.image = "cat_70.png";
    mainModel.price = "€12.95";
    mainModel.desc =
        "What do you get when you cross a collapsible EcoStraw with a bottle opener? This, is what you get – The Ultimate Party Straw! Choose from one of 6 bright and fun coloured cases, attach it to your keyring, or keep in your pocket or purse.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.isFav = 1;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Reusable Bottle Gloss Black";
    mainModel.image = "cat_13.png";
    mainModel.price = "€19.95";
    // mainModel.categoryName = "Furniture,Accessories";
    // mainModel.tags = "#Furnitures,#Chair,#Table";
    mainModel.desc =
        "Amberville is a range of Hand-crafted Colonial Furniture inspired by Mid-Century Designs.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 3;
    mainModel.name = "Reusable Bottle Gloss Blue";
    mainModel.image = "cat_14.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "We are delighted to have teamed up with the guys at Narcis’sips to enable consumers to change their consumption patterns of plastic economically.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 4;
    mainModel.isFav = 1;
    mainModel.name = "Reusable Bottle Gloss White";
    mainModel.image = "cat_15.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "We are delighted to have teamed up with the guys at Narcis’sips to enable consumers to change their consumption patterns of plastic economically.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bottle Sports Cap";
    mainModel.image = "cat_16.png";
    mainModel.price = "€4.95";
    mainModel.desc =
        "Convert any of our Thermo Range EcoBottles into a sports bottle with this Bottle Sports Cap.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 6;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Carabiner Hook";
    mainModel.image = "cat_17.png";
    mainModel.price = "€3.95";
    mainModel.desc =
        "Add this amazing carabiner hook with coloured silicone connection to any EcoBottle for your convenience.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 7;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Metal Water Bottle Orange";
    mainModel.image = "cat_18.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "Our mission is to enable consumers to change their consumption patterns of plastic economically. We are now providing an orange reusable bottle made of high quality stainless steel which contain zero trace of BPA.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 8;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Reusable Bottle Gloss Red";
    mainModel.image = "cat_19.png";
    mainModel.price = "€18.95";
    mainModel.desc =
        "We are delighted to have teamed up with the guys at Narcis’sips to enable consumers to change their consumption patterns of plastic economically.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 9;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Best Reusable Water Bottle";
    mainModel.image = "cat_20.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "Meet the best reusable water bottle on the market! We are now providing an Aqua reusable bottle made of high quality stainless steel which contains zero traces of BPA.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 10;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Steel Water Bottle Green";
    mainModel.image = "cat_21.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "Have you seen our steel water bottle green? We are now providing a metallic green reusable bottle made of high quality stainless steel which contains zero traces of BPA. Our double vacuum sealed walled bottles allow consumers to keep their beverages hot for up to 12 hours, and cold for up to 24 hours.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 11;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Reusable Water Bottle Pink";
    mainModel.image = "cat_22.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "We are delighted to introduce our reusable water bottle in matte pink.  This reusable water bottle made of high quality stainless steel contains zero trace of BPA.";
    subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 3;
    // mainModel.id = 12;
    // mainModel.isFav = 1;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Reusable Bottle Metallic Champagne";
    // mainModel.image = "cat_23.jpg";
    // mainModel.price = "€19.95";
    // mainModel.desc =
    //     "We are delighted to have teamed up with the guys at Narcis’sips to enable consumers to change their consumption patterns of plastic economically.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 3;
    // mainModel.id = 13;
    // mainModel.isFav = 1;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Stainless Steel Thermal Bottle – Blue";
    // mainModel.image = "cat_24.jpg";
    // mainModel.price = "€23.95";
    // mainModel.desc =
    //     "This 500ml stainless steel thermal bottle is designed for durability while also ensuring you are sustainably stylish.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 3;
    // mainModel.id = 14;
    // mainModel.isFav = 1;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Insulated Water Bottle Gold";
    // mainModel.image = "cat_25.jpg";
    // mainModel.price = "€19.95";
    // mainModel.desc =
    //     "You can have a touch of class with this Insulated Water Bottle, Gold. We are now offering an insulated bottle made of high quality stainless steel which contains zero traces of BPA.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 3;
    // mainModel.id = 15;
    // mainModel.isFav = 1;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Stainless Steel Thermal Bottle – Black";
    // mainModel.image = "cat_26.jpg";
    // mainModel.price = "€23.95";
    // mainModel.desc =
    //     "This 500ml stainless steel thermal bottle is designed for durability while also ensuring you are sustainably stylish.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 3;
    // mainModel.id = 16;
    // mainModel.isFav = 1;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Stainless Steel Water Bottle";
    // mainModel.image = "cat_27.jpg";
    // mainModel.price = "€19.95";
    // mainModel.desc =
    //     "We are delighted to introduce you to our stainless steel water bottle in sleek silver. We are now offering a high quality silver stainless steel water bottle which contains zero trace of BPA. Our stainless steel water bottles are double vacuum sealed.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 3;
    // mainModel.id = 17;
    // mainModel.isFav = 1;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Reusable Bottle Mini Red";
    // mainModel.image = "cat_28.jpg";
    // mainModel.price = "€15.95";
    // mainModel.desc =
    //     "We are delighted to have teamed up with the guys at Narcis’sips to enable consumers to change their consumption patterns of plastic economically.";
    // subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 4;
    mainModel.id = 1;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bamboo Straws 200mm";
    mainModel.image = "cat_29.png";
    mainModel.price = "€8.95";
    mainModel.desc = "Pack of 5 Natural Bamboo EcoStraws & 2 Cleaning Brushes";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 4;
    mainModel.id = 2;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bamboo Straws 200mm";
    mainModel.image = "cat_71.png";
    mainModel.price = "€8.95";
    mainModel.desc = "Pack of 5 Natural Bamboo EcoStraws & 2 Cleaning Brushes";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 4;
    mainModel.id = 2;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bamboo Straws 200mm";
    mainModel.image = "cat_72.png";
    mainModel.price = "€8.95";
    mainModel.desc = "Pack of 5 Natural Bamboo EcoStraws & 2 Cleaning Brushes";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 4;
    mainModel.id = 2;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bamboo Straws 200mm";
    mainModel.image = "cat_73.png";
    mainModel.price = "€8.95";
    mainModel.desc = "Pack of 5 Natural Bamboo EcoStraws & 2 Cleaning Brushes";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 4;
    mainModel.id = 2;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bamboo Straws 200mm";
    mainModel.image = "cat_74.png";
    mainModel.price = "€8.95";
    mainModel.desc = "Pack of 5 Natural Bamboo EcoStraws & 2 Cleaning Brushes";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 4;
    mainModel.id = 2;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bamboo Straws 200mm";
    mainModel.image = "cat_75.png";
    mainModel.price = "€8.95";
    mainModel.desc = "Pack of 5 Natural Bamboo EcoStraws & 2 Cleaning Brushes";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 1;
    mainModel.name = "Collapsible EcoCup – Green";
    mainModel.image = "cat_30.png";
    mainModel.price = "€11.95";
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible 350ml EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Blue";
    mainModel.image = "cat_31.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Purple";
    mainModel.image = "cat_32.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible 350ml EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 4;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Grey";
    mainModel.image = "cat_33.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible 350ml EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Pink";
    mainModel.image = "cat_34.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 6;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Light Blue";
    mainModel.image = "cat_35.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible 350ml EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 7;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Stainless Steel Thermal Cup – Green";
    mainModel.image = "cat_36.png";
    mainModel.price = "€19.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Amazing triple insulated stainless steel Thermo Cup in 5 colours and 2 sizes.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 7;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Stainless Steel Thermal Cup – Pink";
    mainModel.image = "cat_37.png";
    mainModel.price = "€19.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Amazing triple insulated stainless steel Thermo Cup in 5 colours and 2 sizes.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 8;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Stainless Steel Thermal Cup – Blue";
    mainModel.image = "cat_38.png";
    mainModel.price = "€19.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Amazing triple insulated stainless steel Thermo Cup in 5 colours and 2 sizes.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 1;
    mainModel.id = 9;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Stainless Steel Thermal Cup – Black";
    mainModel.image = "cat_39.png";
    mainModel.price = "€19.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Amazing triple insulated stainless steel Thermo Cup in 5 colours and 2 sizes.";
    subList.add(mainModel);

    // mainModel = new SubCategoryModel();
    // mainModel.catId = 1;
    // mainModel.id = 10;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Glass EcoCup – Grey";
    // mainModel.image = "cat_40.jpg";
    // mainModel.price = "€18.95";
    // mainModel.isFav = 1;
    // mainModel.desc = "340ml Glass EcoCup – Grey";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 1;
    // mainModel.id = 11;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Wheat Fibre EcoCup – Natural";
    // mainModel.image = "cat_41.png";
    // mainModel.price = "€18.95";
    // mainModel.isFav = 1;
    // mainModel.desc = "450ml Wheat Fibre EcoCup – Natural";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 1;
    // mainModel.id = 12;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Glass EcoCup – Pink";
    // mainModel.image = "cat_42.jpg";
    // mainModel.price = "€18.95";
    // mainModel.isFav = 0;
    // mainModel.desc = "340ml Glass EcoCup – Pink";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 1;
    // mainModel.id = 13;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Wheat Fibre EcoCup – Teal";
    // mainModel.image = "cat_43.png";
    // mainModel.price = "€11.95";
    // mainModel.isFav = 0;
    // mainModel.desc = "450ml Wheat Fibre EcoCup - Teal";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 1;
    // mainModel.id = 14;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Monkey Cup - Turquoise";
    // mainModel.image = "cat_44.png";
    // mainModel.price = "€24.95";
    // mainModel.isFav = 1;
    // mainModel.desc =
    //     "The Monkey Cup is a new Irish designed barista standard coffee cup. It began with a sketch on Mailo Power’s kitchen table, fuelled by her passion to turn the tide on single-use plastic waste that is invading our environment by creating a reusable, fun alternative.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 1;
    // mainModel.id = 15;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Monkey Cup – Living Coral";
    // mainModel.image = "cat_45.png";
    // mainModel.price = "€24.95";
    // mainModel.isFav = 0;
    // mainModel.desc =
    //     "The Monkey Cup is a new Irish designed barista standard coffee cup. It began with a sketch on Mailo Power’s kitchen table, fuelled by her passion to turn the tide on single-use plastic waste that is invading our environment by creating a reusable, fun alternative.";
    // subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.id = 1;
    mainModel.name = "Silver Stainless Steel Straws – 215mm x 6mm";
    mainModel.reviewDesc = "(4.8)";
    mainModel.image = "cat_77.png";
    mainModel.price = "€9.95";
    mainModel.review = 4;
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.isFav = 1;
    mainModel.id = 2;
    mainModel.name =
        "Angled Mixture of Coloured Stainless Steel Straws – 215mm x 6mm";
    mainModel.reviewDesc = "(2.3)";
    mainModel.review = 4;
    mainModel.image = "cat_78.png";
    mainModel.price = "€10.95";

    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.id = 3;
    mainModel.name = "Rainbow Stainless Steel Straws – 215mm x 6mm";
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.image = "cat_79.png";
    mainModel.price = "€11.95";
    // mainModel.categoryName = "Furniture,Accessories";
    // mainModel.tags = "#Furnitures,#Chair,#Table";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 4;
    mainModel.name = "Copper Stainless Steel Straws – 215mm x 6mm";
    // mainModel.categoryName = "Furniture,Accessories";
    // mainModel.tags = "#Furnitures,#Chair,#Table";
    mainModel.image = "cat_80.png";
    mainModel.price = "€10.95";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 5;
    mainModel.name =
        "Party Pack of 10 Coloured Stainless Steel Straws – 215mm x 6mm";
    // mainModel.categoryName = "Furniture,Accessories";
    // mainModel.tags = "#Furnitures,#Chair,#Table";
    mainModel.image = "cat_81.png";
    mainModel.price = "€22.50";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 6;
    mainModel.name =
        "Straight Mixture of Coloured Stainless Steel Straws – 215mm x 6mm";
    // mainModel.categoryName = "Furniture,Accessories";
    // mainModel.tags = "#Furnitures,#Chair,#Table";
    mainModel.image = "cat_82.png";
    mainModel.price = "€22.50";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.id = 7;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Gold Stainless Steel Straws – 215mm x 6mm";
    mainModel.image = "cat_83.png";
    mainModel.price = "€10.95";
    // mainModel.categoryName = "Furniture,Accessories";
    // mainModel.tags = "#Furnitures,#Chair,#Table";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.id = 8;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Purple Stainless Steel Straws – 215mm x 6mm";
    mainModel.image = "cat_84.png";
    mainModel.price = "€10.95";
    // mainModel.categoryName = "Furniture,Accessories";
    // mainModel.tags = "#Furnitures,#Chair,#Table";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    // mainModel = new SubCategoryModel();
    // mainModel.catId = 6;
    // mainModel.id = 8;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Purple Stainless Steel Straws – 215mm x 6mm";
    // mainModel.image = "cat_85.png";
    // mainModel.price = "€10.95";
    // // mainModel.categoryName = "Furniture,Accessories";
    // // mainModel.tags = "#Furnitures,#Chair,#Table";
    // mainModel.desc =
    //     "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    // subList.add(mainModel);

    // mainModel = new SubCategoryModel();
    // mainModel.catId = 6;
    // mainModel.id = 9;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Green Stainless Steel Straws – 215mm x 6mm";
    // mainModel.image = "cat_6.png";
    // mainModel.price = "€10.95";
    // // mainModel.categoryName = "Furniture,Accessories";
    // // mainModel.tags = "#Furnitures,#Chair,#Table";
    // mainModel.desc =
    //     "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 6;
    // mainModel.id = 10;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Pink Stainless Steel Straws – 215mm x 6mm";
    // mainModel.image = "cat_7.png";
    // mainModel.price = "€10.95";
    //
    // mainModel.desc =
    //     "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 6;
    // mainModel.id = 11;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Red Stainless Steel Straws – 215mm x 6mm";
    // mainModel.image = "cat_8.png";
    // mainModel.price = "€10.95";
    // // mainModel.categoryName = "Furniture,Accessories";
    // // mainModel.tags = "#Furnitures,#Chair,#Table";
    // mainModel.desc =
    //     "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 6;
    // mainModel.id = 12;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Blue Stainless Steel Straws – 215mm x 6mm";
    // mainModel.image = "cat_9.png";
    // mainModel.price = "€10.95";
    // // mainModel.categoryName = "Furniture,Accessories";
    // // mainModel.tags = "#Furnitures,#Chair,#Table";
    // mainModel.desc =
    //     "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    // subList.add(mainModel);
    //
    // mainModel = new SubCategoryModel();
    // mainModel.catId = 6;
    // mainModel.id = 13;
    // mainModel.review = 3;
    // mainModel.reviewDesc = "(4.8)";
    // mainModel.name = "Black Stainless Steel Straws – 215mm x 6mm";
    // mainModel.image = "cat_10.jpg";
    // mainModel.price = "€10.95";
    // // mainModel.categoryName = "Furniture,Accessories";
    // // mainModel.tags = "#Furnitures,#Chair,#Table";
    // mainModel.desc =
    //     "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    // subList.add(mainModel);

    return subList;
  }

  static List<SubCategoryModel> getCartModel() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();

    mainModel.catId = 5;
    mainModel.id = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Purple";
    mainModel.image = "cat_32.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible 350ml EcoCup.";
    mainModel.quantity = 1;
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 4;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Grey";
    mainModel.image = "cat_33.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible 350ml EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 9;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Natural";
    mainModel.image = "cat_9.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped edible Sorbos EcoStraws.";
    subList.add(mainModel);

    return subList;
  }

  static List<SubCategoryModel> getTrendingModel() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Chocolate";
    mainModel.image = "cat_78.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Bottle Sports Cap";
    mainModel.image = "cat_16.png";
    mainModel.price = "€4.95";
    mainModel.desc =
        "Convert any of our Thermo Range EcoBottles into a sports bottle with this Bottle Sports Cap.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 9;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Natural";
    mainModel.image = "cat_9.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped edible Sorbos EcoStraws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;

    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 5;
    mainModel.isFav = 1;
    mainModel.name = "Sorbos Edible Straws – Lemon";
    mainModel.image = "cat_81.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped lemon flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 6;
    mainModel.name =
        "Straight Mixture of Coloured Stainless Steel Straws – 215mm x 6mm";
    mainModel.image = "cat_82.png";
    mainModel.price = "€22.50";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.id = 7;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Gold Stainless Steel Straws – 215mm x 6mm";
    mainModel.image = "cat_83.png";
    mainModel.price = "€10.95";
    mainModel.desc =
        "Haven’t we polluted the earth enough? The manufacturing of plastic products releases a whole set of chemicals into the atmosphere.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 6;
    mainModel.id = 8;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Sorbos Edible Straws – Apple";
    mainModel.image = "cat_84.png";
    mainModel.price = "€5.95";
    mainModel.desc =
        "Each box contains 10 individually wrapped apple flavoured Sorbos Straws.";
    subList.add(mainModel);

    return subList;
  }

  static List<AddressModel> getAddressList() {
    List<AddressModel> subCatList = [];

    AddressModel mainModel = new AddressModel();
    // mainModel.id = 1;
    // mainModel.name = "Sophia Benson";
    // mainModel.phoneNumber = "+1(368)68 000 068";
    // mainModel.location = "3012 Broddus Avenue Saint Joseph,56327";
    // mainModel.type = "Home";
    // subCatList.add(mainModel);

    mainModel.id = 1;
    mainModel.name = "Chloe B Bird";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location = "87  Great North Road,ALTON";
    mainModel.type = "Home";
    subCatList.add(mainModel);

    mainModel = new AddressModel();
    mainModel.id = 2;
    mainModel.name = "Rich P. Jeffery";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location = "4310 Clover Drive Colorado Springs, CO 80903";
    mainModel.type = "Company";
    subCatList.add(mainModel);

    return subCatList;
  }

  static ProfileModel getProfileModel() {
    ProfileModel mainModel = new ProfileModel();
    mainModel.email = "chloe_bird@gamil.com";
    mainModel.name = "Chloe B Bird";
    mainModel.image = "assets/images/hugh.png";
    return mainModel;
  }

  static List<PaymentModel> getPaymentList() {
    List<PaymentModel> subCatList = [];

    PaymentModel mainModel = new PaymentModel();
    mainModel.id = 1;
    mainModel.name = "Cash";
    mainModel.image = "assets/images/money.png";

    subCatList.add(mainModel);

    mainModel = new PaymentModel();
    mainModel.id = 2;
    mainModel.name = "Credit Card";
    mainModel.image = "assets/images/credit-card.png";
    subCatList.add(mainModel);

    mainModel = new PaymentModel();
    mainModel.id = 3;
    mainModel.name = "Net Banking";
    mainModel.image = "assets/images/bank.png";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<SubCategoryModel> getMyOrderList() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Collapsible EcoCup – Pink";
    mainModel.image = "cat_34.png";
    mainModel.price = "€11.95";
    mainModel.isFav = 1;
    mainModel.desc =
        "Ultra-portable, reusable, leak-proof and collapsible EcoCup.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.id = 4;
    mainModel.isFav = 1;
    mainModel.name = "Reusable Bottle Gloss White";
    mainModel.image = "cat_15.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "We are delighted to have teamed up with the guys at Narcis’sips to enable consumers to change their consumption patterns of plastic economically.";
    subList.add(mainModel);


    mainModel = new SubCategoryModel();
    mainModel.catId = 3;
    mainModel.id = 11;
    mainModel.isFav = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Reusable Water Bottle Pink";
    mainModel.image = "cat_22.png";
    mainModel.price = "€19.95";
    mainModel.desc =
        "We are delighted to introduce our reusable water bottle in matte pink.  This reusable water bottle made of high quality stainless steel contains zero trace of BPA.";
    subList.add(mainModel);
    return subList;
  }

  static List<CardModel> getCardList() {
    List<CardModel> subCatList = [];

    CardModel mainModel = new CardModel();
    mainModel.id = 1;
    mainModel.email = "chloe_bird@gmail.com";
    mainModel.cardNo = "2342 22** **** **00";
    mainModel.cVV = "***";
    mainModel.expDate = "06/23";
    mainModel.name = "Claudla T.Reyes";
    mainModel.image = "assets/images/visa.png";

    subCatList.add(mainModel);

    mainModel = new CardModel();
    mainModel.id = 2;
    mainModel.email = "chloe_bird@gmail.com";
    mainModel.cardNo = "2342 22** **** **00";
    mainModel.name = "Claudla T.Reyes";
    mainModel.cVV = "***";
    mainModel.expDate = "06/23";
    mainModel.image = "assets/images/mastercard.png";
    subCatList.add(mainModel);

    return subCatList;
  }

  // static List<ModelNotification> getNotificationList() {
  //   List<ModelNotification> introList = [];
  //   introList.add(ModelNotification("Notification1","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
  //   introList.add(ModelNotification("Notification2","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
  //   introList.add(ModelNotification("Notification3","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
  //   introList.add(ModelNotification("Notification4","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
  //   introList.add(ModelNotification("Notification5","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
  //
  //   return introList;
  // }






  static List<VouchersModel> getVouchersList() {
    List<VouchersModel> subCatList = [];

    VouchersModel mainModel = new VouchersModel();
    mainModel.id = 1;
    mainModel.name = "Black Fries Day";
    mainModel.desc = "All black fries 50% off*";
    mainModel.code = "BKD65R";
    mainModel.date = "25";
    mainModel.month = "Mar";
    mainModel.image = "logo_1.png";
    subCatList.add(mainModel);

    mainModel = new VouchersModel();
    mainModel.id = 2;
    mainModel.name = "Weekend specials";
    mainModel.desc = "All black sale 35% off*";
    mainModel.code = "FEB32#JJ";
    mainModel.date = "28";
    mainModel.month = "Feb";
    mainModel.image = "logo_2.png";
    subCatList.add(mainModel);

    mainModel = new VouchersModel();
    mainModel.id = 3;
    mainModel.name = "Specials Sale.!";
    mainModel.desc = "All black sale 35% off*";
    mainModel.code = "BMK56E";
    mainModel.date = "26";
    mainModel.month = "Feb";
    mainModel.image = "logo_3.jpg";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<ReviewModel> getReviewList() {
    List<ReviewModel> subCatList = [];

    ReviewModel mainModel = new ReviewModel();
    mainModel.id = 1;
    mainModel.name = "Soedirman";
    mainModel.image = "hugh.png";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 4;
    subCatList.add(mainModel);

    mainModel = new ReviewModel();
    mainModel.id = 2;
    mainModel.name = "Aisyah";
    mainModel.image = "hugh.png";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 3;
    subCatList.add(mainModel);

    mainModel = new ReviewModel();
    mainModel.id = 3;
    mainModel.image = "hugh.png";
    mainModel.name = "Jock Boerden";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 2;
    subCatList.add(mainModel);
    return subCatList;
  }

  static List<OrderModel> getOrderList() {
    List<OrderModel> subCatList = [];

    OrderModel mainModel = new OrderModel();
    mainModel.id = 1;
    mainModel.orderId = "#0012345";
    mainModel.items = "12 Items";
    mainModel.type = "On Delivery";
    subCatList.add(mainModel);

    mainModel = new OrderModel();
    mainModel.id = 2;
    mainModel.orderId = "#0012346";
    mainModel.items = "5 Items";
    mainModel.type = "Completed";
    subCatList.add(mainModel);

    mainModel = new OrderModel();
    mainModel.id = 3;
    mainModel.orderId = "#0012347";
    mainModel.items = "10 Items";
    mainModel.type = "Canceled";
    subCatList.add(mainModel);

    mainModel = new OrderModel();
    mainModel.id = 4;
    mainModel.orderId = "#0012348";
    mainModel.items = "8 Items";
    mainModel.type = "Completed";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<OrderDescModel> getOrderDescList() {
    List<OrderDescModel> subCatList = [];

    OrderDescModel mainModel = new OrderDescModel();
    mainModel.name = "Order Placed";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = new OrderDescModel();
    mainModel.name = "Order Confirmed";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = new OrderDescModel();
    mainModel.name = "Your Order On Delivery by Courier";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = new OrderDescModel();
    mainModel.name = "Order Delivered";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 0;
    subCatList.add(mainModel);

    return subCatList;
  }
}
