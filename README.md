# How to publish

This text explains how to publish the kodeklubben/codeclub-viewer webpages.

Before publishing the website to the branch `gh-pages` of this repo (`beta`),
make sure you have installed node and yarn. The easiest way is probably to install [nvm](https://github.com/creationix/nvm#installation) first, then go to the
`codeclub-viewer` folder and type `nvm install`. This will install the version
specified by the file `.nvmrc`. Finally, type `npm install -g yarn`.

On OSX, if you have [brew](http://brew.sh/) installed, you could just do
`brew install yarn` (it might be smart to do a `brew update` first).
This will also install node.

If you just want to check that you have the correct version of node,
type `node -v` and compare it to the content of `.nvmrc`.

When this is in order, just type
```
./publish.sh
```

You will then have to specify whether you want you use a different branch than `master` for `codeclub-viewer` and
`oppgaver`.

You must also specify whether you want to add a url path prefix, which is necessary if the website isn't hosted
from the root, e.g. `beta` if you want the site to reside at `kodeklubben.github.io/beta/`.

The script will then delete any previous compiles, check out codeclub-viewer and oppgaver, compile the website,
and allow you to check the website locally. To test it, open up a second terminal, and go into the folder
'codeclub-viewer'. Make sure you have http-server installed globally (if not, type `yarn global add http-server`),
and then run `yarn run serve`. Go to http://localhost:8080/beta (or whatever you chose as your url path prefix)
in your browser and test until you are satisfied. If you are not satisfied, abort the script (ctrl-C),
make your changes and try again.

When you are happy with the result, let the script continue. It will then commit (only locally) the compiled website
to `master`, and then delete the old webpages and commit the new ones to `gh-pages` (as well as adding an empty
 `.nojekyll` file so that files and folders starting with underscore `_` are treated correctly).

**Note that the pages are not published yet; in fact, so far all the changes have been made locally.**
This means that if you delete this repo locally, no harm has been done, and you can start over any time you like.

But, if everything went well, the pages look good, and you are sure you want to publish the pages you just compiled,
just type
```
git push
```

And you're done!
