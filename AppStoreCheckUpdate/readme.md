#APPStore上线应用检查更新
##应用说明：
![](/Users/yixinmac/Library/Containers/com.tencent.qq/Data/Library/Application Support/QQ/Users/3080530955/QQ/Temp.db/3D07B5A2-4481-451C-A8D6-B73D9EF8102D.png)


1. 更改APPID
2. demo代码只用来观看运行效果，上线版本需要使用正式部分的代码 
3. 该库只提醒一次
##使用

```
#import "QJCheckVersionUpdate.h"
 QJCheckVersionUpdate *Version = [[QJCheckVersionUpdate alloc]init];
    [Version showAlertView];
```