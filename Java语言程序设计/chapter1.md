### Java技术体系

- Java SE
	- Java开发工具（编译器、调试器、文档工具）
	- Java部署技术
	- User Interface Toolkits
	- 集成API
	- Java基本库
	- JVM 
- Java ME
- Java EE
	- EJB
	- Java Servlets API
	- Java Server Pages（JSP）
	```sequence
	Client->JSP->EJB->Database
	```

### Java语言
Java 程序由编译器进行编译，产生一种中间代码，称为Java字节码(Java bytecodes)。字节码是Java虚拟机（Java Virtual Machine）的代码，是平台无关的中性代码，因此不能在各种计算机平台上直接运行，必须在JVM上运行。
### Java平台
- Java虚拟机（Java Virtual Machine）
- Java应用程序接口（Java API）
### Java特征
- 简单性
	- 去掉指针
	- 取消多重继承
	- 取消运算符重载
	- 内存管理
- 面向对象
	- 封装、继承、多态
- 分布式特征
- 半编译、半解释
- 健壮性
- 安全性
- 体系结构中立
- 可移植性
- 高性能
- 多线程
- 动态特性

### Java语法机制
- 类（Class）
	- Java只能继承一个父类，多重继承通过接口实现。
	- `public、protected、private、abstract、final`
	- `abstract`：抽象类的抽象方法只定义方法的声明（函数名、参数、类型）没有方法体。抽象类只能供其他类作为父类使用。不能直接通过new运算符产生抽象类的对象。
	- `final`：可以修饰类、属性或方法。带final的类不能作父类被继承，带final的属性在赋初值或第一次赋值后将不允许改变，成为常亮。在方法定义是，使用final修饰词可以防止子类重写该方法。
- 接口
	- 接口中只能出现静态常量或者抽象方法的定义。
	- Java引进接口的主要目的是实现多重继承，同时避免了C++多重继承的复杂性。
	- 类可以通过实现一个或多个接口来实现多重继承。
- 程序包
	- 程序包是一些相关类或接口的集合。
	- 通过`import`将相应包引入。
- 多线程
- 取消指针
	- 取消指针类型，所有动态内存申请通过`new`运算符进行。
	- Java中通过new得到的不是指针，而是引用（reference）。

### Java运行系统
- 类装配器
- 字节码验证器
- 解释器
- 代码生成器
- 运行支持库

### Java字节码执行过程
1. 代码的装入：通过类装配器装入程序运行时需要的所有代码，其中包括程序代码中调用的所有类。当装入了运行程序需要的所有类后，运行系统便可以确定整个可执行程序的内存布局。
2. 代码的验证：由字节码检验器进行安全检查，以确保代码不违反Java的安全性规则，同时字节码验证器还可以发现操作数栈溢出、非法数据类型转换等多种错误。
3. 代码的执行：分为两种方式。
	- 即时编译（Just-In-Time）方式：由代码生成器将字节码编译为本机代码，然后再全速执行本机代码。这种方式运行效率高。
	- 解释执行方式：解释器每次把一小段代码转换成为本机代码并执行，如此往复完成Java字节码的所有操作。

### JVM

1. 指令集
2. 寄存器组：程序计数器、栈顶指针、指向当前执行方法的执行环境的指针和指向当前执行方法的局部变量的指针。
3. 类文件的格式
4. 栈结构：栈用于保存操作参数、返回结果和为方法传递参数等。
5. 垃圾收集程序：用来收集不用的数据堆，使内存有效利用。
6. 存储区：用于存放字节码的方法代码，符号表等。

### Java API
1. java.lang——由Java语言的核心类组成，包括了基本数据类型和出错处理方法等。
2. java.io——Java语言的标准输入/输出库，提供系统通过数据流、串行化和文件系统的输入和输出。
3. java.util——包含集合（collection）类，如Map，Set，List，日期与时间相关的类等。
4. java.net——提供实现网络应用所需的类。
5. java.awt——是抽象窗口工具集（Abstract window toolkit），提供了创建用户界面和绘制图形、图像所需的所有类。
6. java.applet——Applet所需的类
7. java.sql——支持通过JDBC的数据库访问操作。