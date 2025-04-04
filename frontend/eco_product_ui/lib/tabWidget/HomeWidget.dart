import 'package:carousel_slider/carousel_slider.dart';
import 'package:eco_product_ui_updated/my_models/categories_model.dart';
import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/FormatMoney.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../model/DiscModel.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/SizeConfig.dart';
import '../widget/my_widget/AddToCartPage.dart';
import '../widget/my_widget/CategoriesPage.dart';
import '../widget/FilterPage.dart';
import '../widget/my_widget/ProductDetailPage.dart';
import '../widget/my_widget/SubCategoriesPage.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidget createState() {
    return _HomeWidget();
  }
}

class _HomeWidget extends State<HomeWidget> {
  List<DiscModel> discModelList = [];
  List<CategoriesModel> categoryModelList = [];
  List<SubCategoriesModel> trendingList = [];
  List<SubCategoriesModel> popularList = [];

  bool isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() => isLoading = true);
      final results = await Future.wait([
        _apiService.getSliders(),
        _apiService.getCategories(),
        _apiService.getProducts(type: 'Trending'),
        _apiService.getProducts(type: 'Popular'),
      ]);

      setState(() {
        discModelList = results[0] as List<DiscModel>;
        categoryModelList = results[1] as List<CategoriesModel>;
        trendingList = results[2] as List<SubCategoriesModel>;
        popularList = results[3] as List<SubCategoriesModel>;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        // Khởi tạo list rỗng khi có lỗi
        categoryModelList = [];
        popularList = [];
        trendingList = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data. Please try again.')),
      );
    }
  }

  void getData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double topMargin = MediaQuery.of(context).size.width * 0.03;
    double imageSize = SizeConfig.safeBlockVertical! * 12;

    final List<Widget> imageSliders = discModelList
        .map((item) => Container(
                child: Container(
              margin: EdgeInsets.all(7),
              child: InkWell(
                onTap: () {},
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                            color: ConstantData.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Image.network(
                            "${ApiService.baseUrl}/${item.image}",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.name.isNotEmpty)
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                if (item.offText.isNotEmpty)
                                  Text(
                                    item.offText,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )))
        .toList();

    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ConstantData.bgColor,
        elevation: 0,
        title: ConstantWidget.getAppBarText(S.of(context).home),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: ConstantData.primaryColor,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddToCartPage()));
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: SizeConfig.safeBlockHorizontal! * 45,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  },
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
              items: imageSliders,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: leftMargin, right: leftMargin, top: leftMargin),
              child: Row(
                children: [
                  ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).categories,
                      ConstantData.textColor,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2)),
                  new Spacer(),
                  InkWell(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).viewAll,
                        ConstantData.textColor1,
                        FontWeight.w800,
                        ConstantWidget.getScreenPercentSize(context, 1.5)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesPage()));
                    },
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.03,
                    bottom: MediaQuery.of(context).size.width * 0.01),
                height: SizeConfig.safeBlockHorizontal! * 29,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: leftMargin),
                    shrinkWrap: true,
                    itemCount: categoryModelList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      double height = SizeConfig.safeBlockHorizontal! * 29;
                      double imageSize =
                          ConstantWidget.getPercentSize(height, 38);
                      double remainSize = height - imageSize;
                      return InkWell(
                        child: Container(
                          width: height,
                          child: Container(
                            margin: EdgeInsets.all(
                                ConstantWidget.getPercentSize(height, 6)),
                            decoration: BoxDecoration(
                                color: ConstantData.whiteColor,
                                borderRadius: BorderRadius.circular(
                                    ConstantWidget.getPercentSize(height, 12)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 3,
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Center(
                                    child: Image.network(
                                      categoryModelList[index].image,
                                      fit: BoxFit.cover,
                                      height: imageSize,
                                      width: imageSize,
                                      // Thêm loading indicator
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      // Xử lý lỗi load ảnh
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.error,
                                            color: Colors.red);
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ConstantWidget.getPercentSize(
                                            remainSize, 6),
                                        left: ConstantWidget.getPercentSize(
                                            remainSize, 2),
                                        right: ConstantWidget.getPercentSize(
                                            remainSize, 2)),
                                    child: ConstantWidget.getCustomText(
                                        categoryModelList[index].name,
                                        ConstantData.textColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        ConstantWidget.getPercentSize(
                                            remainSize, 18)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubCategoriesPage(
                                      categoryModelList[index].id)));
                        },
                      );
                    })),
            Container(
              padding: EdgeInsets.only(
                  left: leftMargin, right: leftMargin, top: topMargin),
              child: Row(
                children: [
                  ConstantWidget.getCustomText(
                      S.of(context).mostPopular,
                      ConstantData.textColor,
                      1,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2)),
                ],
              ),
            ),
            Container(
                height: SizeConfig.safeBlockVertical! * 34,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.01),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: popularList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _popularCell(popularList[index]);
                    })),
            Container(
              padding: EdgeInsets.only(
                  left: leftMargin, right: leftMargin, top: leftMargin),
              child: Row(
                children: [
                  ConstantWidget.getCustomText(
                      S.of(context).trending,
                      ConstantData.textColor,
                      1,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2)),
                  new Spacer(),
                  InkWell(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        "",
                        ConstantData.textColor,
                        FontWeight.w600,
                        ConstantData.font12Px),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilterPage()));
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03,
                  bottom: MediaQuery.of(context).size.width * 0.01),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
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
                        margin: EdgeInsets.only(
                            left: leftMargin, top: 10, right: leftMargin),
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
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Image.network(
                                    trendingList[index].image,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstantWidget.getCustomText(
                                          trendingList[index].name,
                                          ConstantData.textColor,
                                          1,
                                          TextAlign.start,
                                          FontWeight.w800,
                                          ConstantData.font18Px),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 15),
                                        child: ConstantWidget.getCustomText(
                                            trendingList[index].desc,
                                            ConstantData.textColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w500,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 1.9)),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: ConstantWidget.getCustomText(
                                            trendingList[index].price.toVND(),
                                            ConstantData.accentColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w700,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2.3)),
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
                                  height: ConstantWidget.getScreenPercentSize(
                                      context, 5),
                                  width: ConstantWidget.getScreenPercentSize(
                                      context, 5),
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
                                          size: ConstantWidget
                                              .getScreenPercentSize(
                                                  context, 3)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailPage(trendingList[index])));
                      },
                    );
                  }),
            ),
          ],
        ),
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
                          (subCategoryModel.isFav == 1)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (subCategoryModel.isFav == 1)
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
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                Expanded(
                  child: Padding(
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
                ),
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
}
