

check_for_conflicts () {
   grep -r "<<<<<<<" .

   if [ $? -eq 0 ] ; then
     echo "<<<<<<< found, there are likely git clonflicts, exiting"
     termux-notification -c "obsidian sync failed, check git conflicts!"
     exit 1
   fi
}





TPWD=$PWD

cd /data/data/com.termux/files/home/storage/shared/dev/github.com/hpdobrica/digital-garden

check_for_conflicts

MSG="Pixel 6 backup at $(date)"

git submodule foreach git add -A .
git submodule foreach "git commit -am '$MSG' || true"
git submodule foreach git pull --rebase origin main
check_for_conflicts
git submodule foreach git push


git add -A
git commit -am "$MSG" || true
git pull --rebase origin main
check_for_conflicts
git push


if [ -z "$(git status --porcelain)" ]; then
  echo "working directory clean, all good!"
else
  echo "working directory not clean, script has likely failed to perform sync"
  termux-notification -c "obsidian sync finished, but working directory is not clean - something might be wrong"

fi

cd $TPWD
