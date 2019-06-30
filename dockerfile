FROM node:10.15.3-alpine
# 设置标签
LABEL author=长沙.net社区 email=xinlai@xin-lai.com site=http://hn-tech.net
# 设置容器内端口
EXPOSE 8000
# 添加目录
ADD . /app
# 设置当前工作目录
WORKDIR /app
# 复制文件
COPY . .
# 设置npm并且使用npm安装hexo以及相关插件，然后生成静态页并且安装hexo-server
RUN npm config set unsafe-perm true && \
    npm config set registry https://registry.npm.taobao.org && \
    npm install -g hexo-cli && \
    # hexo clean && \
    cd src && \
    npm install hexo --save && \
    npm install hexo-neat --save && \
    npm install --save hexo-wordcount && \
    npm i -S hexo-prism-plugin && \
    npm install hexo-generator-search --save && \
    npm i hexo-permalink-pinyin --save && \
    hexo generate && \
    npm install hexo-server --save
# 设置工作目录
WORKDIR src
# 使用hexo-server托管静态文件
ENTRYPOINT ["hexo", "server","-p","8000"]
