import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/utils/FormatMoney.dart';
import 'package:eco_product_ui_updated/utils/MySeparator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/model/ReviewModel.dart';

import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:eco_product_ui_updated/widget/my_widget/AddToCartPage.dart';

class ProductDetailPage extends StatefulWidget {
  final SubCategoriesModel subCategoryModel;

  ProductDetailPage(this.subCategoryModel);

  @override
  _ProductDetailPage createState() {
    return _ProductDetailPage(this.subCategoryModel);
  }
}

class _ProductDetailPage extends State<ProductDetailPage> {
  SubCategoriesModel subCategoryModel;
  List<ReviewModel> reViewModelList = [];
  List<Color> colorList = [
    Colors.deepOrangeAccent,
    Colors.yellow,
    Colors.green,
    Colors.blue
  ];
  final ApiService _apiService = ApiService();
  bool isLoading = true;

  int _itemSize = 1;
  bool _isExpand = false;
  List<SubCategoriesModel> popularList = [];

  double _index = 0;
  PageController controller = PageController();
  List<int> favoriteIds = [];

  _ProductDetailPage(this.subCategoryModel);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        _index = controller.page!;
      });
    });
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      setState(() => isLoading = true);

      // Load song song product detail, favorites và related products
      final results = await Future.wait([
        _apiService.getProductDetail(subCategoryModel.id),
        _apiService.getFavorites(),
        _apiService.getProducts(type: 'Popular'),
      ]);

      // Parse results
      final productDetail = results[0] as SubCategoriesModel;
      final favorites = results[1] as List<SubCategoriesModel>;
      final relatedProducts = results[2] as List<SubCategoriesModel>;

      // Lấy danh sách id products yêu thích
      final favIds = favorites.map((f) => f.id).toList();

      setState(() {
        subCategoryModel = productDetail;
        favoriteIds = favIds;
        popularList = relatedProducts;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error loading product details. Please try again.')),
      );
    }
  }

  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  Future<void> toggleFavorite(int productId) async {
    try {
      if (isFavorite(productId)) {
        await _apiService.removeFavorite(productId);
        setState(() => favoriteIds.remove(productId));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Removed from favorites')));
      } else {
        await _apiService.addFavorite(productId);
        setState(() => favoriteIds.add(productId));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Added to favorites')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update favorite')));
    }
  }

  Future<void> _addToCart({bool navigateToCart = false}) async {
    try {
      await _apiService.addToCart(subCategoryModel.id, _itemSize);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).productAdded)),
      );

      if (navigateToCart) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddToCartPage()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart')),
      );
    }
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 18 : 15,
      width: isActive ? 18 : 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? ConstantData.primaryColor : Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: _requestPop,
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    SizeConfig().init(context);
    double sliderHeight = SizeConfig.safeBlockVertical! * 40;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.transparent,
                              leading: InkWell(
                                onTap: () {
                                  _requestPop();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.grey,
                                ),
                              ),
                              actions: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    isFavorite(subCategoryModel.id)
                                        ? Icons.favorite
                                        : Icons.favorite_border_rounded,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      toggleFavorite(subCategoryModel.id),
                                )
                              ],
                              expandedHeight: sliderHeight,
                              flexibleSpace: FlexibleSpaceBar(
                                  centerTitle: false,
                                  background: Container(
                                      color: ConstantData.cellColor,
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Stack(children: [
                                        PageView.builder(
                                          controller: controller,
                                          itemCount: 3,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Image.network(
                                              subCategoryModel.image,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Icon(Icons.error,
                                                    color: Colors.red);
                                              },
                                            );
                                          },
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.all(0),
                                              child: _drawDots(_index),
                                            ))
                                      ])))),
                        ];
                      },
                      body: Container(
                        color: ConstantData.cellColor,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35))),
                          child: SingleChildScrollView(
                              padding: EdgeInsets.only(top: 20),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 2, left: 20, right: 20),
                                        child: Text(subCategoryModel.name,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 3),
                                                fontFamily:
                                                    ConstantData.fontFamily,
                                                color: Colors.black87,
                                                decoration:
                                                    TextDecoration.none)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 2,
                                            bottom: 15,
                                            left: 20,
                                            right: 20),
                                        child: Text(
                                            subCategoryModel.desc +
                                                " " +
                                                subCategoryModel.desc,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 1.5),
                                                fontFamily:
                                                    ConstantData.fontFamily,
                                                color: ConstantData.textColor,
                                                decoration:
                                                    TextDecoration.none)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 0, left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: getCell(
                                                  subCategoryModel.reviewDesc
                                                      .toString()
                                                      .replaceAll("(", "")
                                                      .replaceAll(")", ""),
                                                  Icons.star),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: getCell(
                                                  "30,000",
                                                  Icons
                                                      .local_shipping_outlined),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: getCell("Within 1 day",
                                                  Icons.timer_outlined),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(
                                              bottom: 0, left: 20, right: 20),
                                          margin: EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Color :".toUpperCase(),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: ConstantData
                                                          .fontFamily,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize:
                                                          ConstantData.font15Px,
                                                      color: Colors.black87,
                                                      decoration:
                                                          TextDecoration.none)),
                                              Container(
                                                height: ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 5),
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: colorList.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5),
                                                          height: ConstantWidget
                                                              .getScreenPercentSize(
                                                                  context, 4),
                                                          width: ConstantWidget
                                                              .getScreenPercentSize(
                                                                  context, 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colorList[
                                                                index],
                                                            shape:
                                                                BoxShape.circle,
                                                          ));
                                                    }),
                                              )
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 0, left: 20, right: 20),
                                          child: InkWell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.star_fill,
                                                  color: Colors.amber,
                                                  size: ConstantWidget
                                                      .getScreenPercentSize(
                                                          context, 2.5),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                      "${subCategoryModel.rating} (${reViewModelList.length} reviews)",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ConstantData
                                                                  .fontFamily,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: ConstantData
                                                              .font12Px,
                                                          color: Colors.black87,
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    _isExpand
                                                        ? Icons.expand_less
                                                        : Icons.expand_more,
                                                    size: 15,
                                                    color:
                                                        ConstantData.textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              if (_isExpand) {
                                                _isExpand = false;
                                              } else {
                                                _isExpand = true;
                                              }
                                              setState(() {});
                                            },
                                          )),
                                      Visibility(
                                        child: ListView.builder(
                                          itemCount: reViewModelList.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return _reViewCell(
                                                reViewModelList[index], index);
                                          },
                                        ),
                                        visible: _isExpand,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: ConstantWidget.getCustomText(
                                            S.of(context).youMayAlsoLike,
                                            ConstantData.textColor1,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w800,
                                            ConstantData.font18Px),
                                      ),
                                      Container(
                                          height:
                                              SizeConfig.safeBlockVertical! *
                                                  34,
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: popularList.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return _popularCell(
                                                    popularList[index]);
                                              })),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 25,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(S.of(context).price.toVND(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: ConstantData.font12Px,
                                color: ConstantData.textColor,
                                decoration: TextDecoration.none)),
                      ),
                      Container(
                        height: SizeConfig.safeBlockVertical! * 6,
                        margin: EdgeInsets.only(
                            bottom: ConstantWidget.getScreenPercentSize(
                                context, 1.2)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              subCategoryModel.price.toVND(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 2.5),
                                color: Colors.black87,
                              ),
                            ),
                            new Spacer(),
                            InkWell(
                              child: Container(
                                height: ConstantWidget.getScreenPercentSize(
                                    context, 4.5),
                                width: ConstantWidget.getScreenPercentSize(
                                    context, 4.5),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1,
                                        color: ConstantData.textColor)),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: ConstantWidget.getScreenPercentSize(
                                        context, 4),
                                    color: ConstantData.textColor,
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (_itemSize > 1) {
                                  setState(() => _itemSize--);
                                }
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: ConstantWidget.getCustomText(
                                  _itemSize.toString(),
                                  ConstantData.textColor,
                                  1,
                                  TextAlign.end,
                                  FontWeight.w500,
                                  16),
                            ),
                            InkWell(
                              child: Container(
                                height: ConstantWidget.getScreenPercentSize(
                                    context, 4.5),
                                width: ConstantWidget.getScreenPercentSize(
                                    context, 4.5),
                                decoration: BoxDecoration(
                                    color: ConstantData.primaryColorWithOpacity,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1,
                                        color: ConstantData
                                            .primaryColorWithOpacity)),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: ConstantWidget.getScreenPercentSize(
                                        context, 4),
                                    color: ConstantData.primaryColor,
                                  ),
                                ),
                              ),
                              onTap: () => setState(() => _itemSize++),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: const MySeparator(color: Colors.grey),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  height: (SizeConfig.safeBlockVertical! * 7),
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          S.of(context).buyNow,
                                          ConstantData.textColor,
                                          FontWeight.bold,
                                          ConstantData.font18Px),
                                    ],
                                  ),
                                ),
                                onTap: () => _addToCart(navigateToCart: true),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  height: (SizeConfig.safeBlockVertical! * 7),
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: ConstantData.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          S.of(context).addToCart,
                                          Colors.white,
                                          FontWeight.bold,
                                          ConstantData.font18Px),
                                    ],
                                  ),
                                ),
                                onTap: () => _addToCart(),
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        onWillPop: _requestPop);
  }

  _drawDots(page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < 3; i++) dot((page == i)),
      ],
    );
  }

  dot(bool selected) {
    double size = 12;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 2, left: 2, bottom: 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (selected) ? ConstantData.primaryColor : Colors.white),
      ),
    );
  }

  Widget _popularCell(SubCategoriesModel subCategoryModel) {
    double containerWidth = SizeConfig.safeBlockHorizontal! * 36;
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double height = SizeConfig.safeBlockVertical! * 34;
    double image = ConstantWidget.getPercentSize(height, 25);
    double remainSize = height - image;

    double cellSize = ConstantWidget.getPercentSize(remainSize, 16);

    return InkWell(
      child: Container(
        width: containerWidth,
        height: height,
        margin: EdgeInsets.only(
            left: leftMargin,
            top: ConstantWidget.getPercentSize(height, 7),
            bottom: ConstantWidget.getPercentSize(height, 7)),
        decoration: BoxDecoration(
            color: ConstantData.whiteColor,
            borderRadius:
                BorderRadius.circular(ConstantWidget.getPercentSize(height, 6)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.all(ConstantWidget.getPercentSize(height, 3)),
                decoration: BoxDecoration(
                  color: ConstantData.cellColor,
                  borderRadius: BorderRadius.circular(
                      ConstantWidget.getPercentSize(height, 6)),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.all(
                            ConstantWidget.getPercentSize(image, 8)),
                        padding: EdgeInsets.all(
                            ConstantWidget.getPercentSize(image, 8)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          isFavorite(subCategoryModel.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite(subCategoryModel.id)
                              ? Colors.red
                              : ConstantData.textColor,
                          size: ConstantWidget.getPercentSize(image, 25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          ConstantWidget.getPercentSize(image, 5)),
                      child: Center(
                        child: Image.network(
                          subCategoryModel.image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ConstantWidget.getPercentSize(remainSize, 6),
                    horizontal: ConstantWidget.getPercentSize(remainSize, 6)),
                child: ConstantWidget.getCustomText(
                    subCategoryModel.name,
                    ConstantData.textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w800,
                    ConstantWidget.getPercentSize(remainSize, 8))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: ConstantWidget.getPercentSize(remainSize, 6),
                        right: ConstantWidget.getPercentSize(remainSize, 6),
                        bottom: ConstantWidget.getPercentSize(remainSize, 6)),
                    child: ConstantWidget.getCustomText(
                        subCategoryModel.price.toVND(),
                        Colors.black87,
                        1,
                        TextAlign.start,
                        FontWeight.bold,
                        ConstantWidget.getPercentSize(remainSize, 8))),
                new Spacer(),
                Container(
                  margin: EdgeInsets.only(
                      left: ConstantWidget.getPercentSize(remainSize, 6),
                      right: ConstantWidget.getPercentSize(remainSize, 6),
                      bottom: ConstantWidget.getPercentSize(remainSize, 6)),
                  height: cellSize,
                  width: cellSize,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: ConstantData.textColor.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: Offset(0, 3))
                    ],
                    color: ConstantData.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        ConstantWidget.getPercentSize(cellSize, 15))),
                  ),
                  child: Transform.scale(
                    scale: -1,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                        size: ConstantWidget.getPercentSize(cellSize, 50),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(subCategoryModel)));
      },
    );
  }

  Widget _reViewCell(ReviewModel reViewModel, int index) {
    double imageSize = SizeConfig.safeBlockVertical! * 5;
    double leftMargin = SizeConfig.safeBlockVertical! * 1.2;
    return Container(
      margin: EdgeInsets.only(
          top: (index == 0) ? 0 : 5, bottom: 5, left: 20, right: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ConstantData.whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
            )
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: imageSize,
                width: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: ExactAssetImage(
                        ConstantData.assetsPath + reViewModel.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: leftMargin),
                child: ConstantWidget.getCustomText(
                    reViewModel.name,
                    ConstantData.textColor,
                    1,
                    TextAlign.start,
                    FontWeight.bold,
                    ConstantData.font15Px),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: (imageSize + leftMargin)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                  itemSize: 15,
                  initialRating: reViewModel.review,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  tapOnlyMode: true,
                  updateOnDrag: true,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 10,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ConstantWidget.getCustomText(
                      reViewModel.desc,
                      ConstantData.primaryTextColor,
                      2,
                      TextAlign.start,
                      FontWeight.w400,
                      10),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getCell(String s, var icon) {
    return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ConstantData.accentColor,
              size: ConstantWidget.getScreenPercentSize(context, 3),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(s,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: ConstantData.font12Px,
                      color: Colors.black87,
                      decoration: TextDecoration.none)),
            ),
          ],
        ));
  }
}
