7digital-mono
=============

All you should need to do:

```
MONO_VERSION=3.2.6 vagrant up
```

After a long wait a `.deb` will magically appear!

Old skool
---------

If you really want to build it on your host you can just call the scripts directly. You'll have to make sure you have all required dependencies yourself.

```
./build-mono-package.bash 3.0.10
./build-xsp-package.bash 3.0.11
```

