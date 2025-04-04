import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/FormatMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/DataFile.dart';
import '../generated/l10n.dart';
import '../model/ProfileModel.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/SizeConfig.dart';
import '../widget/FilterPage.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidget createState() {
    return _SearchWidget();
  }
}

class _SearchWidget extends State<SearchWidget> {
  ProfileModel profileModel = DataFile.getProfileModel();

  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<SubCategoriesModel> trendingList = [];
  bool isLoading = false;

  var tags = [];

  @override
  void initState() {
    super.initState();
    profileModel = DataFile.getProfileModel();
    loadRecommendedProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadRecommendedProducts() async {
    try {
      setState(() => isLoading = true);
      final products = await _apiService.getProducts(type: 'Recommended');
      setState(() {
        trendingList = products;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading recommended products: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      loadRecommendedProducts();
      return;
    }

    try {
      setState(() => isLoading = true);
      final products = await _apiService.getProducts(
        type: '',
        search: query,
      );
      setState(() {
        trendingList = products;
        isLoading = false;
      });
    } catch (e) {
      print('Error searching products: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.04;
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double imageSize1 = SizeConfig.safeBlockVertical! * 4;

    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        backgroundColor: ConstantData.bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: ConstantWidget.getAppBarText(S.of(context).search),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list_alt,
              color: ConstantData.iconColor,
            ),
            onPressed: () {
              // do something

              FocusScope.of(context).requestFocus(new FocusNode());

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FilterPage()));
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: leftMargin,
            right: leftMargin,
            top: leftMargin,
            bottom: MediaQuery.of(context).size.width * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: imageSize,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 1))
                          ]),
                      child: TextField(
                        controller: _searchController,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: ConstantData.font12Px),
                        decoration: InputDecoration(
                          hintText: S.of(context).searchHint,
                          hintStyle: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: ConstantData.font12Px),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 3, left: 8),
                        ),
                        onSubmitted: (value) {
                          searchProducts(value);
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: imageSize,
                      width: imageSize,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ConstantData.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Icon(
                        CupertinoIcons.search,
                        color: ConstantData.whiteColor,
                        size: imageSize1,
                      )),
                    ),
                    onTap: () {
                      searchProducts(_searchController.text);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: ConstantWidget.getCustomText(
                  S.of(context).recommended,
                  ConstantData.textColor,
                  1,
                  TextAlign.start,
                  FontWeight.w800,
                  ConstantData.font18Px),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : trendingList.isEmpty
                      ? Center(child: Text('No products found'))
                      : Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.03,
                              bottom: MediaQuery.of(context).size.width * 0.01),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: trendingList.length,
                              itemBuilder: (context, index) {
                                return getRecommendedCell(trendingList[index]);
                              }),
                        ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget getRecommendedCell(SubCategoriesModel model) {
    double imageSize = SizeConfig.safeBlockVertical! * 12;
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: ConstantData.whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
              )
            ]),
        margin: EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: imageSize,
                  width: imageSize,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: ConstantData.cellColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Image.network(
                    model.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, color: Colors.red);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstantWidget.getCustomText(
                          model.name,
                          ConstantData.textColor,
                          1,
                          TextAlign.start,
                          FontWeight.w800,
                          ConstantData.font18Px),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 15),
                        child: ConstantWidget.getCustomText(
                            model.desc,
                            ConstantData.textColor,
                            1,
                            TextAlign.start,
                            FontWeight.w500,
                            ConstantWidget.getScreenPercentSize(context, 1.9)),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ConstantWidget.getCustomText(
                            model.price.toVND(),
                            ConstantData.accentColor,
                            1,
                            TextAlign.start,
                            FontWeight.w700,
                            ConstantWidget.getScreenPercentSize(context, 2.3)),
                      ),
                    ],
                  ),
                  flex: 1,
                )
              ],
            ),

            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: ConstantWidget.getScreenPercentSize(context, 5),
                  width: ConstantWidget.getScreenPercentSize(context, 5),
                  decoration: BoxDecoration(
                    color: ConstantData.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Transform.scale(
                    scale: -1,
                    child: Center(
                      child: Icon(Icons.arrow_back_sharp,
                          color: Colors.white,
                          size:
                              ConstantWidget.getScreenPercentSize(context, 3)),
                    ),
                  ),
                ),
              ),
            ),

            //   ],
            // )
          ],
        ),
      ),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ProductDetailPage(model)));
      },
    );
  }

  generateTags() {
    return tags.map((tag) => getChip(tag)).toList();
  }

  Widget getChip(name) {
    return Chip(
        backgroundColor: ConstantData.bgColor,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: ConstantData.viewColor,
                width: 1,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        label: Text(
          name,
          style: TextStyle(
              color: ConstantData.textColor,
              fontWeight: FontWeight.w500,
              fontSize: ConstantData.font12Px,
              fontFamily: ConstantData.fontFamily),
        ));
  }
}
