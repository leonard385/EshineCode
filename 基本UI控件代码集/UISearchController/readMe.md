#工程说明
UISearchController是即IOS 8.0后推出的搜索类，相比UIsearchDisplayController使用更加简单，更加符合类的封装规范。

该项目书写了两种方案

1. UIsearchController
2. 自定义搜索 (UIImage + UITextFeild + UITableView这种方式 用模态无动画的形势推出)


推荐使用第二种，UISearchController在实际项目整合中会出现一些奇奇怪怪的问题，比如1.点击搜索，直接推到状态栏位置而非状态栏位置之下。2.当界面做了全屏退出手势，直接滑动退出界面，搜索框会跟着推回来，这个有中设置context的方式解决，但是推出的时候会看到很明显的搜索框退出响应动画，体验很不友好，给人一种卡顿的感觉