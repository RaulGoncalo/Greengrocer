import 'package:quitanda/src/constants/endpoints.dart';
import 'package:quitanda/src/models/category_model.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/pages/base/home/result/home_result.dart';
import 'package:quitanda/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  //Responsavel por realizar a requisição rest para a busca das categorias
  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map((e) => CategoryModel.fromJson(e))
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
        'Ocorreu um erro inseperado ao recuperar as categorias',
      );
    }
  }

  //Responsavel por realizar a requisição rest para a busca dos problemas
  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.getAllProducts, method: HttpMethods.post, body: body);

    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map((e) => ItemModel.fromJson(e))
          .toList();

      return HomeResult.success(data);
    } else {
      return HomeResult.error(
        'Ocorreu um erro inseperado ao recuperar os produtos',
      );
    }
  }
}
