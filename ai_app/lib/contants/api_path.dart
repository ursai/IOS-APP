class ApiPath {
  // 手机登陆
  static const loginApi = 'api/login/phone';
  // 轮播图
  static const queryBannerApi = 'api/config/type/3';

  // 发送验证码
  static const sendSmsCodeApi = 'api/send/phone';
  // 查询免费租赁nft
  static const queryFreeNftApi = 'api/nft/rent/list/free';
  // 发送邀请码
  static const sendInvitionCodeApi = 'api/account/invitation';

  // 登出
  static const logoutApi = 'api/logout';
  // 拉取版本信息
  static const updateAppApi = 'api/config/version';

  // 申请升级
  static const accountUpgradeApi = 'api/account/level/upgrade';
  // 礼品兑换
  static const giftRedemApi = 'api/redemption_code/redeem';

  // 加效率和幸运值
  static const addPointApi = 'api/account/level/addPoint';

  // 维修
  static const repairApi = 'api/account/repair';

  // 升级配置信息
  static const upgradeConfigApi = 'api/config/account_level_config';

  // 查询账号信息
  static const queryAccountInfoApi = 'api/account';

  // 查询资产信息
  static const queryAccountAssetApi = 'api/account/asset';

  // 查询商品列表
  static const queryProductListApi = 'api/product/list';

  // 查询商品详情
  static const queryProductDetailsApi = 'api/product/detail';

  // 下单
  static const placeOrderApi = 'api/product/order/submit';

  // 支付
  static const payOrderApi = 'api/product/order/pay';

  // 唤起支付参数
  static const getPayParamApi = 'api/payment/sign';
  // 充值
  static const rechargeApi = 'api/payment/recharge';
  // 查询支付状态
  static const queryPayStatusApi = 'api/bill/query';

  // 查询订单列表
  static const queryOrderListApi = 'api/product/order/list';

  // 查询订单详情
  static const queryOrderDetailApi = 'api/product/order/detail';

  // 查询地址列表
  static const queryAddrListApi = 'api/shippingInfo/list';

  // 新增地址
  static const addAddressApi = 'api/shippingInfo/add';

  // 修改地址
  static const modifyAddressApi = 'api/shippingInfo/';

  // 删除地址
  static const deleteAddressApi = 'api/shippingInfo/';

  // 更改订单状态
  static const updateOrderStatusApi = 'api/product/order/status';

  // 售后列表
  static const queryServiceListApi = 'api/service/list';

  // nft列表
  static const queryNftListApi = 'api/nft/self/list';

  // nft详情
  static const queryNftDetailApi = 'api/nft';

  // 查询nft卡槽列表
  static const queryNftSlotListApi = 'api/nft/slot';

  //  安装nft卡槽
  static const addSlotApi = 'api/nft/slot/cover/add';

  // 拆卸nft卡槽
  static const removeSlotApi = 'api/nft/slot/remove';

  // 解锁nft卡槽
  static const unlockSlotApi = 'api/nft/slot/activate';
  // nft卡槽配置信息
  static const querySlotConfigApi = 'api/config/fee';
  // nft卡槽配置信息
  static const nftRepairApi = 'api/nft/repair';
  // 查询庄园列表
  static const queryCategoryListApi = 'api/nft/category/list';

  // 道具列表
  static const queryEntitiesListApi = 'api/loot/entities';

  // 查询mint出哪些nft
  static const queryMintChildrenApi = 'api/nft/mint/';

  // 查询由哪些nft mint
  static const queryMintParentsApi = 'api/nft/mint/';

  // 出售nft
  static const nftSaleApi = 'api/nft/mall/shelve';

  // 下架nft
  static const nftUnsaleApi = 'api/nft/mall/unshelve';

  // nft升级信息
  static const nftLevelupInfoApi = 'api/nft/levelup/cost';

  // nft升级
  static const nftLevelupApi = 'api/nft/levelUp';

  // 道具出售
  static const entitySaleApi = 'api/loot/mall/shelve';

  // 下架道具
  static const entityUnsaleApi = 'api/loot/mall/unshelve';

  // 购买道具
  static const buyEntityApi = 'api/loot/mall/entities/buy';

  // 购买nft
  static const buyNftApi = 'api/nft/mall/buy';

  // 打开宝箱
  static const openLootBoxApi = 'api/loot/open_lootbox';

  // 打开nft box
  static const openNftBoxApi = 'api/nft/mint/bookBox';

  // 查询集市nft列表
  static const queryMarketNftApi = 'api/nft/mall/list';

  // 查询集市道具列表
  static const queryMarketEntityApi = 'api/loot/mall/entities';

  //开始打金任务
  static const read2nStartApi = 'api/read2n/start';

  //提交一个阅读任务
  static const read2nMineApi = 'api/read2n/mine';

  //我的宝箱列表
  static const queryBoxsApi = 'api/loot/boxs';

  // 关闭一个任务单
  static const read2nStopApi = 'api/read2n/stop';

  //打金详细
  static const read2nDetailsApi = 'api/read2n/summary/';

  //解锁付费宝箱
  static const unlockLootBoxApi = 'api/loot/pay_to_unlock_lootbox';
  //分红奖励通知
  static const dividentNotifyApi = 'api/product/dividend/notify';

  //打豆豆历史记录
  static const read2nRecordsApi = 'api/read2n/records';

  //上架nft到商城出租
  static const nftRentApi = 'api/nft/rent/mall/shelve';

  //nft从商城出租下架
  static const nftRentUnshelveApi = 'api/nft/rent/mall/unshelve';

  // 获取出租nft的相关信息
  static const nftRentInfoApi = 'api/nft/rent/info/';

  //租赁商城的nft
  static const nftRentMarketApi = 'api/nft/rent/mall/rent_in';

  //庄园分红列表
  static const dividendApi = 'api/product/dividend';

  //历史庄园分红列表
  static const dividendHistoryApi = 'api/product/dividend/history';

  //我的分红
  static const dividendMeApi = 'api/product/dividend/me';

  //获取ordertrade列表
  static const queryMineNftOrderTrade = 'api/order/list';

  //维修nft单价
  static const queryRepairCost = 'api/account/repair_cost';

  //查询咖啡豆
  static const queryRead2nBean = 'api/read2n/bean';

  //领取体验nft
  static const rentReceive = 'api/nft/rent/receive';

  //查询售后二维码
  static const queryQRCodeApi = 'api/config/type/4';

  //我的页面订单数量浏览
  static const queryOverviewApi = 'api/product/order/overview';

  //获取账单列表
  static const queryBillList = 'api/bill/list';

  //修改账户信息
  static const editAccountApi = 'api/account/edit';

  //设置支付密码
  static const setPayPasswordApi = 'api/account/pay_password';

  //检验验证码
  static const accountVerifyCode = 'api/account/verify_code';
}
