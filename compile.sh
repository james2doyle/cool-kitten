#!/usr/bin/env bash

# check to see if cleancss is installed
command -v cleancss >/dev/null 2>&1 || {
  echo "cleancss is required. run: sudo npm install cleancss -g" >&2; exit 1;
}

# check to see if uglifyjs is installed
command -v uglifyjs >/dev/null 2>&1 || {
  echo "uglify-js is required. run: sudo npm install uglify-js -g" >&2; exit 1;
}

# find the folder that this script is in. this is the root of the project
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# short css and js directories
cssDir="$scriptDir/css"
jsDir="$scriptDir/js"

# concat the files and output the minified version
cat "$cssDir/normalize.css" "$cssDir/grid.css" "$cssDir/style.css" | cleancss -o $cssDir/styles.min.css

echo "compiled >> css/styles.min.css"

# grab all the js files and concat them with uglifyjs
uglifyjs "$jsDir/retina.js" "$jsDir/jquery.js" "$jsDir/stellar.js" "$jsDir/scrollspy.js" "$jsDir/script.js" -o "$jsDir/scripts.min.js"

echo "compiled >> js/scripts.min.js"

exit 0