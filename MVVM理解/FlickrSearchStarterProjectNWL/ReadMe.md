#FlickrSearch工程说明
本工程基于MVVMReactiveCocoa FlickSearch 按照自己平时的写法改写而成，程序关键部分有相关的注解。

 Colin Eberhardt  写的[MVVM Tutorial with ReactiveCocoa](https://www.raywenderlich.com/74106/mvvm-tutorial-with-reactivecocoa-part-1)
 
 中文翻译版本的在这里[中文版本原作者的地址访问不了了这是我转出来的](http://www.cnblogs.com/niwanglong385/articles/4971802.html)
 
 英文原文对MVVM讲的非常详细，一步步带大家使用MVVM设计模式来开发一个APP,由浅入深。
 该工程基于读者自己的理解，删除了可能会增加初学者理解的util 中的tableview绑定类，采用了tableview平常写法初始化然后实现各种代理source方法，并对RWTViewModelServicesImpl进行了改写删除了多余的代码，通过该工程你可以熟悉MVVM在项目中使用的大体过程。
 
 但是有一点不好的UINavigationController 推入，presentViewController 这块思路还没有通。还没有找到比较好的方法，感谢了。