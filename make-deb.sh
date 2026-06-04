#!/bin/bash

# Make Deb Package for Phishing (^.^)
_PACKAGE=phishing
_VERSION=1.0
_ARCH="all"
PKG_NAME="${_PACKAGE}_${_VERSION}_${_ARCH}.deb"

if [[ ! -e "scripts/launch.sh" ]]; then
        echo "lauch.sh should be in the \`scripts\` Directory. Exiting..."
        exit 1
fi

if [[ ${1,,} == "termux" || $(uname -o) == *'Android'* ]];then
        _depend="ncurses-utils, proot, resolv-conf, "
        _bin_dir="/data/data/com.termux/files/"
        _opt_dir="/data/data/com.termux/files/usr/"
        #PKG_NAME=${_PACKAGE}_${_VERSION}_${_ARCH}_termux.deb
fi

_depend+="curl, php, unzip"
_bin_dir+="usr/bin"
_opt_dir+="opt/${_PACKAGE}"

if [[ -d "pythonyoutobe" ]]; then rm -fr pythonyoutobe; fi
mkdir -p pythonyoutobe
mkdir -p pythonyoutobe/${_bin_dir} pythonyoutobe/$_opt_dir pythonyoutobe/DEBIAN 

cat <<- CONTROL_EOF > pythonyoutobe/DEBIAN/control
Package: ${_PACKAGE}
Version: ${_VERSION}
Architecture: ${_ARCH}
Maintainer: @Pythonx_100
Depends: ${_depend}
Homepage: https://github.com/pythonyoutobe/phishing
Description: An automated phishing tool with 5 templates and this Tool is made for educational purpose only !
CONTROL_EOF

cat <<- PRERM_EOF > pythonyoutobe/DEBIAN/prerm
#!/bin/bash
rm -fr $_opt_dir
exit 0
PRERM_EOF

chmod 755 pythonyoutobe/DEBIAN
chmod 755 pythonyoutobe/DEBIAN/{control,prerm}
cp -fr scripts/launch.sh pythonyoutobe/$_bin_dir/$_PACKAGE
chmod 755 pythonyoutobe/$_bin_dir/$_PACKAGE
cp -fr .github/ .sites/ LICENSE README.md phishing.sh pythonyoutobe/$_opt_dir
dpkg-deb --build pythonyoutobe${PKG_NAME}
rm -fr pythonyoutobe



