#!bin/sh
# Theme
export theme_repo="https://github.com/smallyunet/hexo-theme-yinwang.git"
export theme_name="yinwang"
# Meta
export hexo_title="Articles"
export hexo_author="cmsax"
export hexo_lang="en"
export hexo_description="Monthly research notes about nlp, quant and engineering."
# Url
#export hexo_url="https://blog.unoiou.com/articles"
#export hexo_root="/articles/"
export hexo_permalink=":year/:month/:day/:title/"
export hexo_seo_title="Daily research notes about nlp, quant and engineering."
# Social links
export weibo="https://weibo.com/u/6120834507"
export hexo_email="i@unoiou.com"
export github_url="https://github.com/cmsax"

# Constants
searchPage='./source/search/index.md'

(envsubst <config_template.yml) >>_config.yml
(envsubst <theme_config_template.yml) >>_theme_config.yml

# cat _config.yml

npm i -g hexo --ignore-scripts
rm -rf pages
hexo init pages && cd pages
npm install --ignore-scripts
npm i hexo-generator-search hexo-generator-feed hexo-generator-sitemap bulma-stylus hexo-component-inferno hexo-renderer-inferno inferno inferno-create-element --save
npm install --save bulma-stylus@0.8.0 hexo@^5.0.2 hexo-log@^2.0.0 hexo-util@^2.2.0 hexo-component-inferno@^0.10.1 --ignore-scripts

git clone $theme_repo themes/$theme_name --branch 4.1.0

ls ./themes

rm ./source/_posts/*
cp -r ../articles/* ./source/_posts
cp -r ../special/* ./source/
echo '😱 Files:'
ls
cp -f ../_config.yml ./_config.yml
cp -f ../_theme_config.yml ./themes/$theme_name/_config.yml

# Search page
hexo new page search
echo '---\ntitle: Search\ntype: search\n---\n' >$searchPage
# cat $searchPage
# Categories automation
# hexo new page categories

# echo _config.yml
# cat ./_config.yml

# echo $theme_name/_config.yml
# cat ./themes/$theme_name/_config.yml

# echo '😱 Files:'
# ls

hexo generate
mkdir ./public/appendix
cp -r ../appendix/* ./public/appendix

echo '😱 Files:'
ls
