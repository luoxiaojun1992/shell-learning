#! /bin/bash

cd ~

node -v

if [ $? -ne 0 ]; then

wget https://npm.taobao.org/mirrors/node/v8.4.0/node-v8.4.0-linux-x64.tar.gz

if [ $? -ne 0 ]; then
    echo 'Failed to download nodejs'
    return 1
fi

tar -zxvf node-v8.4.0-linux-x64.tar.gz
if [ $? -ne 0 ]; then
    echo 'Failed to extract nodejs'
    return 1
fi

echo 'export NODE_HOME=/root/node-v8.4.0-linux-x64' >> /root/.bashrc
echo 'export PATH=$NODE_HOME/bin:$PATH' >> /root/.bashrc
source /root/.bashrc

fi

if [ ! -d '/root/luoxj-blog' ]; then
    git clone https://github.com/luoxiaojun1992/luoxj-blog.git
fi

cd luoxj-blog

git pull

npm install

# npm start

npm run build

serve -v
if [ $? -ne 0 ]; then
    npm install -g serve
fi

nohup serve -s build &

cd ~

