import 'package:eco_product_ui_updated/my_models/categories_model.dart';
import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/FormatMoney.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../generated/l10n.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/SizeConfig.dart';
import '../widget/my_widget/ProductDetailPage.dart';

class AllDataWidget extends StatefulWidget {
  @override
  _AllDataWidget createState() {
    return _AllDataWidget();
  }
}

class _AllDataWidget extends State<AllDataWidget> {
  List<CategoriesModel> categoryModelList = [];
  List<SubCategoriesModel> productList = [];
  List<int> favoriteIds = []; // Thêm list chứa id của favorite products
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  int _selectedCategory = 0;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    try {
      setState(() => isLoading = true);

      // Load đồng thời categories và favorites
      final results = await Future.wait([
        _apiService.getCategories(),
        _apiService.getFavorites(),
      ]);

      // Parse kết quả
      final categories = results[0] as List<CategoriesModel>;
      final favorites = results[1] as List<SubCategoriesModel>;

      // Lấy danh sách id các sản phẩm favorite
      final favIds = favorites.map((f) => f.id).toList();

      setState(() {
        categoryModelList = categories;
        favoriteIds = favIds;
        if (categories.isNotEmpty) {
          _selectedCategory = categories[0].id;
        }
      });

      // Load sản phẩm của category đầu tiên
      if (categories.isNotEmpty) {
        await loadProductsByCategory(categories[0].id);
      }
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        categoryModelList = [];
        productList = [];
        favoriteIds = [];
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> loadProductsByCategory(int categoryId) async {
    try {
      setState(() => isLoading = true);
      final products = await _apiService.getProducts(categoryId: categoryId);
      setState(() {
        productList = products;
        _selectedCategory = categoryId;
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() => productList = []);
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Thêm method check favorite
  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: ConstantData.bgColor,
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

    double leftMargin = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ConstantData.bgColor,
        elevation: 0,
        centerTitle: true,
        title: ConstantWidget.getAppBarText(S.of(context).categories),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: loadData,
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.03,
                      bottom: MediaQuery.of(context).size.width * 0.01),
                  height: MediaQuery.of(context).size.width * 0.09,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryModelList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categoryModelList[index];
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: leftMargin),
                            decoration: BoxDecoration(
                              color: (_selectedCategory == category.id)
                                  ? ConstantData.primaryColor
                                  : ConstantData.whiteColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Text(
                                category.name,
                                style: TextStyle(
                                  color: (_selectedCategory == category.id)
                                      ? ConstantData.whiteColor
                                      : ConstantData.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ConstantData.font12Px,
                                ),
                              ),
                            )),
                          ),
                          onTap: () {
                            print(
                                "Clicking category: ${category.name} with id: ${category.id}");
                            if (_selectedCategory != category.id) {
                              loadProductsByCategory(category.id);
                            }
                          },
                        );
                      })),
              Expanded(
                child: productList.isEmpty
                    ? Center(child: Text('No products found'))
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: leftMargin),
                        child: GridView.count(
                          crossAxisCount: _crossAxisCount,
                          childAspectRatio: _aspectRatio,
                          children: List.generate(
                            productList.length,
                            (index) => BackGroundTile(
                              subCategoryModel: productList[index],
                              cellHeight: cellHeight,
                              isFavorite: isFavorite(productList[index].id),
                              onToggleFavorite: (id) async {
                                try {
                                  if (isFavorite(id)) {
                                    await _apiService.removeFavorite(id);
                                    setState(() {
                                      favoriteIds.remove(id);
                                    });
                                  } else {
                                    await _apiService.addFavorite(id);
                                    setState(() {
                                      favoriteIds.add(id);
                                    });
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Failed to update favorite')));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackGroundTile extends StatelessWidget {
  final SubCategoriesModel subCategoryModel;
  final double cellHeight;
  final bool isFavorite;
  final Function(int) onToggleFavorite;

  BackGroundTile({
    required this.subCategoryModel,
    required this.cellHeight,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

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
              BoxShadow(color: Colors.grey.shade200, blurRadius: 10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Discount & Favorite Row
            if (subCategoryModel.discount != "0")
              Container(
                height: topCellHeight,
                child: Row(
                  children: [
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
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size:
                            ConstantWidget.getPercentSize(bottomRemainSize, 15),
                      ),
                      onPressed: () => onToggleFavorite(subCategoryModel.id),
                    ),
                  ],
                ),
              ),

            // Product Image
            Container(
              height: imageSize,
              margin: EdgeInsets.all(
                  ConstantWidget.getPercentSize(bottomRemainSize, 5)),
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

            // Product Name
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      ConstantWidget.getPercentSize(bottomRemainSize, 5)),
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

            // Price
            Padding(
              padding: EdgeInsets.only(
                top: ConstantWidget.getPercentSize(bottomRemainSize, 3),
              ),
              child: Text(
                subCategoryModel.price.toVND(), // Sử dụng extension method
                style: TextStyle(
                  color: ConstantData.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ConstantWidget.getPercentSize(bottomRemainSize, 12),
                ),
              ),
            ),

            // Rating
            Container(
              margin: EdgeInsets.only(
                top: ConstantWidget.getPercentSize(bottomRemainSize, 3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating:
                        double.tryParse(subCategoryModel.rating) ?? 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize:
                        ConstantWidget.getPercentSize(bottomRemainSize, 12),
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(width: 4),
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
