7digital-mono
=============

Custom mono deb packages (xsp, mono) for debian (tested with squeeze and wheezy).

This should be run on a debian instance running the version of debian where you will install the deb.

Get fpm (we tested with version 0.4.29), and the dependencies required to build mono:

```
sudo apt-get build-dep install ruby ruby-dev rubygems
sudo gem update
sudo gem install fpm
```

Clone [https://github.com/7digital/7digital-mono.git](https://github.com/7digital/7digital-mono.git)

Run
 
* ./build-mono-package.bash 3.0.10
* ./build-xsp-package.bash 3.0.11

where 3.0.x can be any version available to download:

* Mono: tarball from http://download.mono-project.com/sources/mono/
* XSP: git tag from https://github.com/mono/xsp

Wait till the build finishes. This will create a .deb package.

Add the .deb package to your apt repository.
