模块简介：
   此模块为百度地图节点筛选模型，当地图中加载大量标注时，地图显得卡顿，一般一个界面加载100个节点左右，才能保证地图的顺畅。此模块可以根据地图的比例尺大小对节点进行筛选，适当过滤掉一些节点，以便提升地图使用的顺畅程度和用户体验。
   
模块特点：
   1，百度地图节点筛选。
   2，提升地图使用流畅程度和拥护体验。

使用方法：
   1，使用前需要集成百度地图SDK及相关的接口，并导入百度地图需要的
      头文件。  
   2，在项目中导入模块文件，在需要的地方导入
     ＃import "YXBaiduMapNodeFilter.h"。
   3，初始化mapView地图后即刻初始化YXBaiduMapNodeFilter对
     象，初始化方法为类方法:+(instancetype)baiduMapNodeFilter 
     (BMKMapView *)mapView;
   4,将地图中需要筛选的所有节点（BMKAnnotation对象）整理放在一
     个数组arr中,YXBaiduMapNodeFilter对象调用
     实例方法并传参arr:
     - (void)addAnnotationWithFilter:(NSmutableArray＊) 
     arrAnnotation;
     
     （注意：调用此方法后无需再调用方法：
     - (void)addAnnotations:(BMKAnnotation
     ＊)annotation;）
     
暴露的接口及方法：

    初始化实例类方法：
    
    + (instancetype)baiduMapNodeFilter 
     (BMKMapView *)mapView;
     
    筛选节点实例方法：
    
    - (void)addAnnotationWithFilter:(NSmutableArray＊) 
     arrAnnotation
     
     地图本身
     @property (strong, nonatomic) BMKMapView *mapView;
     
     地图所被分到区域数组
     @property (strong, nonatomic) NSMutableArray 
     *arrRegion;
     
     筛选后到节点标注数组
     @property (strong, nonatomic) NSMutableArray 
     *arrAnnotationFiltered;
