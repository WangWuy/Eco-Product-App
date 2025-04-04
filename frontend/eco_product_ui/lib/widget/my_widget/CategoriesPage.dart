import 'package:eco_product_ui_updated/my_models/categories_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:flutter/material.dart';


import '../../generated/l10n.dart';
import '../../utils/ConstantData.dart';
import '../../utils/ConstantWidget.dart';
import '../../utils/SizeConfig.dart';
import 'SubCategoriesPage.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPage createState() {
    return _CategoriesPage();
  } 
}

class _CategoriesPage extends State<CategoriesPage> {
  List<CategoriesModel> categoryModelList = [];
  final ApiService _apiService = ApiService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      setState(() => isLoading = true);
      final categories = await _apiService.getCategories();
      setState(() {
        categoryModelList = categories;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading categories: $e');
      setState(() {
        categoryModelList = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading categories. Please try again.')),
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
          title: ConstantWidget.getAppBarText(S.of(context).categories),
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
    double viewWidth = SizeConfig.safeBlockVertical! * 20;
    var _crossAxisSpacing = 1;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = _width;
    var _aspectRatio = _width / cellHeight;

    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: ConstantData.bgColor,
          title: ConstantWidget.getAppBarText(S.of(context).categories),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: ConstantWidget.getAppBarIcon(),
                onPressed: _requestPop,
              );
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Stack(
            children: [
              if (categoryModelList.isEmpty)
                Center(child: Text('No categories found'))
              else
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.01),
                  child: GridView.count(
                    crossAxisCount: _crossAxisCount,
                    shrinkWrap: true,
                    childAspectRatio: _aspectRatio,
                    primary: false,
                    children: List.generate(categoryModelList.length, (index) {
                      return BackGroundTile(
                        subCategoryModel: categoryModelList[index],
                        cellHeight: cellHeight,
                      );
                    }),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 2),
                  width: viewWidth,
                  height: 5,
                  color: ConstantData.viewColor,
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: _requestPop,
    );
  }
}

// Sửa lại BackGroundTile để hiển thị ảnh từ network
class BackGroundTile extends StatelessWidget {
  final CategoriesModel? subCategoryModel;
  final double? cellHeight;

  BackGroundTile({this.subCategoryModel, this.cellHeight});

  @override
  Widget build(BuildContext context) {
    double imageSize = ConstantWidget.getPercentSize(cellHeight!, 56);
    double radius = ConstantWidget.getPercentSize(cellHeight!, 5);
    double bottomRemainSize = cellHeight! - imageSize;

    return InkWell(
      child: Container(
        height: cellHeight,
        margin: EdgeInsets.all(ConstantWidget.getPercentSize(cellHeight!, 2)),
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
            Container(
              height: imageSize,
              width: double.infinity,
              margin: EdgeInsets.only(
                  left: ConstantWidget.getPercentSize(imageSize, 9),
                  right: ConstantWidget.getPercentSize(imageSize, 9),
                  top: ConstantWidget.getPercentSize(imageSize, 9)),
              decoration: BoxDecoration(
                color: ConstantData.cellColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Image.network(
                  subCategoryModel!.image,
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
            ),
            ConstantWidget.getSpace(
                ConstantWidget.getPercentSize(cellHeight!, 5)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ConstantWidget.getPercentSize(cellHeight!, 0.5)),
              child: ConstantWidget.getCustomText(
                  subCategoryModel!.name,
                  ConstantData.textColor1,
                  1,
                  TextAlign.center,
                  FontWeight.w800,
                  ConstantWidget.getPercentSize(bottomRemainSize, 13)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ConstantWidget.getPercentSize(cellHeight!, 2),
                  horizontal: ConstantWidget.getPercentSize(cellHeight!, 0.5)),
              child: ConstantWidget.getCustomText(
                  subCategoryModel!.desc,
                  ConstantData.textColor,
                  1,
                  TextAlign.start,
                  FontWeight.w500,
                  ConstantWidget.getPercentSize(bottomRemainSize, 12)),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCategoriesPage(subCategoryModel!.id)));
      },
    );
  }
}
