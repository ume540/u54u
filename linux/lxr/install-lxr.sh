#!/bin/bash -x

echo "----------------------------------------------------------------------"
echo "-- install reuired packages"
echo "----------------------------------------------------------------------"
sudo aptitude install git-core
sudo aptitude install postgresql
sudo aptitude install postgresql-client
sudo aptitude install libxapian15
sudo aptitude install libsearch-xapian-perl
sudo aptitude install apache2 libapache2-mod-perl2
sudo aptitude install libcgi-simple-perl libcgi-ajax-perl libhtml-parser-perl libtemplate-perl
sudo aptitude install libterm-progressbar-perl libdevel-size-perl
sudo aptitude install exuberant-ctags
sudo aptitude install texlive
sudo aptitude install inkscape

echo "----------------------------------------------------------------------"
echo "-- install LXR"
echo "----------------------------------------------------------------------"
tar xf lxr-0.11.1.tgz
mv lxr-0.11.1 lxr
pushd lxr
./genxref --checkonly
popd

