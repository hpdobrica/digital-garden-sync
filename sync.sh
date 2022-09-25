

check_for_conflicts () {
   grep -r "<<<<<<<" .

   if [ $? -eq 0 ] ; then
     echo "<<<<<<< found, there are likely git clonflicts, exiting"
     exit 1
   fi
}





TPWD=$PWD

cd /data/data/com.termux/files/home/storage/shared/dev/github.com/hpdobrica/digital-garden

check_for_conflicts

MSG="Pixel 6 backup at $(date)"

git submodule foreach git add -A .
git submodule foreach git commit -am "$MSG"
git submodule foreach git pull --rebase origin main
check_for_conflicts
git submodule foreach git push


git add -A
git commit -am "$MSG"
git pull --rebase origin main
check_for_conflicts
git push

cd $TPWD
