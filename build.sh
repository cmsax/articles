(envsubst < template.yml) >> _config.yml

npm i -g hexo hexo-generator-search
hexo init pages && cd pages
npm install

git clone $theme_repo themes/$theme_name
cp -r ../articles/* ./source/_posts
cp -f ../../.config.yml ./_config.yml

hexo generate

