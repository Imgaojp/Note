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
# 使用GitHub前的准备
### 设置 SSH Key
&nbsp;GitHub上连接已有仓库时的认证，是通过使用了SSH的公开密钥认证方式进行的。运行下面的命令创建SSH Key。

	$ ssh-keygen -t rsa -C "your_email@example.com"
	Generating public/private rsa key pair.
	Enter file in which to save the key
	(/Users/your_user_directory/.ssh/id_rsa):
	Enter passphrase(empty for no passphrase):
	Enter same passphrase again:
&nbsp;&nbsp;"your_email@example.com"的部分请改成您在创建账户时用的邮箱地址。密码需要在认证时输入，请选择复杂度高并且容易记忆的组合。

&nbsp;&nbsp;输入密码后会出现以下结果。

	Your identification has been saved in /Users/your_user_directory/.ssh/id_rsa.
	Your public key has been saved in /Users/your_user_directory/.ssh/id_rsa.pub.
	The key fingerprint is:
	*fingerprint值* your_email@example.com
	The key's randomart image is:
	+--[ RSA 2048]----+ 
	|		略		  |
