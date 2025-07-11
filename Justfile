export BUILD_DIR := "./build"

build: html
    #!/bin/bash
    set -e
    mkdir -p $BUILD_DIR/img
    cat *html | grep -o 'https://i.postimg.cc/[^"'"'"']*' | while read u ; do
        file=$BUILD_DIR/img/${u#https://i.postimg.cc/}
        mkdir -p "$(dirname "$file")"
        echo "$u" "->" "$file"
        wget -q -O "$file" "$u"
    done

html:
    sed 's|https://i.postimg.cc/|/img/|g' < Homepage.html > $BUILD_DIR/index.html
    sed 's|https://i.postimg.cc/|/img/|g' < studovna.html > $BUILD_DIR/studovna.html

clean:
    rm -r build
