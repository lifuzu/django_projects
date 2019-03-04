

### Install `telepresence`
https://www.telepresence.io/reference/install

on MacOSX:
```
brew cask install osxfuse
brew install datawire/blackbird/telepresence
```
logs:
```
$ brew cask install osxfuse
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 2 taps (homebrew/core and homebrew/cask).
==> New Formulae
apache-arrow             bumpversion              git-absorb               jinja2-cli               jp                       man-db
==> Updated Formulae
hugo ✔                   clutter-gst              frugal                   linkerd                  numpy                    skaffold
kubernetes-cli ✔         cmake                    gibo                     logstash                 ocrmypdf                 streamlink
libtiff ✔                cocoapods                git-quick-stats          logtalk                  opendetex                swiftformat
mercurial ✔              conan                    gmsh                     lxc                      osrm-backend             swiftgen
node ✔                   conjure-up               gnatsd                   macvim                   oxipng                   syncthing
ruby ✔                   convox                   go@1.10                  maxima                   packer                   telegraf
ruby-build ✔             cromwell                 gradle                   maxwell                  pandoc                   tgui
sphinx-doc ✔             cryfs                    gtk+3                    mesa                     pgweb                    timidity
algernon                 crystal                  hcloud                   meson                    php                      tomcat
angular-cli              curl                     hyperscan                metricbeat               php@7.2                  topgrade
apache-opennlp           curl-openssl             inetutils                minimal-racket           phpunit                  typescript
aws-okta                 cython                   ipv6calc                 minio                    planck                   ucloud
awscli                   devd                     jenkins                  minio-mc                 prettier                 urbit
azure-cli                dhall-json               juju-wait                mkcert                   prometheus               v8
bartycrouch              direnv                   kakoune                  mkl-dnn                  pulumi                   vert.x
bazel                    elasticsearch            kibana                   mogenerator              pyside                   vim
bettercap                elixir                   kube-aws                 mosquitto                rabbitmq                 vips
binutils                 enet                     kubeless                 mpd                      rebar3                   w3m
bison                    eslint                   kustomize                mpv                      repo                     wtf
bit                      ethereum                 libosinfo                mutt                     rom-tools                xsimd
bluetoothconnector       exploitdb                libphonenumber           nats-streaming-server    rtv                      youtube-dl
carthage                 ffmpeg                   librealsense             ncdu                     safe                     zsh
cassandra@2.1            firebase-cli             libu2f-host              ngircd                   sbcl
cassandra@2.2            fn                       libvirt                  nim                      sccache
cglm                     fonttools                libvpx                   node-build               ship
==> Renamed Formulae
resin-cli -> balena-cli

==> Caveats
To install and/or use osxfuse you may need to enable their kernel extension in

  System Preferences → Security & Privacy → General

For more information refer to vendor documentation or the Apple Technical Note:

  https://developer.apple.com/library/content/technotes/tn2459/_index.html

You must reboot for the installation of osxfuse to take effect.

==> Satisfying dependencies
==> Downloading https://github.com/osxfuse/osxfuse/releases/download/osxfuse-3.8.3/osxfuse-3.8.3.dmg
==> Downloading from https://github-production-release-asset-2e65be.s3.amazonaws.com/1867347/769c1f00-0290-11e9-8f2b-55d20928e57f?X-Amz-Algorithm=AWS4-
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'osxfuse'.
==> Installing Cask osxfuse
==> Running installer for osxfuse; your password may be necessary.
==> Package installers may write to any location; options such as --appdir are ignored.
Password:
installer: Package name is FUSE for macOS
installer: choices changes file '/var/folders/rg/m2zzqr3d5lx1k9t5w183m4bw0000gp/T/choices20190208-11059-1mei4gz.xml' applied
installer: Upgrading at base path /
installer: The upgrade was successful.
==> Changing ownership of paths required by osxfuse; your password may be necessary
🍺  osxfuse was successfully installed!
(django_projects) bash-3.2$ brew install datawire/blackbird/telepresence
==> Tapping datawire/blackbird
Cloning into '/usr/local/Homebrew/Library/Taps/datawire/homebrew-blackbird'...
remote: Enumerating objects: 7, done.
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 7 (delta 0), reused 5 (delta 0), pack-reused 0
Unpacking objects: 100% (7/7), done.
Tapped 1 formula (34 files, 42.3KB).
==> Installing telepresence from datawire/blackbird
Warning: Your Xcode (10.0) is outdated.
Please update to Xcode 10.1 (or delete it).
Xcode can be updated from the App Store.

==> Installing dependencies for datawire/blackbird/telepresence: torsocks, glib and sshfs
==> Installing datawire/blackbird/telepresence dependency: torsocks
==> Downloading https://homebrew.bintray.com/bottles/torsocks-2.2.0.mojave.bottle.tar.gz
######################################################################## 100.0%
==> Pouring torsocks-2.2.0.mojave.bottle.tar.gz
🍺  /usr/local/Cellar/torsocks/2.2.0: 17 files, 268.1KB
==> Installing datawire/blackbird/telepresence dependency: glib
==> Downloading https://homebrew.bintray.com/bottles/glib-2.58.3.mojave.bottle.tar.gz
######################################################################## 100.0%
==> Pouring glib-2.58.3.mojave.bottle.tar.gz
🍺  /usr/local/Cellar/glib/2.58.3: 435 files, 18.5MB
==> Installing datawire/blackbird/telepresence dependency: sshfs
==> Downloading https://homebrew.bintray.com/bottles/sshfs-2.10.mojave.bottle.tar.gz
######################################################################## 100.0%
==> Pouring sshfs-2.10.mojave.bottle.tar.gz
🍺  /usr/local/Cellar/sshfs/2.10: 6 files, 94.5KB
==> Installing datawire/blackbird/telepresence
==> Downloading https://s3.amazonaws.com/datawire-static-files/telepresence/telepresence-0.97.tar.gz
######################################################################## 100.0%
🍺  /usr/local/Cellar/telepresence/0.97: 4 files, 609.4KB, built in 6 seconds
==> `brew cleanup` has not been run in 30 days, running now...
Removing: /usr/local/Cellar/consul/1.3.0... (8 files, 93.4MB)
Removing: /Users/rlee/Library/Caches/Homebrew/consul--1.3.0.mojave.bottle.tar.gz... (32.5MB)
Removing: /usr/local/Cellar/gdbm/1.18... (20 files, 588.7KB)
Removing: /Users/rlee/Library/Caches/Homebrew/gdbm--1.18.mojave.bottle.tar.gz... (196.1KB)
Removing: /Users/rlee/Library/Caches/Homebrew/gdbm--1.18.1.mojave.bottle.tar.gz... (197KB)
Removing: /usr/local/Cellar/gettext/0.18.3.2... (1,840 files, 13.4MB)
Removing: /Users/rlee/Library/Caches/Homebrew/git--2.19.1.mojave.bottle.tar.gz... (15.1MB)
Removing: /usr/local/Cellar/glib/2.52.0... (430 files, 22.5MB)
Removing: /usr/local/Cellar/go/1.2.1... (3,983 files, 105MB)
Removing: /Users/rlee/Library/Caches/Homebrew/jasper--2.0.14.mojave.bottle.tar.gz... (528.7KB)
Removing: /usr/local/Cellar/jpeg/8d... (19 files, 731.3KB)
Removing: /Users/rlee/Library/Caches/Homebrew/kubernetes-cli--1.13.2.mojave.bottle.tar.gz... (12.1MB)
Removing: /Users/rlee/Library/Caches/Homebrew/libidn2--2.0.5.mojave.bottle.tar.gz... (217KB)
Removing: /Users/rlee/Library/Caches/Homebrew/libpng--1.6.35.mojave.bottle.tar.gz... (444.6KB)
Removing: /Users/rlee/Library/Caches/Homebrew/libtiff--4.0.9_4.mojave.bottle.tar.gz... (1MB)
Removing: /usr/local/Cellar/little-cms2/2.7... (17 files, 1MB)
Removing: /Users/rlee/Library/Caches/Homebrew/openjpeg--2.3.0.mojave.bottle.tar.gz... (2MB)
Removing: /usr/local/Cellar/openssl/1.0.1f... (1,229 files, 10.6MB)
Removing: /usr/local/Cellar/openssl/1.0.1i... (1,230 files, 10.6MB)
Removing: /usr/local/Cellar/openssl/1.0.2c... (1,634 files, 12.2MB)
Removing: /usr/local/Cellar/openssl/1.0.2d_1... (1,638 files, 12MB)
Removing: /usr/local/Cellar/openssl/1.0.2g... (1,678 files, 12.0MB)
Removing: /usr/local/Cellar/openssl/1.0.2h_1... (1,691 files, 12MB)
Removing: /usr/local/Cellar/openssl/1.0.2p... (1,793 files, 12MB)
Removing: /Users/rlee/Library/Caches/Homebrew/openssl--1.0.2p.mojave.bottle.tar.gz... (3.7MB)
Removing: /usr/local/Cellar/pcre/8.37... (203 files, 5.4MB)
Removing: /usr/local/Cellar/pcre/8.38... (203 files, 5.4MB)
Removing: /usr/local/Cellar/pcre/8.40... (204 files, 5.4MB)
Removing: /usr/local/Cellar/pcre/8.41... (204 files, 5.3MB)
Removing: /usr/local/Cellar/pcre2/10.22... (199 files, 5.0MB)
Removing: /Users/rlee/Library/Caches/Homebrew/pipenv--2018.10.13.mojave.bottle.tar.gz... (8.3MB)
Removing: /usr/local/Cellar/pkg-config/0.29.1... (10 files, 627.2KB)
Removing: /usr/local/Cellar/python/3.7.0... (9,330 files, 160.1MB)
Removing: /usr/local/Cellar/python/3.7.1... (8,431 files, 117.7MB)
Removing: /Users/rlee/Library/Caches/Homebrew/python--pip--18.0.tar.gz... (1.2MB)
Removing: /Users/rlee/Library/Caches/Homebrew/python--3.7.1.tar.xz... (16.2MB)
Removing: /Users/rlee/Library/Caches/Homebrew/python--wheel--0.32.2.tar.gz... (17.2KB)
Removing: /Users/rlee/Library/Caches/Homebrew/python--wheel--0.32.0.tar.gz... (17.2KB)
Removing: /Users/rlee/Library/Caches/Homebrew/python--3.7.0.tar.xz... (16.1MB)
Removing: /Users/rlee/Library/Caches/Homebrew/python--setuptools--40.5.0.zip... (835.5KB)
Removing: /Users/rlee/Library/Caches/Homebrew/python--setuptools--40.4.3.zip... (834.8KB)
Removing: /usr/local/Cellar/python@2/2.7.15_1... (7,505 files, 122.3MB)
Removing: /Users/rlee/Library/Caches/Homebrew/python@2--setuptools--40.4.3.zip... (834.8KB)
Removing: /Users/rlee/Library/Caches/Homebrew/python@2--pip--18.0.tar.gz... (1.2MB)
Removing: /Users/rlee/Library/Caches/Homebrew/python@2--wheel--0.32.0.tar.gz... (17.2KB)
Removing: /usr/local/Cellar/readline/6.3.8... (46 files, 2MB)
Removing: /usr/local/Cellar/readline/7.0.5... (46 files, 1.5MB)
Removing: /Users/rlee/Library/Caches/Homebrew/readline--7.0.5.mojave.bottle.tar.gz... (497.6KB)
Removing: /usr/local/Cellar/redis/2.8.17... (10 files, 1.3MB)
Removing: /usr/local/Cellar/redis/3.0.2... (10 files, 864.8KB)
Removing: /Users/rlee/Library/Caches/Homebrew/rust--1.32.0.mojave.bottle.tar.gz... (222MB)
Removing: /Users/rlee/Library/Caches/Homebrew/sphinx-doc--1.8.1.mojave.bottle.tar.gz... (12.9MB)
Removing: /Users/rlee/Library/Caches/Homebrew/sphinx-doc--1.8.3_1.mojave.bottle.tar.gz... (14MB)
Removing: /usr/local/Cellar/sqlite/3.25.2... (11 files, 3.7MB)
Removing: /usr/local/Cellar/sqlite/3.25.3... (11 files, 3.7MB)
Removing: /Users/rlee/Library/Caches/Homebrew/sqlite--3.25.2.mojave.bottle.tar.gz... (1.8MB)
Removing: /Users/rlee/Library/Caches/Homebrew/sqlite--3.25.3.mojave.bottle.tar.gz... (1.8MB)
Removing: /Users/rlee/Library/Caches/Homebrew/webp--1.0.0.mojave.bottle.tar.gz... (846.6KB)
Removing: /usr/local/Cellar/wxmac/3.0.1... (811 files, 39.4MB)
Removing: /Users/rlee/Library/Logs/Homebrew/pkg-config... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/libtiff... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/libtool... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/wxmac... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/libidn2... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/pipenv... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/little-cms2... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/libpng... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/hugo... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/gdbm... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/libunistring... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/openjpeg... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/glib... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/readline... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/webp... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/ruby-build... (137B)
Removing: /Users/rlee/Library/Logs/Homebrew/sqlite... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/xz... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/erlang@19... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/fontconfig... (872B)
Removing: /Users/rlee/Library/Logs/Homebrew/consul... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/mercurial... (2 files, 125.2KB)
Removing: /Users/rlee/Library/Logs/Homebrew/sphinx-doc... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/watchman... (212B)
Removing: /Users/rlee/Library/Logs/Homebrew/pcre2... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/pcre... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/dos2unix... (2 files, 14.5KB)
Removing: /Users/rlee/Library/Logs/Homebrew/socat... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/node... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/jpeg... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/openssl... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/fish... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/jasper... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/git... (64B)
Removing: /Users/rlee/Library/Logs/Homebrew/telnet... (64B)
Pruned 4 symbolic links and 4 directories from /usr/local
```