#!/usr/bin/env sh

# 當發生錯誤時終止腳本運行
set -e

# 打包
yarn build

# 移動至到打包後的dist目錄
cd dist

git init # 因為dist資料夾預設是被ignore的，因此在進入dist資料夾後初始化git
git add -A
git commit -m 'deploy'

# 部署到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages
# 以這個專案來講就要改成這樣以下這樣
git push -f git@github.com:Jeeying/clickToTrans.git master:gh-pages

cd -