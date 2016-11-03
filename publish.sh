#!/bin/bash

function waitForAnyKey {
  echo #Newline
  WAITPROMPT="Press any key to continue (or Ctrl-C to abort)..."
  if [[ -n "$1" ]]; then
          WAITPROMPT="$1"
  fi
  read -d '' -t 1 -n 10000 # Clear stdin of any keypresses, including multiple RETURNs
  read -n1 -s -p "$WAITPROMPT" # Read 1 character silently with prompt
  echo  #Newline
}

echo "WARNING: This will change the current branch to 'master' and delete local branch 'gh-pages'."
echo "         Any work that has not been committed and PUSHED (tracked and untracked) will be deleted."
echo -n "         Are you sure you want to continue? [y/N]: "
read doit
if [ "${doit}" != "y" ]; then
  echo "Publish aborted.";
  exit 0
fi

echo "Cleaning up and switching to branch master..."
if ! git branch | grep "* master" > /dev/null; then
  git checkout -f master
fi
git reset --hard origin/master
git clean -fd .
if git branch | grep "gh-pages" > /dev/null; then
  git branch -D gh-pages
fi

echo -n "Branch of repo 'oppgaver' [default=master]: "
read oppgaver_branch
if [ -z "${oppgaver_branch// }" ]; then oppgaver_branch='master'; fi

echo -n "Branch of repo 'codeclub-viewer' [default=master]: "
read cv_branch
if [ -z "${cv_branch// }" ]; then cv_branch='master'; fi

url_path_prefix='beta'
echo -n "An url path prefix is the first part of the url path,"
echo "e.g. 'beta' in http://kodeklubben.github.io/beta/scratch"
echo -n "The default is '${url_path_prefix}'. Would you like to change that? [y/N]: "
read change_url_path_prefix
if [ "${change_url_path_prefix}" = "y" ]; then
  echo -n "Url path prefix [press ENTER for none]: ";
  read url_path_prefix;
fi
echo "Using oppgaver/$oppgaver_branch and codeclub-viewer/$cv_branch"
echo "Url path prefix: '$url_path_prefix'"
waitForAnyKey

if ! git remote -v | grep oppgaver > /dev/null; then
  git remote add oppgaver git@github.com:kodeklubben/oppgaver.git
fi
if ! git remote -v | grep codeclub-viewer > /dev/null; then
  git remote add codeclub-viewer git@github.com:kodeklubben/codeclub-viewer.git
fi
echo "Fetching 'oppgaver'..."
git fetch oppgaver
echo "Fetching 'codeclub-viewer'..."
git fetch codeclub-viewer

git read-tree --prefix=oppgaver/ -u oppgaver/${oppgaver_branch}
git read-tree --prefix=codeclub-viewer/ -u codeclub-viewer/${cv_branch}

cd codeclub-viewer
NODEVERSION=`node -v`
RECOMMENDEDVERSION=`cat .nvmrc`
if [ "${NODEVERSION//v}" != "${RECOMMENDEDVERSION}" ]; then
  echo "Node version is ${NODEVERSION}"
  echo "Recommended version is ${RECOMMENDEDVERSION}"
  echo "Are you sure you want to continue?"
  waitForAnyKey
else
  echo "Detected adequate version of node (${NODEVERSION})"
fi
if ! command -v foo >/dev/null 2>&1; then
  echo "yarn package manager not installed. Aborting."
  echo "Install yarn (e.g. 'npm install -g yarn') and try again."
  exit 1
else
  echo "yarn package manager detected."
fi

if [ -n "$url_path_prefix" ]; then
  echo "$url_path_prefix" > url-path-prefix.config;
  git add url-path-prefix.config
fi

#nvm use
echo "Downloading packages..."
yarn

echo "Building website..."
yarn run build:prod

echo "Website is now built."
echo "Feel free to test it before publishing."
echo "Open up a second terminal, and go to the folder `pwd`"
echo "Make sure you have http-server installed globally (yarn global add http-server),"
echo "and then run 'yarn run serve'. Go to http://localhost:8080/$url_path_prefix"
echo "and test until you are satisfied."
waitForAnyKey

sed -i.bak '/dist/d' .gitignore
cd ..
mv codeclub-viewer/dist .
git add dist
git rm -rf codeclub-viewer
git rm -rf oppgaver
git clean -fd .
git commit -m "Add the built site from oppgaver/${oppgaver_branch} `git log oppgaver/master -n 1 | head -1` and codeclub-viewer/${cv_branch} `git log codeclub-viewer/master -n 1 | head -1`"

git checkout -b gh-pages origin/gh-pages
git rm -r --quiet *
git commit --quiet -m "Delete old files"
subfolder=dist
if [ -n ${url_path_prefix} ]; then subfolder=${subfolder}/${url_path_prefix}; fi
echo "Retrieving files from: ${subfolder}"
git merge --squash -s recursive -X subtree=${subfolder} -X theirs master
touch .nojekyll
git add .nojekyll
git commit --amend -m "Publish site from oppgaver/$oppgaver_branch `git log oppgaver/${oppgaver_branch} -n 1 | head -1` and codeclub-viewer/${cv_branch} `git log codeclub-viewer/${cv_branch} -n 1 | head -1`"

echo "Cleaning up..."
git remote remove oppgaver
git remote remove codeclub-viewer
git checkout master
git reset --hard origin/master
git checkout gh-pages

echo ""
echo "ALMOST FINISHED!"
echo "To publish and make the changes public, write:"
echo "   git push"
