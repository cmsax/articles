(envsubst < template.yml) >> _config.yml

cat _config.yml

npm i -g hexo hexo-generator-search
hexo init pages && cd pages
npm install

git clone $theme_repo themes/$theme_name

ls ./themes

cp -r ../articles/* ./source/_posts
cp -f ../_config.yml ./_config.yml

cat ./_config.yml

hexo generate

