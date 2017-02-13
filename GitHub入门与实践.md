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
	(fingerprint值) your_email@example.com
	The key's randomart image is:
	+--[ RSA 2048]----+ 
	|		略		  |
id_rsa文件是私有密钥，id_rsa.pub是公开密钥。
###　添加公开密钥
&nbsp;&nbsp;在GitHub中添加公开密钥，今后就可以用私有密钥进行认证了。

&nbsp;&nbsp;点击右上角的账户设定按钮（Account Settings），选择SSH Key菜单。点击Add SSH Key之后，在Title中输入适当的密钥名称。Key部分粘贴id_rsa.pub文件里的内容。

&nbsp;&nbsp;添加成功之后，创建账户时使用的邮箱会接到一封提示“公共密钥添加完成”的邮件。完成以上设置后，就可以用手中的私人密钥与GitHub进行认证和通信了。

	$ ssh -T git@github.com
	The authenticity of host 'github.com(*.*.*.*)'can't be established.
	RSA key fingerprint is (fingerprint).
	Are you sure you want to continue connecting (yes/no)?
&nbsp;&nbsp;出现以下结果即为成功。
	
	Hi Imgaojp!You've successfully authenticated,but GitHub does not provide shell access.
### git init----初始化仓库
&nbsp;&nbsp;要使用Git进行版本管理，必须先初始化仓库。Git是使用git init命令进行初始化的。请实际建立一个目录并初始化仓库。

	$ mkdir git-tutorial
	$ cd git-tutorial
	$ git init
	Initialized empty Git repository in ./git-tutorial/.git/
&nbsp;&nbsp;如果初始化成功，执行了git init命令的目录下就会生成.git目录。这个.git目录里存储着管理当前目录内容所需的仓库数据。

&nbsp;&nbsp;在Git中，我们这个目录的内容称为“附属于该仓库的工作树”。文件的编辑等操作在工作树中进行，然后记录到仓库中，以此管理文件的历史快照。如果想将文件恢复到原先的状态，可以从仓库中调取之前的快照，在工作树中打开。开发者可以通过这种方式获取以往的文件。
### git status----查看仓库的状态
&nbsp;&nbsp;git status命令用于显示Git仓库的状态。这是十分常用的命令，**务必牢记**。

&nbsp;&nbsp;工作树和仓库在被操作的过程中，状态会不断发生变化。在Git操作过程中时常用git status命令来查看当前状态，可谓基本中的基本。

	$ git status
	On branch master
	
	Initial commit

	nothing to commit(create/copy files and use "git add" to track)

&nbsp;&nbsp;结果显示了我们处于master分支下。关于分支将会在不久之后讲到，现在不必深究。接着显示了没有可提交的内容。所谓提交（Commit），是指“记录工作树中所有文件的当前状态”。

&nbsp;&nbsp;尚没有可提交的内容，就是说当前我们建立的这个仓库中还没有记录任何文件的任何状态。这里，我们建立README.md文件作为管理对象，为第一次提交前做准备。

	$ touch README.md
	$ git status
	On branch master
	
	Initial commit
	
	Untracked files:
		(use "git add <file>..." to include in what will be committed)
			README.md

	nothing added to commit but untracked files present (use "git add" to track)

&nbsp;&nbsp;可以看到在Untracked files中显示了README.md文件。类似地，只要对Git的工作树或仓库进行操作，git status命令的显示结果就会发生变化。

### git add----向暂存区中添加文件
&nbsp;&nbsp;&nbsp;&nbsp;如果只是用Git仓库的工作树创建了文件。那么该文件并不会被记入Git仓库的版本管理对象中。因此我们用git status命令查看README.md文件时，它会显示在Untracked files里。

&nbsp;&nbsp;&nbsp;&nbsp;要想让文件称为Git仓库的管理对象，就要用git add命令将其加入暂存区（Stage或者Index）中。暂存区是提交之前的一个临时区域。

	$ git add README.md
	$ git status
	On branch master
	
	Initial commit
	
	Changes to be committed:
		(use "git rm --cached <file>..." to unstage)

			new file: README.md
&nbsp;&nbsp;&nbsp;&nbsp;将README.md文件加入暂存区后，git status命令的显示结果发生了变化。可以看到，README.md显示在Changes to be committed中了。