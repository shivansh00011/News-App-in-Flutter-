import 'package:newsapp/model/category_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.image = "assets/buisness.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "assets/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "General";
  categoryModel.image = "assets/general.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Health";
  categoryModel.image = "assets/medical.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Science";
  categoryModel.image = "assets/science.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.image = "assets/sport.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;

}