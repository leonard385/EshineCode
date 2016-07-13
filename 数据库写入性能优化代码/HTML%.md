#HTML5浏览器支持问题
##让一些较早的浏览器（不支持HTML5）支持 HTML5
###将 HTML5 元素定义为块元素
HTML5 定了 8 个新的 HTML 语义（semantic） 元素。所有这些元素都是 块级 元素。
为了能让旧版本的浏览器正确显示这些元素，你可以设置 CSS 的 display 属性值为 block:
>
实例
header, section, footer, aside, nav, main, article, figure {
    display: block; 
}

###为 HTML 添加新元素
JavaScript 语句 document.createElement("myHero") 为 IE 浏览器添加新的元素
###Internet Explorer 浏览器问题
完美的 Shiv 解决方案

```markup
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>渲染 HTML5</title>
  <!--[if lt IE 9]>
  <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
  <![endif]-->
</head>

<body>

<h1>我的第一篇文章</h1>

<article>
菜鸟教程 —— 学的不仅是技术，更是梦想！！！
</article>

</body>
</html>
    
```
>
Internet Explorer 8 及更早 IE 版本的浏览器不支持以上的方式。

#HTML5 Canvas
引用地址:[HTML5 Canvas](http://www.runoob.com/html/html5-canvas.html)<br>
简介：<br>
HTML5 < canvas > 元素用于图形的绘制，通过脚本 (通常是JavaScript)来完成.
< canvas > 标签只是图形容器，您必须使用脚本来绘制图形

###步骤：

```markup
   <!--创建一个画布（Canvas）-->
<canvas id="HeadContainView" width="320" height="667" style="border: 1px solid #000000;">
    您的浏览器不支持 HTML5 canvas 标签。

</canvas>

<!--使用 JavaScript 来绘制图像-->
<script>
    var  c = document.getElementById("HeadContainView");
    var Ctx = c.getContext("2d");
    Ctx.fillStyle = "#ff0000";
    Ctx.fillRect(0,0,150,68);
</script>
```

####实例解析：
首先，找到 < canvas > 元素:

```markup
var c=document.getElementById("myCanvas");
```
然后，创建 context 对象：

```
var ctx=c.getContext("2d");
```
getContext("2d") 对象是内建的 HTML5 对象，拥有多种绘制路径、矩形、圆形、字符以及添加图像的方法。
下面的两行代码绘制一个红色的矩形：

```
ctx.fillStyle="#FF0000";
ctx.fillRect(0,0,150,75);
```

设置fillStyle属性可以是CSS颜色，渐变，或图案。fillStyle 默认设置是#000000（黑色）。
fillRect(x,y,width,height) 方法定义了矩形当前的填充方式。

##javascript
图形上下文绘画API
> * stroke() 边框绘制 
> *  fill() 填充绘制

###画线
我们将使用以下两种方法：<br>
moveTo(x,y) 定义线条开始坐标<br>
lineTo(x,y) 定义线条结束坐标<br>


###绘制圆
* arc(x,y,r,start,stop)

###绘制字体 
<p>font - 定义字体</p>
<p>fillText(text,x,y) - 在 canvas 上绘制实心的文本</p>
<p>strokeText(text,x,y) - 在 canvas 上绘制空心的文本</p>

###Canvas - 渐变

渐变可以填充在矩形, 圆形, 线条, 文本等等, 各种形状可以自己定义不同的颜色。<br>
以下有两种不同的方式来设置Canvas渐变：<br>
* createLinearGradient(x,y,x1,y1) - 创建线条渐变<br>
* createRadialGradient(x,y,r,x1,y1,r1) - 创建一个径向/圆渐变<br>



#HTML5 内联 SVG
##SVG简介：
SVG 指可伸缩矢量图形 (Scalable Vector Graphics)


#HTML5 拖放（Drag 和 Drop）
##拖放
拖放是一种常见的特性，即抓取对象以后拖到另一个位置。








