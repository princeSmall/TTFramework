### iOS 静态库Framework和.a

### 什么是库
库是共享程序代码的方式。库从本质上来说是一种可执行代码的二进制格式，可以被载入内存中执行。在开发过程中，一些核心技术或者常用框架，出于安全性和稳定性的考虑，不想被外界知道，所以会把核心代码打包成库，只暴露出头文件以供使用。库分静态库和动态库两种。今天说的是静态库。

1. 对于静态库而言，类似于一个编译好的 .o的集合。在build的过程中，只会参与链接的操作，链接器会将静态库中被使用的部分合并到可执行文件中去，用函数的实际地址来代替函数引用。
2. 静态库形式：.a 和 framework
3. .a 和 framework 有什么区别：

.a是一个纯二进制文件

framework 中除了有二进制文件之外还有资源文件。

framework 文件可以直接使用。

.a + .h + sourceFile= .framework。所以创建静态库最好还是用.framework的形式。

### Framework的创建

1. 创建framework

![](/Users/letong/Desktop/MD/静态库framework/CreateFramework.png)

创建后发现只有一个.h文件，这个文件类似.pch文件，是所有头文件的集合，将你要创建的类导入在这个.h文件里

2. 设置public 文件

![](/Users/letong/Desktop/MD/静态库framework/public.png)

设置你想要别人看到引用的对外.h文件

3. 设置mach-Type，选择static（静态）

![](/Users/letong/Desktop/MD/静态库framework/machType.png)

4. 设置target支持的版本号iOS 9.0 以上等，配置支持armv7s,build active architecture only 设置为NO

![](/Users/letong/Desktop/MD/静态库framework/architectures.png)

5. 运行模拟器，然后再运行真机，点击Products->show in find，会看到两个文件夹Debug-iphonesimulator和Debug-iphoneos。这是因为Framework模拟器和真机不同，需要去合并成一个

![](/Users/letong/Desktop/MD/静态库framework/lipoCreate.png)

```
lipo
lipo 是个很有用的命令，主要用来查看库支持的架构以及合并拆分库

lipo -info
查看刚才编译的 Framework 库在 debug 和 release 下支持的框架：

libo -create
上面生成的库，要么是只支持模拟器的，要么是只支持真机的，那么如何才能又能兼顾真机和模拟器呢？-create去合并
使用方式：lipo -create 库1（空格）库2 -output 新库名
```

### .a 文件的创建

1. 创建.a

![](/Users/letong/Desktop/MD/静态库a/create.png)

创建后会生成一个.h 和 .m文件，（无用可删），去创建NSObject类对象

2. 修改subpath,保持创建的文件和.a 文件在同一个文件夹下，其次再copyFiles下，导入需要暴露的.h文件
![](/Users/letong/Desktop/MD/静态库a/subpath.png)

3. 与framework设置相同，设置mach-type，运行模拟器，合并.a文件

### 静态文件调用

1. .framework调用：拖入后缀是.framework加进项目就OK了
2. .a调用：拖入.a和.h文件加进项目

### 模拟器i386，x86_64,arm7,arm7s,arm64

1. 模拟器架构:

i386 : 32位架构 4S ~ 5

x86_64 : 64位架构 5S ~ 现在的机型

2. 真机架构:

arm7: 在最老的支持iOS7的设备上使用

arm7s: 在iPhone5和5C上使用

arm64: 运行于iPhone5S的64位 ARM 处理器 上





