# Git初始设置

### 设置姓名和邮箱地址

首先来设置使用Git时的姓名和邮箱地址。

	$ git config --global user.name "Firstname Lastname"
	$ git config --global user.email "your_email@example.com"

这个命令，会在~/.gitconfig中以如下形式输出设置文件。

	[user]
		name = Firstname Lastname
		email = your_email@example.com

&nbsp;&nbsp;想更改这些信息时，可以直接编辑这个设置文件。这里设置的姓名和邮箱地址会用在Git的提交日志中。由于在GitHub上公开仓库时，这里的姓名和邮箱地址会随着提交日志一同公开，所以不要使用不便公开的隐私信息。

&nbsp;&nbsp;在GitHub上公开代码之后，前来参考的程序员可能来自世界任何地方，所以请不要使用汉字，尽量用英文描述。
### 提高命令输出的可读性
&nbsp;将color.ui设置为auto可以让命令的输出拥有更高的可读性。

	$ git config --global color.ui auto
&nbsp;&nbsp;"~/.gitconfig"中会增加下面一行。

	[color]
		ui = auto
