# Java语言基础

## 标识符与数据类型
### Java基本语法
- 语句与语句块
	- 通过`;`为语句的分隔符
	- 一对大括号`{}`包含的一系列语句为语句块。可以嵌套。
	- 适当使用空白可以使程序层次清晰，增加程序的可读性。
- 注释
	- `//`注释一行。
	- `/* */`注释一行或多行。
	- `/** */`之间的文本将自动包含在用`javadoc(API文档生成器)`命令生成的HTML格式的文档中。

### 标识符
- 标识符（变量、类、方法命名）定义规则
	- 标识符以`字母、“_”、或“$”`开始的一个字符序列。
	- 数字不能作为第一个字符。
	- 标识符不能使Java语言的关键字，但可用关键字作为标识符的一部分。
	- 标识符大小写敏感，并且长度没有限定。

- 标识符风格约定
	- 变量名和方法名不用_和$作为第一个字符，这两个字符对于内部类具有特殊意义。
	- 类名、接口名、变量名和方法名采用大小写混合模式。变量名和方法名第一个单词首字母小写。类名和接口名第一个单词首字母大写。
	- 常亮名字完全大写，并用用下划线_作为标识符的分隔符。
	- 方法名应该使用动词，类名与接口名应该使用名词。
	- 变量名应该具有一定的含义。临时变量如循环控制可以采用i，j，k等。

- 关键字
```Java
abstract assert boolean break byte case catch char class const
continue default do double else enum extends final finally float
for goto if implements import instanceof int interface long native
new package private protected public return short static strictfp
super switch synchronized this throw throws transient try void
volatile while true false null
```
- 基本数据类型
	- 逻辑型：`boolean`：只占1位，初始值默认为false。
	- 文本型：`char`：16位的Unicode字符，使用单引号引上，初始值默认为\u0000。
	- 整型：`byte,short,int,long`。Java中所有的整数类型都是有符号的整数类型，Java没有无符号整数类型。
		- `byte`：8位。-128~127.
		- `short`:16位。-32768~32767.
		- `int`：32位。-2147483648~2147483647.
		- `long`：64位。
	- 浮点型：`double,float`
		- `float`：32位。
		- `double`：64位。

通过以下程序输出对应数据类型相关的一些常量。
```Java
public static void main(String args[]){
	System.out.println("Integer.MAX_VALUE"+Integer.MAX_VALUE);
	System.out.println("Integer.MIN_VALUE"+Integer.MIN_VALUE);
}
```

### 复合数据类型
Java是一种面向对象的语言，基于面向对象概念，以类和接口的形式定义新类型。在Java中类和接口是两种用户定义的复合数据类型。

```Java
class MyDate{
	int day;
	int month;
	int year;
}
```

Java使用类和接口这样的复合数据类型，不仅反映了现实世界事物的本质形态，还使程序简练并且更可靠。

### 基本类型变量和引用类型变量
Java数据类型分为两大类：基本数据类型和复合类型。相应地，变量也有两种类型：基本类型与引用类型。Java的8种基本类型的变量称为基本类型变量，而类、接口和数组变量是引用类型变量。
- 基本类型（primitive type）

		基本数据类型的变量包含了单个值，这个值的长度和格式符合变量所属数据类型的要求。
- 引用类型（reference type）

		引用类型变量的值与基本类型变量不同，变量值是指向内存空间的引用（地址）。指向的内存中保存着变量所表示的一个值或一组值。
		引用在其它语言中称为指针或者内存地址。Java语言与其他程序设计语言不同，不支持显式使用内存地址，而必须通过变量名对某个内存地址进行访问。
