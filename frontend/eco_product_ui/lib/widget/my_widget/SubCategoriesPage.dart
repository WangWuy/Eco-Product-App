// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/my_models/categories_model.dart';
import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/utils/FormatMoney.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

import 'ProductDetailPage.dart';

class SubCategoriesPage extends StatefulWidget {
  final int subId;

  SubCategoriesPage(this.subId);

  @override
  _SubCategoriesPage createState() {
    return _SubCategoriesPage(this.subId);
  }
}

class _SubCategoriesPage extends State<SubCategoriesPage> {
  List<SubCategoriesModel> subList = [];
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  String? title;
  final int subId;

  _SubCategoriesPage(this.subId);

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      setState(() => isLoading = true);

      // Load products by category ID
      final products = await _apiService.getProducts(categoryId: subId);

      // Get category info to display title
      final categories = await _apiService.getCategories();
      final category = categories.firstWhere(
        (cat) => cat.id == subId,
        orElse: () => CategoriesModel(), // Default empty model
      );

      setState(() {
        subList = products;
        title = category.name;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() {
        subList = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading products. Please try again.')),
      );
    }
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: ConstantData.bgColor,
          title: ConstantWidget.getAppBarText(
              (title != null) ? title! : S.of(context).categories),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: ConstantWidget.getAppBarIcon(),
                onPressed: _requestPop,
              );
            },
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    SizeConfig().init(context);

    var _crossAxisSpacing = 1;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = SizeConfig.safeBlockVertical! * 36;
    var _aspectRatio = _width / cellHeight;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            // title: ConstantWidget.getCustomTextWithoutAlign((title != null) ? title : S.of(context).categories,ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),
            title: ConstantWidget.getAppBarText(
                (title != null) ? title! : S.of(context).categories),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: subList.isEmpty
              ? Center(child: Text('No products found in this category'))
              : Container(
                  margin: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: MediaQuery.of(context).size.width * 0.01),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: _aspectRatio,
                    children: List.generate(subList.length, (index) {
                      return BackGroundTile(
                        subCategoryModel: subList[index],
                        cellHeight: cellHeight,
                      );
                    }),
                  ),
                ),
        ),
        onWillPop: _requestPop);
  }
}

class BackGroundTile extends StatelessWidget {
  final SubCategoriesModel subCategoryModel;
  final double cellHeight;

  BackGroundTile({required this.subCategoryModel, required this.cellHeight});

  @override
  Widget build(BuildContext context) {
    double imageSize = ConstantWidget.getPercentSize(cellHeight, 42);
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double radius = ConstantWidget.getPercentSize(cellHeight, 5);
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;

    return InkWell(
      child: Container(
        height: cellHeight,
        margin: EdgeInsets.all(ConstantWidget.getPercentSize(cellHeight, 2)),
        decoration: BoxDecoration(
            color: ConstantData.whiteColor,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Discount & Favorite Row
            Container(
              height: topCellHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (subCategoryModel.discount != "0")
                    Container(
                      height: topCellHeight,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: ConstantData.accentColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            bottomRight: Radius.circular(radius)),
                      ),
                      child: Center(
                        child: Text(
                          "${subCategoryModel.discount}% OFF",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ConstantWidget.getPercentSize(
                                bottomRemainSize, 10),
                          ),
                        ),
                      ),
                    ),
                  Spacer(),
                  Icon(
                    subCategoryModel.isFav == 1
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                    size: ConstantWidget.getPercentSize(bottomRemainSize, 15),
                  ),
                  SizedBox(
                      width:
                          ConstantWidget.getPercentSize(bottomRemainSize, 2)),
                ],
              ),
            ),

            // Product Image
            Container(
              height: imageSize,
              width: double.infinity,
              margin: EdgeInsets.all(
                  ConstantWidget.getPercentSize(bottomRemainSize, 4)),
              decoration: BoxDecoration(
                color: ConstantData.cellColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Image.network(
                subCategoryModel.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),

            SizedBox(
                height: ConstantWidget.getPercentSize(bottomRemainSize, 5)),

            // Product Name
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      ConstantWidget.getPercentSize(bottomRemainSize, 4)),
              child: Text(
                subCategoryModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ConstantWidget.getPercentSize(bottomRemainSize, 10),
                ),
              ),
            ),

            SizedBox(
                height: ConstantWidget.getPercentSize(bottomRemainSize, 3)),

            // Price
            Text(
              subCategoryModel.price.toVND(),
              style: TextStyle(
                color: ConstantData.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: ConstantWidget.getPercentSize(bottomRemainSize, 12),
              ),
            ),

            SizedBox(
                height: ConstantWidget.getPercentSize(bottomRemainSize, 3)),

            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: double.tryParse(subCategoryModel.rating) ?? 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: ConstantWidget.getPercentSize(bottomRemainSize, 12),
                  ignoreGestures: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(
                    width: ConstantWidget.getPercentSize(bottomRemainSize, 2)),
                Text(
                  "(${subCategoryModel.rating})",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize:
                        ConstantWidget.getPercentSize(bottomRemainSize, 9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(subCategoryModel)),
        );
      },
    );
  }
}
