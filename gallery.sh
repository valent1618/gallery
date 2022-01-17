#!/bin/bash

if [ $1 ]
then
	cd $1
fi

find *.jpg *.jpeg *.png > list.txt 2>/dev/null

numberOfImages=`cat list.txt | wc -l`


html="<!DOCTYPE html>
<html>
    <head>
        <title>Galerie</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>"

if [ $numberOfImages != 0 ]
then
	for i in `seq 1 $numberOfImages`
	do
		html+="<img src=\"`pwd`/`sed -n "$i p" list.txt`\">"
	done
else
	html+="<h1>No pictures found in your folder</h1>"
fi

html+="</body></html>"


css="body {
  background-color: black;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  min-height: 100vh;
}

img {
  width: 500px;
  margin: 25px;
  border-radius: 10px;
  box-shadow: 0px 0px 10px 5px white;
  transition: 0.5s ease;
}

img:hover {
  width: 475px;
}
h1 {
  padding: 2em;
  border: 5px solid white;
  border-radius: 10px;
  box-shadow: 0px 0px 25px 5px white;
}" 

mkdir galleryHtml
cd galleryHtml

echo $html > index.html

echo $css > styles.css

google-chrome index.html

sleep 1

cd ..
rm -r galleryHtml/ list.txt
