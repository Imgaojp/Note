# Git初始设置

### 设置姓名和邮箱地址

首先来设置使用Git时的姓名和邮箱地址。

	$ git config --global user.name "Firstname Lastname"
	$ git config --global user.email "your_email@example.com"

这个命令，会在~/.gitconfig中以如下形式输出设置文件。

	[user]
		name = Firstname Lastname
		email = your_email@example.com

&nbsp;&nbsp;&nbsp;&nbsp;想更改这些信息时，可以直接编辑这个设置文件。这里设置的姓名和邮箱地址会用在Git的提交日志中。由于在GitHub上公开仓库时，这里的姓名和邮箱地址会随着提交日志一同公开，所以不要使用不便公开的隐私信息。

&nbsp;&nbsp;&nbsp;&nbsp;在GitHub上公开代码之后，前来参考的程序员可能来自世界任何地方，所以请不要使用汉字，尽量用英文描述。
### 提高命令输出的可读性
&nbsp;将color.ui设置为auto可以让命令的输出拥有更高的可读性。

	$ git config --global color.ui auto
&nbsp;&nbsp;&nbsp;&nbsp;"~/.gitconfig"中会增加下面一行。

	[color]
		ui = auto
# 使用GitHub前的准备
### 设置 SSH Key
&nbsp;&nbsp;&nbsp;&nbsp;GitHub上连接已有仓库时的认证，是通过使用了SSH的公开密钥认证方式进行的。运行下面的命令创建SSH Key。

	$ ssh-keygen -t rsa -C "your_email@example.com"
	Generating public/private rsa key pair.
	Enter file in which to save the key
	(/Users/your_user_directory/.ssh/id_rsa):
	Enter passphrase(empty for no passphrase):
	Enter same passphrase again:
&nbsp;&nbsp;&nbsp;&nbsp;"your_email@example.com"的部分请改成您在创建账户时用的邮箱地址。密码需要在认证时输入，请选择复杂度高并且容易记忆的组合。

&nbsp;&nbsp;&nbsp;&nbsp;输入密码后会出现以下结果。

	Your identification has been saved in /Users/your_user_directory/.ssh/id_rsa.
	Your public key has been saved in /Users/your_user_directory/.ssh/id_rsa.pub.
	The key fingerprint is:
	(fingerprint值) your_email@example.com
	The key's randomart image is:
	+--[ RSA 2048]----+ 
	|		略		  |
id_rsa文件是私有密钥，id_rsa.pub是公开密钥。
###　添加公开密钥
&nbsp;&nbsp;&nbsp;&nbsp;在GitHub中添加公开密钥，今后就可以用私有密钥进行认证了。

&nbsp;&nbsp;&nbsp;&nbsp;点击右上角的账户设定按钮（Account Settings），选择SSH Key菜单。点击Add SSH Key之后，在Title中输入适当的密钥名称。Key部分粘贴id_rsa.pub文件里的内容。

&nbsp;&nbsp;&nbsp;&nbsp;添加成功之后，创建账户时使用的邮箱会接到一封提示“公共密钥添加完成”的邮件。完成以上设置后，就可以用手中的私人密钥与GitHub进行认证和通信了。

	$ ssh -T git@github.com
	The authenticity of host 'github.com(*.*.*.*)'can't be established.
	RSA key fingerprint is (fingerprint).
	Are you sure you want to continue connecting (yes/no)?
&nbsp;&nbsp;&nbsp;&nbsp;出现以下结果即为成功。
	
	Hi Imgaojp!You've successfully authenticated,but GitHub does not provide shell access.
# 通过实际操作学习Git
### git init----初始化仓库
&nbsp;&nbsp;&nbsp;&nbsp;要使用Git进行版本管理，必须先初始化仓库。Git是使用git init命令进行初始化的。请实际建立一个目录并初始化仓库。

	$ mkdir git-tutorial
	$ cd git-tutorial
	$ git init
	Initialized empty Git repository in ./git-tutorial/.git/
&nbsp;&nbsp;&nbsp;&nbsp;如果初始化成功，执行了git init命令的目录下就会生成.git目录。这个.git目录里存储着管理当前目录内容所需的仓库数据。

&nbsp;&nbsp;&nbsp;&nbsp;在Git中，我们这个目录的内容称为“附属于该仓库的工作树”。文件的编辑等操作在工作树中进行，然后记录到仓库中，以此管理文件的历史快照。如果想将文件恢复到原先的状态，可以从仓库中调取之前的快照，在工作树中打开。开发者可以通过这种方式获取以往的文件。
### git status----查看仓库的状态
&nbsp;&nbsp;&nbsp;&nbsp;git status命令用于显示Git仓库的状态。这是十分常用的命令，**务必牢记**。

&nbsp;&nbsp;&nbsp;&nbsp;工作树和仓库在被操作的过程中，状态会不断发生变化。在Git操作过程中时常用git status命令来查看当前状态，可谓基本中的基本。

	$ git status
	On branch master
	
	Initial commit

	nothing to commit(create/copy files and use "git add" to track)

&nbsp;&nbsp;&nbsp;&nbsp;结果显示了我们处于master分支下。关于分支将会在不久之后讲到，现在不必深究。接着显示了没有可提交的内容。所谓提交（Commit），是指“记录工作树中所有文件的当前状态”。

&nbsp;&nbsp;&nbsp;&nbsp;尚没有可提交的内容，就是说当前我们建立的这个仓库中还没有记录任何文件的任何状态。这里，我们建立README.md文件作为管理对象，为第一次提交前做准备。

	$ touch README.md
	$ git status
	On branch master
	
	Initial commit
	
	Untracked files:
		(use "git add <file>..." to include in what will be committed)
			README.md

	nothing added to commit but untracked files present (use "git add" to track)

&nbsp;&nbsp;&nbsp;&nbsp;可以看到在Untracked files中显示了README.md文件。类似地，只要对Git的工作树或仓库进行操作，git status命令的显示结果就会发生变化。

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
### git commit----保存仓库的历史记录
&nbsp;&nbsp;&nbsp;&nbsp;git commit命令可以将当前暂存区中的文件实际保存到仓库的历史记录中。通过这些记录可以在工作树中复原文件。
#### 记述一行提交信息
&nbsp;&nbsp;&nbsp;&nbsp;我们来实际运行以下git commit命令。

	$ git commit -m "First commit"
	[master (root-commit) 473046a] First commit
	  1 file changed, 0 insertions(+), 0 deletions(-)
	  create mode 100644 README.md
&nbsp;&nbsp;&nbsp;&nbsp;-m参数后的“First commit”称作提交信息，是对这个提交的概述。
#### 记述详细提交信息
&nbsp;&nbsp;&nbsp;&nbsp;刚才我们只简洁地记述了一行提交信息，如果想要记述得更加详细，请不加 -m，直接执行git commit命令。执行后编辑器就会启动。在编辑器中记述提交信息的格式如下：

- 第一行：用一行文字简述提交的更改内容
- 第二行：空行
- 第三行以后：记述更改的原因和详细内容

&nbsp;&nbsp;&nbsp;&nbsp;按照上面的格式输入，今后就可以通过确认日志的命令或工具看到这些记录。
#### 中止提交
&nbsp;&nbsp;&nbsp;&nbsp;如果在编辑器启动后想中止提交，请将提交信息留空并直接关闭编辑器，随后提交就会被中止。
#### 查看提交后的状态
&nbsp;&nbsp;&nbsp;&nbsp;执行完git commit命令后再来查看当前状态。

	$ git status
	On branch master
	nothing to commit,working directory clean
当前工作树处于刚刚完成提交的最新状态，所以结果显示没有更改。
### git log----查看提交日志
&nbsp;&nbsp;&nbsp;&nbsp;git log命令可以查看以往仓库中提交的日志。包括可以查看什么人在什么时候进行了提交或者合并，以及操作前后有怎样的差别。关于合并我们会在后面说。

	$ git log
	
	commit 6bc867eba4c0125968c9a0ad18b4aa31c28f65
	Author: Imgaojp <imgaojp@gmail.com>
	Date:   Mon Feb 13 19:02:03 2017 +0800
	
			First commit
&nbsp;&nbsp;&nbsp;&nbsp;如上所示，屏幕显示了刚刚提交操作。commit栏旁边显示的“6bc86...”是指向这个提交的哈希值。Git的其它命令中，在指向提交时会用到这个哈希值。

&nbsp;&nbsp;&nbsp;&nbsp;Author栏中显示我们给Git设置的用户名和邮箱地址。Date栏中显示提交执行的日期和时间。再往下就是该提交的提交信息。
#### 只显示提交信息的第一行
&nbsp;&nbsp;&nbsp;&nbsp;如果只想让程序显示第一行简述信息，可以在git log命令后加上 --pretty=short。这样开发人员就能够更轻松的把握多个提交。

	$ git log --pretty=short

	commit 6bc867eba4c0125968c9a0ad18b4aa31c28f65
	Author: Imgaojp <imgaojp@gmail.com>
	
			First commit
#### 只显示指定目录、文件的日志
&nbsp;&nbsp;&nbsp;&nbsp;只要在git log命令后加上目录名，便会只显示该目录下的日志。如果加的是文件名，就会只显示与该文件相关的日志。

	$ git log README.md
#### 显示文件的改动
&nbsp;&nbsp;&nbsp;&nbsp;如果想查看提交所带来的改动，可以加上 -p参数，文件的前后差别就会显示在提交信息之后。

	$ git log -p
&nbsp;&nbsp;&nbsp;&nbsp;比如，执行下面的命令就可以只查看README.md文件的提交日志以及提交前后的差别。

	$ git log -p README.md
&nbsp;&nbsp;&nbsp;&nbsp;如上所述，git log命令可以利用多种参数帮助开发者把握以往提交的内容。不必勉强自己一次记下全部参数，每当有想查看的日志就积极去查，慢慢就能得心应手了。
### git diff----查看更改前后的差别
&nbsp;&nbsp;&nbsp;&nbsp;git diff命令可以查看工作树、暂存区、最新提交之间的区别。

	echo "# Git教程" > README.md
&nbsp;&nbsp;&nbsp;&nbsp;这里用Markdown语法写下了一行题目。
#### 查看工作树和暂存区的差别
&nbsp;&nbsp;&nbsp;&nbsp;执行git diff命令，查看当前工作树与暂存区的差别。

	$ git diff
	
	diff --git a/README.md b/README.md
	index e69de29..ae5cf4d 100644
	--- a/README.md
	+++ b/README.md
	@@ -0,0 +1 @@
	+# Git教程
&nbsp;&nbsp;&nbsp;&nbsp;由于我们尚未用git add命令向暂存区添加任何东西，所以程序只显示工作树与最新提交状态之间的差别。

&nbsp;&nbsp;&nbsp;&nbsp;“+”标出的是新添加的行，被删除的用“-”标出。用git add将README.md加入暂存区。
#### 查看工作树和最新提交的差别
&nbsp;&nbsp;&nbsp;&nbsp;如果现在执行git diff命令，由于工作树和暂存区的状态并无差别，所以什么都不会显示。要查看与最新提交的差别，执行以下命令。

	$ git diff HEAD
	diff --git a/README.md b/README.md
	index e69de29..ae5cf4d 100644
	--- a/README.md
	+++ b/README.md
	@@ -0,0 +1 @@
	+# Git教程
&nbsp;&nbsp;&nbsp;&nbsp;不妨养成这样的好习惯：在执行git commit命令之前先执行git diff HEAD命令，查看本次提交与上次提交之前有什么差别，等确认完毕后再进行提交。这里的HEAD是指向当前分支中最新一次提交的指针。

&nbsp;&nbsp;&nbsp;&nbsp;由于我们刚刚确定过两个提交之间的差别，所以直接运行git commit命令。

	$ git commit -m "Add index"
	[master b79aa89]Add index
		1 file changed, 1 insertion(+)
### git branch----显示分支一览表
&nbsp;&nbsp;&nbsp;&nbsp;在进行多个并行作业时，我们会用到分支。在这类并行开发中，往往同时存在多个最新代码状态。

