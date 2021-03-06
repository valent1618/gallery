#!/bin/bash

if [ $1 ]
then
	cd $1
fi

find . -name "*.jpg" >> list.txt 2>/dev/null
find . -name "*.jpeg" >> list.txt 2>/dev/null
find . -name "*.png" >> list.txt 2>/dev/null

numberOfImages=`cat list.txt | wc -l`


html="<!DOCTYPE html>
<html>
    <head>
        <title>Galerie</title>
        <link rel='stylesheet' href='styles.css'>
	      <link rel='preconnect' href='https://fonts.googleapis.com'>
	      <link rel='preconnect' href='https://fonts.gstatic.com' crossorigin>
	      <link href='https://fonts.googleapis.com/css2?family=Neonderthaw&display=swap' rel='stylesheet'>
    </head>
    <body>"

if [ $numberOfImages != 0 ]
then
	for i in `seq 1 $numberOfImages`
	do
		html+="<img src=\".`sed -n "$i p" list.txt`\">"
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
  font-family: 'Neonderthaw', cursive;
}

img {
  width: 500px;
  margin: 25px;
  border-radius: 10px;
  box-shadow: 0px 0px 10px 5px white;
  filter: brightness(0.5);
  transition: 0.5s ease;
}

img:hover {
  filter: none;
}

h1 {
  font-size: 5em;
  border-radius: 10px;
  text-shadow: 0 0 0.1em currentColor;
  opacity: 0.8;
  transition: 0.2s ease;
}

h1:hover {
  opacity: 1;
  text-shadow: 0 0 0.2em currentColor;
}" 

mkdir galleryHtml
cd galleryHtml

echo $html > index.html

echo $css > styles.css

google-chrome index.html

sleep 1

cd ..

rm -r galleryHtml/ list.txt
