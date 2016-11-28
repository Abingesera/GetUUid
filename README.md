# GetUUid
how to get an unquiely UUid
1、UDID（[[UIDevice currentDevice] uniqueIdentifer]）
iOS5之后，该方法返回的结果在所有应用中都相同，并且卸载应用、刷机、还原设备均不会发生改变，该方法被标记为废弃！最终，在2013年5月1号之后，AppStore禁止任何使用该方法的应用上架。iOS7中对外公开的API中已经移除了该方法
2、保存在NSUserDefault中的UUID
在iOS5将UDID标为废弃之后，官方提供的替代方案。即使用CFUUIDCreate生成一个UUID，并将之保存在NSUserDefault中，用它作为设备标识符。
在iOS6之后，苹果更推出NSUUID来替代CFUUIDCreate，并将之保存在NSUserDefault中，用它作为设备标识符。
	不足：应用被卸载之后，会生成一个新的字符串，更不用提刷机、还原设备了。
3、MAC Address
获取方法：http://blog.csdn.net/doubleuto/article/details/6599516
MAC Address方案简介：MAC地址在网络上用来区分设备的唯一性，接入网络的设备都有一个MAC地址，他们肯定都是不同的，是唯一的。一部iPhone上可能有多个MAC地址，包括WIFI的、SIM的等，但是iTouch和iPad上就有一个WIFI的，因此只需获取WIFI的MAC地址就可以非常好的标识设备唯一性。那么，如何使用Mac地址生成设备的唯一标识呢？主要分三种：1、直接使用“MAC Address”2、使用“MD5(MAC Address)”3、使用“MD5(Mac Address+bundle_id)”获得“机器＋应用”的唯一标识（现在仍可借鉴，可以增加安全性）
不足：苹果并不希望有人通过MAC地址来分辨用户，所以如果你在iOS7系统上查询MAC地址，它现在只会返回02:00:00:00:00:00。
4、OPEN UDID
获取方法：https://github.com/ylechelle/OpenUDID
OPEN UDID方案简介：当设备装上第一个使用OpenUDID方案的应用程序第一次调试时，会生成一个唯一识别码，追加8为随机数保持了40位的UDID，并且利用了NSUserDefaults类将识别码进行了保存。但是当应用删除，UserDefaults同样会被清空，为了避免重新生成唯一识别码，该方案还使用到了UIPasteboard类（设备剪切板），将识别码同时保存到了UIPasteboard中。当设备上安装第二个使用了OpenUDID方案的应用程序，将会从UIPasteboard中获取唯一识别码，这里取到的就是之前第一个应用保存到UIPasteboard中的。
不足：当将设备上“同一开发商”所有使用了OpenUDID方案的应用程序删除，且设备关机重启，重装应用程序去获取OpenUDID，此时OpenUDID变化。
5、SecureUDID
	SecureUDID方案简介：与OpenUDID其实差不多，只是初始获取的唯一识别码稍有不同。
6、广告标示符（IDFA-identifierForIdentifier）
获取方法：[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
广告标示符简介：是iOS 6中另外一个新的方法，提供了一个方法advertisingIdentifier，通过调用该方法会返回一个NSUUID实例，最后可以获得一个UUID，由系统存储着的。
不足：有几种情况下，会重新生成广告标示符。如果用户完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私) ，这个广告标示符会重新生成。另外如果用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符) ，那么广告标示符也会重新生成。关于广告标示符的还原，有一点需要注意：如果程序在后台运行，此时用户“还原广告标示符”，然后再回到程序中，此时获取广 告标示符并不会立即获得还原后的标示符。必须要终止程序，然后再重新启动程序，才能获得还原后的广告标示符。
7、Vendor标示符／厂商唯一标识符(IDFV-identifierForVendor)
获取方法：[[[UIDevice currentDevice] identifierForVendor] UUIDString]
Vendor标示符简介：在iOS 6中新增的，跟advertisingIdentifier一样，该方法返回的是一个 NSUUID对象，可以获得一个UUID。是给Vendor标识用户用的，每个设备在所属同一个Vender的应用里，都有相同的值。
不足：如果满足条件“相同的一个程序里面-相同的vendor-相同的设备”，那么获取到的这个属性值就不会变。如果是“相同的程序-相同的设备-不同的vendor，或者是相同的程序-不同的设备-无论是否相同的vendor”这样的情况，那么这个值是不会相同的。如果用户将属于此Vender的所有App卸载，则Vendor标示符的值会被重置，即再重装此Vender的App，Vendor标示符的值和之前不同。
8、推送token＋bundle_id
	获取方法：注册推送服务从APNs获取device token
	不足：在官方文档上建议开发者在每次启动应用时应该都向APNs获取device token并上传给服务器。从这句话来看，device token是会变化的！

UUID： 即Universally Unique IDentifier（全局唯一标识符） 也称作 GUID (Globally Unique Identifier，全球唯一标识符) 。
	UUID是一个128位长的数字，一般用16进制表示。算法的核心思想是结合机器的网卡、当地时间、一个随即数来生成UUID。
用户第一次安装软件获取UUID，并且用KeyChain进行存储。第二次安装时候用KeyChain获取就可以了。
