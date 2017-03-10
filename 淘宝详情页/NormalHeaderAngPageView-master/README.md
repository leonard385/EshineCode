#NormalHeaderAngPageView

-简单的头部视图和分段视图控制器的联动效果

一直想实现这种效果，找了demo也是找了好久，最后看到一个例子是仿淘宝详情，效果很流畅，就搬了过来改了改

仿淘宝详情作者项目：https://github.com/kopuCoder/YX_UITableView_IN_UITableView

优点:极其简单操作流畅，主视图用tableView搭建，只需要继承MainTouchTableTableView即可。

分页的tableview等需要继承父类ParentClassScrollViewController

缺点：本次例子采用了通知的形式，想到用代理 但是需要更改pageViewController ， 采用通知的形式你可以随意选择你喜欢的pageViewController库去写

![gif](https://github.com/AnnaMa1992/NormalHeaderAngPageView/blob/master/HeaderViewAndPageView/UntitledNormal.gif)

