7digital-mono
=============

A custom deb package for squeeze and wheezy

This should be done on a debian instance running squeeze or wheezy

Get fpm (we tested with version 0.4.29), and the dependencies required to build mono

 apt-get build-dep mono-runtime
 gem install fpm

Clone
 git@github.com:7digital/7digital-mono.git


Run
 
 ./build-package 3.0.xx  

where 3.0.xx is a version avaiable to download from http://download.mono-project.com/sources/mono/

Wait till the build finishes.

This will create a .deb package in the parent directory (one level up)

Add the .deb package to your apt repository

The package will now be available as "7digital-mono"
