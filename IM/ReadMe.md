#说明文档
本demo实现了rabbitmq下 Stmop协议


~~~
1. 登录
2. 消息收发功能 （收发中文需要进行相应的编解码）
~~~

![](../src.1.png)
![](../src.2.png)

![](../src.3.png)
![](../src.4.png)


##podfile

~~~
platform :ios, '8.0'
use_frameworks!

target 'IMDemo' do
pod 'StompKit', :git => 'https://github.com/mobile-web-messaging/StompKit.git'
end
~~~

StompKit 在原有的基础上进行了更改：

![](../src/5.png)
在frame的header部分添加了host = '/'

不添加会登录不上，提示
![](../src/6.png)