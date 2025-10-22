import 'package:get/get.dart';
import 'package:getx_boilerplate/app/network/api_client.dart';
import 'package:getx_boilerplate/domain/model/get_current_user_info_model_model.dart';

class GetCurrentUserInfoModelProvider {
  final AppApiClient _api = Get.find<AppApiClient>();

  Future<GetCurrentUserInfoModel?> getGetCurrentUserInfoModel(int id) async {
    final resp = await _api.getJson<Map<String, dynamic>>('getcurrentuserinfomodel/$id');
    final data = resp.data;
    if (data == null) return null;
    return GetCurrentUserInfoModel.fromJson(data);
  }

  Future<GetCurrentUserInfoModel> postGetCurrentUserInfoModel(
      GetCurrentUserInfoModel getcurrentuserinfomodel) async {
    final resp = await _api.postJson<Map<String, dynamic>>(
      'getcurrentuserinfomodel',
      data: getcurrentuserinfomodel.toJson(),
    );
    return GetCurrentUserInfoModel.fromJson(resp.data ?? {});
  }

  Future<void> deleteGetCurrentUserInfoModel(int id) async {
    await _api.dio.delete('getcurrentuserinfomodel/$id');
  }
}
