# practice--js
This repository is for practice of ``js``.

## How to install nodebrew

1. Install nodebrew
```bash
$ curl -L git.io/nodebrew | perl - setup
$ echo 'export PATH=/usr/loca/var/nodebrew/current/bin:$PATH' >> ~/.bash_profile
$ nodebrew -v
nodebrew 1.0.1

Usage:
...
```

1. Install Node.js
```bash
$ nodebrew ls-remote # Show the version of Node.js which You can install
v0.0.1    v0.0.2    v0.0.3    v0.0.4    v0.0.5    v0.0.6
...
$ nodebrew install-binary latest # You can install lates version of Node.js
...
Installed Successfully
$ nodebrew ls # Show the Node.js list you installed
v12.4.0

current: none
```

3. Valid the version you want to use
```
$ nodebrew use v14.2.0
$ node -v
node v14.2.0
$ npm -v
6.8.0
```


