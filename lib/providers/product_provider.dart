import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';
import '../services/api_helper.dart';

final productProvider=StateNotifierProvider<ProductsBloc,ProductsModel>((ref) => ProductsBloc(ref));
class ProductsBloc extends StateNotifier<ProductsModel>{
  ProductsModel? productsModel;
  Ref ref;
  ProductsBloc(this.ref):super(ProductsModel()){
    getProductsData();
  }
  getProductsData() async {
    productsModel=null;
   productsModel= await ApiHelper.getProductsList();
   state=productsModel!;
  }
  queryData(String ph) async {
   productsModel=null;
   productsModel= await ApiHelper.queryData(ph);
   state=productsModel!;
  }
}