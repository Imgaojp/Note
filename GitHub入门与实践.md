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
&nbsp;&nbsp;&nbsp;&nbsp;在进行多个并行作业时，我们会用到分支。在这类并行开发中，往往同时存在多个最新代码状态。如下图所示，从master分支创建feature-A分支和fix-B分支后，每个分支都有自己的最新代码。master分支是Git默认创建的分支，因此基本上所有开发都是以这个分支为中心进行的。

![](https://github.com/imgaojp/Note/raw/master/images/branch.jpg)

&nbsp;&nbsp;&nbsp;&nbsp;不同分支中，可以同时进行完全不同的作业。等该分支的作业完成之后再与master分支合并。比如feature-A分支的作业结束后与master合并。如下图所示。

&nbsp;&nbsp;&nbsp;&nbsp;通过灵活运用分支，可以让多个人同时进行并行开发。

![](https://github.com/imgaojp/Note/raw/master/images/branch-2.jpg)

&nbsp;&nbsp;&nbsp;&nbsp;git branch命令可以将分支名列表显示，同时可以确认当前所在分支。

	$ git branch
	* master
&nbsp;&nbsp;&nbsp;&nbsp;可以看到master分支左侧有“*”，表示这是当前所在的分支。也就是说正在master分支下进行开发。结果没有显示其他分支名，表示本地仓库中只存在master一个分支。
### git checkout -b----创建、切换分支
&nbsp;&nbsp;&nbsp;&nbsp;如果想以当前的master分支为基础创建新的分支，我们需要用到git checkout -b命令。
#### 切换到feature-A分支并进行提交
&nbsp;&nbsp;&nbsp;&nbsp;执行下面的命令，创建名为feature-A的分支。

	$ git checkout -b feature-A
	Switched to a new branch 'feature-A'
&nbsp;&nbsp;&nbsp;&nbsp;实际上，连续执行下面两条命令也可以达到同样的效果。

	$ git branch feature-A
	$ git checkout feature-A

&nbsp;&nbsp;&nbsp;&nbsp;创建feature-A分支，并将当前分支切换为feature-A分支。再来查看分支列表：

	$ git branch
	* feature-A
	  master

&nbsp;&nbsp;&nbsp;&nbsp;feature-A分支左侧标有“*”，表示当前分支为feature-A。在这个状态下像正常开发那样修改代码、执行git add命令并进行提交的话，代码就会提交至feature-A分支。像这样不断对一个分支进行提交的操作，称为“培育分支”。接下来，在README.md文件中添加一行“- feature-A”。然后进行提交。

	$ git add README.md
	$ git commit -m "Add feature-A"
	[feature-A cc818b5] Add feature-A
		1 file changed, 2 insertions(+)

&nbsp;&nbsp;&nbsp;&nbsp;这一行就加到feature-A中了。

#### 切换到master分支
&nbsp;&nbsp;&nbsp;&nbsp;切换至master分支。

	$ git checkout master
	Switched to branch 'master'

&nbsp;&nbsp;&nbsp;&nbsp;然后查看README.md文件，发现仍然保持原来的状态，并没有添加文字。feature-A分支的更改不会影响到master分支，这正是开发中创建分支的优点。只要创建多个分支，就可以在不互相影响的情况下同时进行多个功能的开发。
#### 切换回上一个分支
&nbsp;&nbsp;&nbsp;&nbsp;用“-”代替分支名，就可以切换至上一个分支。

	$ git checkout -
	Switched to branch 'feature-A'

### 特性分支
&nbsp;&nbsp;&nbsp;&nbsp;Git与Subversion（SVN）等集中型版本管理系统不同，创建分支时不需要连接中央仓库，所以能够相对轻松地创建分支。因此，当今大部分工作流程中都用到了特性（Topic）分支。

&nbsp;&nbsp;&nbsp;&nbsp;特性分支顾名思义，是集中实现单一特性（主题），除此之外不进行任何作业的分支。在日常开发中，往往会创建数个特性分支，同时在此之外再保留一个随时可以发布软件的稳定分支。稳定分支的角色通常由master分支担当。

&nbsp;&nbsp;&nbsp;&nbsp;之前我们创建了feature-A分支，之一分支主要实现了feature-A，除feature-A的实现之外不进行任何作业。即便在开发过程中发现了BUG，也需要再创建新的分支，在新分支中进行修正。

&nbsp;&nbsp;&nbsp;&nbsp;基于特定主题的作业在特性分支中进行，主题完成后再与master分支合并。只要保持这样一个开发流程，就能保证master分支可以随时提供人查看。这样以来，其他开发者也可以放心大胆地从master分支创建新的特性分支。

### 主干分支
&nbsp;&nbsp;&nbsp;&nbsp;主干分支是刚才我们讲解的特性分支的原点，同时也是合并的终点。通常人们用master分支作为主干分支。主干分支并没有开发到一半的代码，可以随时供他人查看。

&nbsp;&nbsp;&nbsp;&nbsp;有时我们需要让这个主干分支总是配置在正式环境中，有时又需要用标签Tag等创建版本信息，同时管理多个版本发布。拥有多个版本发布时，主干分支也有多个。

### git merge----合并分支
&nbsp;&nbsp;&nbsp;&nbsp;接下来，我们假设feature-A已经实现完毕，想要将它合并到主干分支master中。首先切换到master分支。然后合并feature-A分支。为了在历史记录中明确记录下本次分支合并，我们需要创建合并提交。因此，在合并时加上 --no-ff参数。这样，feature-A分支的内容就合并到master分支了。

### git log --graph----以图表形式查看分支
&nbsp;&nbsp;&nbsp;&nbsp;用git log --graph命令进行查看可以清楚地看到特性分支提交的内容已被合并。特性分支的创建以及合并也都清楚明了。

### git reset----回溯历史版本
&nbsp;&nbsp;&nbsp;&nbsp;通过前面学习的操作，我们已经学会如何在实现功能后进行提交，累积提交日志作为历史记录，借此不断培育一款软件。

&nbsp;&nbsp;&nbsp;&nbsp;Git的另一特征便是可以灵活操作历史版本。借助分散仓库的优势，可以在不影响其他仓库的前提下对历史版本进行操作。

&nbsp;&nbsp;&nbsp;&nbsp;在这里我们先回溯历史版本，创建一个名为fix-B的特性分支，如下图。

![](https://github.com/imgaojp/Note/raw/master/images/fix-b.jpg)

#### 回溯到创建feature-A分支前
&nbsp;&nbsp;&nbsp;&nbsp;让我们先回溯到上一节feature-A分支创建前，创建一个名为fix-B的特性分支。

&nbsp;&nbsp;&nbsp;&nbsp;要让仓库的HEAD、暂存区、当前工作树回溯到指定状态，需要用到git reset --hard命令。只要提供目标时间点的哈希值，就可以完全恢复至该时间点的状态。

	$ git reset --hard b79aa8942ad4eaa823e8dbec86af754fc3983792
	HEAD is now at b79aa89 Add index

&nbsp;&nbsp;&nbsp;&nbsp;已经成功回溯到特性分支（feature-A）创建之前的状态。

#### 创建fix-B分支
&nbsp;&nbsp;&nbsp;&nbsp;首先创建fix-B分支。

	$ git checkout -b fix-B
	Switched to a new branch 'fix-B'

&nbsp;&nbsp;&nbsp;&nbsp;向README.md文件中添加一行文字。然后直接提交README.md文件。

&nbsp;&nbsp;&nbsp;&nbsp;现在的状态如下图所示。

![](https://github.com/imgaojp/Note/raw/master/images/fix-b-2.jpg)

&nbsp;&nbsp;&nbsp;&nbsp;接下来我们的目标是下图所示的状态，即主干分支合并feature-A分支的修改后，又合并了fix-B的修改。

![](https://github.com/imgaojp/Note/raw/master/images/fix-b-3.jpg)

#### 推进至feature-A分支合并后的状态

&nbsp;&nbsp;&nbsp;&nbsp;首先恢复到feature-A分支合并后的状态（推进历史）。

&nbsp;&nbsp;&nbsp;&nbsp;git log命令只能查看以当前状态为终点的历史日志。所以这里使用git reflog命令，查看当前仓库的操作日志。在日志中找出回溯历史之前的哈希值，通过git reset --hard命令恢复到回溯历史前的状态。

&nbsp;&nbsp;&nbsp;&nbsp;首先执行git reflog命令，查看当前仓库执行过的操作日志。

	$ git reflog
	a7a4d73 HEAD@{0}: commit: Fix B
	b79aa89 HEAD@{1}: checkout: moving from master to fix-B
	b79aa89 HEAD@{2}: reset: moving to b79aa8942ad4eaa823e8dbec86af754fc3983792
	d87390c HEAD@{3}: merge feature-A: Merge made by the 'recursive' strategy.
	b79aa89 HEAD@{4}: checkout: moving from feature-A to master
	cc818b5 HEAD@{5}: checkout: moving from master to feature-A
	b79aa89 HEAD@{6}: checkout: moving from feature-A to master
	cc818b5 HEAD@{7}: checkout: moving from master to feature-A
	b79aa89 HEAD@{8}: checkout: moving from feature-A to master
	cc818b5 HEAD@{9}: commit: Add feature-A
	b79aa89 HEAD@{10}: checkout: moving from master to feature-A
	b79aa89 HEAD@{11}: commit: Add index
	1039220 HEAD@{12}: commit: test
	416bc86 HEAD@{13}: commit: asdffasdlkj
	c03e955 HEAD@{14}: commit: asdlfkj
	473046a HEAD@{15}: commit (initial): First commit

&nbsp;&nbsp;&nbsp;&nbsp;在日志中，我们可以看到commit、checkout、reset、merge等Git命令的执行记录。只要不进行Git的GC（garbage collection），就可以通过日志随意调取近期的历史状态。即使开发者错误执行了Git操作，基本也都可以利用git reflog命令恢复到原先的状态，***牢记本部分。***

&nbsp;&nbsp;&nbsp;&nbsp;从上面数第四行表示feature-A特性分支合并后的状态，对应哈希值为d87390c。我们将HEAD、暂存区、工作树恢复到这个时间点的状态。

	$ git checkout -
	Switched to branch 'master'
	
	$ git reset --hard d87390c
	HEAD is now at d87390c Merge branch 'feature-A'

&nbsp;&nbsp;&nbsp;&nbsp;通过git reset --hard命令恢复到了回溯前的历史状态。当前的状态如下所示。

![](https://github.com/imgaojp/Note/raw/master/images/fix-b-4.jpg)

### 消除冲突
&nbsp;&nbsp;&nbsp;&nbsp;现在只要合并fix-B分支，就可以得到我们想要的状态。

	$ git merge --no-ff fix-B
	Auto-merging README.md
	CONFLICT (content): Merge conflict in README.md
	Automatic merge failed; fix conflicts and then commit the result.

&nbsp;&nbsp;&nbsp;&nbsp;这时，系统告诉我们README.md文件发生了冲突（Conflict）。系统在合并README.md文件时，feature-A分支更改的部分与本次想要合并的fix-B分支更改的部分发生了冲突。

#### 查看冲突部分并解决

&nbsp;&nbsp;&nbsp;&nbsp;用编辑器打开README.md文件，就会发现其内容变成了如下。

	<<<<<<< HEAD
	# Git教程 
	  - feature-A
	=======
	# Git教程
	  - fix-B
	>>>>>>> fix-B

&nbsp;&nbsp;&nbsp;&nbsp;=======以上的部分就是当前HEAD的内容，以下的部分是要合并的fix-B分之中的内容。我们在编辑器中将其改为想要的样子。

	# Git教程 
	  - feature-A
	  - fix-B

&nbsp;&nbsp;&nbsp;&nbsp;本次修正让feature-A与fix-B的内容并存于文件之中。但是在实际开发中，往往需要删除其中之一，所以务必仔细分析冲突部分的内容后再修改。

#### 提交解决后的结果

&nbsp;&nbsp;&nbsp;&nbsp;冲突解决后，执行git add命令与git commit命令。

	$ git add README.md
	
	$ git commit -m "Fix conflict"
	[master 31b43ba] Fix conflict

### git commit --amend----修改提交信息

&nbsp;&nbsp;&nbsp;&nbsp;我们将上一条提交信息记为了“Fix conflict”，但是它其实是fix-B分支的合并，解决合并时发生的冲突只是过程之一，这样标记不妥。我们修改这一条信息。

	$ git commit --amend

### git rebase -i----压缩历史

&nbsp;&nbsp;&nbsp;&nbsp;合并特性分支前，如果发现已提交的内容中有拼写错误等，不妨提交一个修改，然后将这个修改包含到前一个提交之中，压缩为一个历史记录。

#### 创建feature-C分支

&nbsp;&nbsp;&nbsp;&nbsp;首先创建feature-C特性分支。
	
	$ git checkout -b feature-C
	Switched to a new branch 'feature-C'

&nbsp;&nbsp;&nbsp;&nbsp;作为feature-C的功能实现，我们在README.md中添加一行文字，并故意留下拼写错误。然后提交这部分内容，用git commit -am命令来一次完成git add和git commit这两步操作。

	$ git commit -am "Add "
	[feature-C a6dbae8] Add
	 1 file changed, 1 insertion(+)

#### 修正拼写错误
&nbsp;&nbsp;&nbsp;&nbsp;修正README.md文件的内容，修正后的差别如下所示。

	$ git diff
	diff --git a/README.md b/README.md
	index c6574df..eb39065 100644
	--- a/README.md
	+++ b/README.md
	@@ -1,4 +1,4 @@
	 # Git教程
	   - feature-A
	   - fix-B
	-  - faeture-C
	\ No newline at end of file
	+  - feature-C
	\ No newline at end of file

&nbsp;&nbsp;&nbsp;&nbsp;然后进行提交。

	$ git commit -am "Fix typo"
	[feature-C 2fa40fa] Fix typo
	 1 file changed, 1 insertion(+), 1 deletion(-)

&nbsp;&nbsp;&nbsp;&nbsp;实际上，我们不希望在历史记录中看到这类提交，因为健全的历史记录并不需要它们。

#### 更改历史

&nbsp;&nbsp;&nbsp;&nbsp;因此，我们来更改历史。将“Fix typo”修正的内容与之前一次的提交合并，在历史记录中合并为一次完美的提交。为此，我们要用到git rebase命令。

	$ git rebase -i HEAD~2

&nbsp;&nbsp;&nbsp;&nbsp;用上述方式执行git rebase命令，可以选定当前分支中包含HEAD（最新提交）在内的两个最新历史记录为对象，并在编辑器中打开。编辑后退出编辑器，再查看日志时发现已经更改。

#### 合并至master分支

&nbsp;&nbsp;&nbsp;&nbsp;feature-C分支的使命告一段落，将其与master分支合并。
	
	$ git checkout master
	Switched to branch 'master'
	
	$ git merge --no-f feature-C
	Merge made by the 'recursive' strategy.
	 README.md | 1 +
	 1 file changed, 1 insertion(+)

&nbsp;&nbsp;&nbsp;&nbsp;master分支整合了feature-C分支。

### 推送至远程仓库

&nbsp;&nbsp;&nbsp;&nbsp;