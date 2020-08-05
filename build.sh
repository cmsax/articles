#!bin/sh
# Theme
export theme_repo="https://github.com/ppoffice/hexo-theme-icarus.git"
export theme_name="icarus"
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

cat _config.yml

npm i -g hexo
rm -rf pages
hexo init pages && cd pages
npm install
npm i hexo-generator-search hexo-generator-feed hexo-generator-sitemap bulma-stylus hexo-component-inferno hexo-renderer-inferno inferno inferno-create-element --save
npm install --save bulma-stylus@0.8.0 hexo@^4.2.0 hexo-component-inferno@^0.4.0 hexo-log@^1.0.0 hexo-util@^1.8.0

git clone $theme_repo themes/$theme_name

ls ./themes

rm ./source/_posts/*
cp -r ../articles/* ./source/_posts

ls

cp -r ../pages/* ./source/
cp -f ../_config.yml ./_config.yml
cp -f ../_theme_config.yml ./themes/$theme_name/_config.yml

# Search page
hexo new page search && echo '---\ntitle: Search\ntype: search\n---\n' >$searchPage && cat $searchPage
# Categories automation
# hexo new page categories

echo _config.yml
cat ./_config.yml

echo $theme_name/_config.yml
cat ./themes/$theme_name/_config.yml

ls

hexo generate
cp -r ../appendix/* ./appendix
ls
