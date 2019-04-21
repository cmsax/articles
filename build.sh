#!bin/sh
# Theme
export theme_repo="https://github.com/probberechts/hexo-theme-cactus.git"
export theme_name="cactus"
# Meta
export hexo_title="Articles"
export hexo_author="cmsax"
export hexo_lang="en"
export hexo_description="Daily research notes about nlp, quant and engineering."
# Url
#export hexo_url="https://blog.unoiou.com/articles"
#export hexo_root="/articles/"
export hexo_permalink=":year/:month/:day/:title/"
export hexo_seo_title="Daily research notes about nlp, quant and engineering."
# Social links
export weibo="https://weibo.com/cmsax"
export hexo_email="cmsax@live.com"
export github_url="https://github.com/cmsax"

# Constants
searchPage='./source/search/index.md'
archivesPage='./source/archives/index.md'

(envsubst < config_template.yml) >> _config.yml
(envsubst < theme_config_template.yml) >> _theme_config.yml

cat _config.yml

npm i -g hexo
hexo init pages && cd pages
npm install
npm i hexo-generator-search hexo-generator-feed --save

git clone $theme_repo themes/$theme_name

ls ./themes

rm ./source/_posts/*
cp -r ../articles/* ./source/_posts
cp -f ../_config.yml ./_config.yml
cp -f ../_theme_config.yml ./themes/$theme_name/_config.yml

# Search page
hexo new page search && echo '---\ntitle: Search\ntype: search\n---\n' > $searchPage && cat $searchPage
# Archives page
hexo new page archives && echo '---\ntitle: Archives\ntype: archives\n---\n' > $archivesPage && cat $archivesPage
# Categories automation
# hexo new page categories

echo _config.yml
cat ./_config.yml

echo $theme_name/_config.yml
cat ./themes/$theme_name/_config.yml

hexo generate

