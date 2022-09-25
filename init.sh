


REPO_DIR="digital-garden"

TPWD=$PWD



cd /data/data/com.termux/files/home/storage/shared/dev/github.com/hpdobrica

if [ -d "$REPO_DIR" ]; then
  echo "dir $REPO_DIR exists at $PWD, remove it first"
  cs $TPWD
  exit 0
fi

git clone git@github.com:hpdobrica/digital-garden.git
cd "$REPO_DIR/"
git submodule init
git submodule update
cd Public/
git branch -u origin/main main
git checkout main

cd $TPWD

