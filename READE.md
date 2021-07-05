### mac 环境的自动 git 提交 shell 脚本

> 脚本逻辑是输入/选择一个本地的 git 仓库路径，然后是输入 commit 内容自动提交
>
> 可以选择手动输入 git 提交路径，也可以选择输入过的 git 提交路径
>
> 只有最简单的 git 提交功能 git add . ----> git commit -m "commit" ----> git pull ----> git push

##### 使用方法

1. 终端进入脚本文件目录
2. chmod +x autoGitPush.sh 添加脚本执行权限
3. ./autoGitPush.sh
4. 根据提示输入/选择
5. 出现 push Success！！！说明 push 成功

### 全局命令设置 
vi ~/.zshrc

文件中增加一下命令
alias simplePush="User/dengdaoyuan/Documents/shell/simple/autoGitPush.sh"

vim退出后执行
source ~/.zshrc