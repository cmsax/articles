export theme_repo="https://github.com/sergodeeva/cactus-white.git"
export theme_name="cactus-white"

(envsubst < config_template.yml) >> _config.yml
(envsubst < theme_config_template.yml) >> _theme_config.yml

cat _config.yml

npm i -g hexo hexo-generator-search
hexo init pages && cd pages
npm install

git clone $theme_repo themes/$theme_name

ls ./themes

rm ./source/_posts/*
cp -r ../articles/* ./source/_posts
cp -f ../_config.yml ./_config.yml
cp -f ../_theme_config.yml ./themes/$theme_name/_config.yml

echo _config.yml
cat ./_config.yml

echo $theme_name/_config.yml
cat ./themes/$theme_name/_config.yml

hexo generate

