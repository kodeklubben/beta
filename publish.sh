#!/bin/bash

# TODO: Check that we have the correct version of node (compare with .nvmrc)
echo "Please make sure that you are using the correct version of node and npm,"
echo "preferrably by typing 'nvm use' before starting."

echo -n "Branch of repo 'oppgaver' [default=master]: "
read oppgaver_branch
if [ -z "${oppgaver_branch// }" ]; then oppgaver_branch='master'; fi

echo -n "Branch of repo 'codeclub-viewer' [default=master]: "
read cv_branch
if [ -z "${cv_branch// }" ]; then cv_branch='master'; fi

echo -n "Url path prefix [default is none]: "
read url_path_prefix
if [ -z "${url_path_prefix// }" ]; then url_path_prefix=''; fi

echo "Using oppgaver/$oppgaver_branch and codeclub-viewer/$cv_branch"
echo "Url path prefix: '$url_path_prefix'"

git remote add oppgaver -f git@github.com:kodeklubben/oppgaver.git
git remote add codeclub-viewer -f git@github.com:kodeklubben/codeclub-viewer.git

git checkout master
if [ -e oppgaver ]; then
  git rm -r oppgaver;
fi
if [ -e codeclub-viewer ]; then
  git rm -r codeclub-viewer;
fi

git read-tree --prefix=oppgaver/ -u oppgaver/${oppgaver_branch}
git read-tree --prefix=codeclub-viewer/ -u codeclub-viewer/${cv_branch}

cd codeclub-viewer
if [ -n "$url_path_prefix" ]; then
  echo "$url_path_prefix" > url-path-prefix.config;
fi
#nvm use
npm install
npm run build:prod

echo "Website is now built."
echo "Feel free to test it before publishing."
echo "Open up a second terminal, and go to the folder `pwd`"
echo "Make sure you have http-server installed globally (npm install -g http-server),"
echo "and then run 'npm run serve'. Go to http://localhost:8080/$url_path_prefix"
echo "and test until you are satisfied."
echo ""
echo "To continue, press ENTER."
read -t 1 -n 10000 discard
read dummy

sed -i.bak '/dist/d' .gitignore
git commit --all -m "Add the built site from oppgaver/${oppgaver_branch} `git log oppgaver/master -n 1 | head -1` and codeclub-viewer/${cv_branch} `git log codeclub-viewer/master -n 1 | head -1`"

git checkout gh-pages
git rm -r *
git commit -m "Delete old files"
subfolder=dist
if [ -n ${url_path_prefix} ]; then subfolder=${subfolder}/${url_path_prefix}; fi
git merge --squash -s recursive -X subtree=codeclub-viewer/${subfolder} -X theirs master
touch .nojekyll
git add .nojekyll
git commit -m "Publish site from oppgaver/$oppgaver_branch `git log oppgaver/${oppgaver_branch} -n 1 | head -1` and codeclub-viewer/${cv_branch} `git log codeclub-viewer/${cv_branch} -n 1 | head -1`"

echo "All is now ready. To publish, write"
echo "   git push"


