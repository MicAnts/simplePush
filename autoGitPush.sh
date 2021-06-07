# mac系统：cd file 后 chmod +x file 添加执行权限
# 根据提示输入路径 自动跳转后输入commit 信息
hisoryCachFileName="./dirnamePathHistory.txt";
selectArray=();
# 验证是否存在缓存文件
if [ ! -e $hisoryCachFileName ]; then
  echo "手动输入">>$hisoryCachFileName;
  echo "\033[41;37m 创建成功 \033[0m";
fi
# 读取缓存文件内容 并复制进 变量 selectArray中
for line in $(cat $hisoryCachFileName)
  do
    selectArray[${#selectArray[*]}]=$line;
  done
# 选项
echo "\033[46;37m 请选择 \033[0m"
autoPushPath=""
select selectPath in ${selectArray[@]};do
  case $selectPath in 
    "手动输入")
      read -p "请输入绝对路径：" autoPushPath;
      break
      ;;
    "")
      read -p "请输入绝对路径：" autoPushPath;
      break
      ;;
    *)
      autoPushPath=$selectPath;
      break;
  esac    
done
# 逐行比对 历史记录
function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}
echo "对比结果  $(contains "${selectArray[@]}" $autoPushPath)"
if [ $(contains "${selectArray[@]}" $autoPushPath) != "y" ]; then
  echo $autoPushPath>>$hisoryCachFileName;  
fi

# 异常处理 
echo "路径是： $autoPushPath"
if cd $autoPushPath; then
  # 读取切换后文件路径
  curPath=$(readlink -f "$(dirname "$0")")
  echo "\033[41;37m 当前位于：$curPath \033[0m"    
else
  echo "\033[31m 路径错误 \033[0m" 1>&2
  exit 1
fi 
git status
git add .
echo "\033[46;37m 请输入commit内容 \033[0m"
read commit
if git commit -m "$commit"; then
  if git pull;then 
    if git push;then
      echo 'push Success！！！'
    else 
      exit 1    
    fi  
  else 
    exit 1    
  fi
else 
  exit 1  
fi
