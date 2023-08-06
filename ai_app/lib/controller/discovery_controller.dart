import 'package:app/contants/api_path.dart';
import 'package:app/models/discovery_model.dart';
import 'package:app/network/api_client.dart';
import 'package:app/utils/store_util.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';

class DisCoveryController extends GetxController {
  // discovery列表
  var discoverList = <Records>[].obs;

  @override
  void onInit() {
    super.onInit();

    queryDiscoveryList();
  }

  // 查询discovery列表
  void queryDiscoveryList({Function? successCallback}) async {
    await SpUtil.getInstance();

    if (StoreUtil.isLogin()) {
      ApiClient().post(ApiPath.queryDiscoveryApi,
          data: {'pageIndex': 1, 'pageSize': 100}, successCallback: (data) {
        DiscoveryModel model = DiscoveryModel.fromJson(data);
        discoverList.value = model.records ?? [];
      });
    }
  }
}
