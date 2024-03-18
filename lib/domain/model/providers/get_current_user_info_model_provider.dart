import 'package:get/get.dart';

import 'package:getx_boilerplate/domain/model/get_current_user_info_model_model.dart';

class GetCurrentUserInfoModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return GetCurrentUserInfoModel.fromJson(map);
      }
      if (map is List) {
        return map
            .map((item) => GetCurrentUserInfoModel.fromJson(item))
            .toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<GetCurrentUserInfoModel?> getGetCurrentUserInfoModel(int id) async {
    final response = await get('getcurrentuserinfomodel/$id');
    return response.body;
  }

  Future<Response<GetCurrentUserInfoModel>> postGetCurrentUserInfoModel(
          GetCurrentUserInfoModel getcurrentuserinfomodel) async =>
      await post('getcurrentuserinfomodel', getcurrentuserinfomodel);
  Future<Response> deleteGetCurrentUserInfoModel(int id) async =>
      await delete('getcurrentuserinfomodel/$id');
}
