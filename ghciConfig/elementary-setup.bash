#!/bin/bash

set -exu

# SublimeHaskell hints:
# ~/.config/sublime-text-2/Packages/SublimeHaskell
# cabal install --reinstall --enable-shared primitive
# http://stackoverflow.com/questions/23927744/where-is-libhsprimitive-0-5-3-0-so

if [ "$(id -u)" != "0" ]; then
	echo "This script must be run using sudo."
	exit 1
fi

echo "Updating system..."
apt-get -y -q update
apt-get -y -q dist-upgrade

echo "Installing ElementaryOS extras..."
apt-add-repository -y ppa:versable/elementary-update
apt-get -y -q update
apt-get -y -q install elementary-desktop elementary-tweaks
apt-get -y -q install elementary-dark-theme elementary-plastico-theme elementary-whit-e-theme elementary-harvey-theme
apt-get -y -q install elementary-elfaenza-icons elementary-nitrux-icons
apt-get -y -q install elementary-plank-themes
apt-get -y -q install wingpanel-slim indicator-synapse

echo "Installing git..."
add-apt-repository -y ppa:git-core/ppa
apt-get -y -q update
apt-get -y -q dist-upgrade
apt-get -y -q install git

echo "Installing browsers..."
apt-get -y -q install firefox chromium-browser
apt-get -y -q install flashplugin-installer

echo "Installing GHC..."
add-apt-repository -y ppa:hvr/ghc
apt-get -y -q update
apt-get -y -q install ghc-7.10.1 ghc-7.10.1-prof cabal-install-1.22 happy-1.19.4

echo "Installing Sublime Text 3..."
add-apt-repository -y ppa:webupd8team/sublime-text-3
apt-get -y -q update
apt-get -y -q install sublime-text
git clone https://github.com/jcpetruzza/SublimeHaskell.git ~/.config/sublime-text-3/Packages/SublimeHaskell
git checkout build-tools-with-sandbox ~/.config/sublime-text-3/Packages/SublimeHaskell
cd ~/.config/sublime-text-3/Packages/SublimeHaskell && git checkout build-tools-with-sandbox
cat <<"EOF" > .config/sublime-text-3/Packages/User/SublimeHaskell.sublime-settings
{
	"add_to_PATH":
	[
		"/home/stu/.cabal/bin",
		"/opt/cabal/1.22/bin",
		"/opt/ghc/7.10.1/bin/"
	]
}
EOF

echo "Installing other..."
add-apt-repository -y ppa:chris-lea/node.js
apt-get -y -q update
apt-get -y -q install pantheon-terminal dconf-tools nodejs fonts-inconsolata
apt-get -y -q install postgresql postgresql-contrib pgadmin3 zlib1g-dev python-gpgme g++
apt-get -y -q install postgresql-server-dev-all debootstrap build-essential libgloib2.0-dev
apt-get -y -q install lib32stdc++6 lib32z1 ruby1.9.1
apt-get -y -q remove ruby1.8
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
npm install -g nodemon yo bower grunt-cli gulp generator-webapp generator-express gulp bower
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

echo "Configuring desktop..."
fc-cache -fv
cat <<"EOF" > .config/plank/dock1/launchers/sublime-text-3.dockitem
[PlankItemsDockItemPreferences]
Launcher=file:///usr/share/applications/sublime-text-3.desktop
EOF
cat <<"EOF" > .config/plank/dock1/launchers/pgadmin3.dockitem
[PlankItemsDockItemPreferences]
Launcher=file:///usr/share/applications/pgadmin3.desktop
EOF
pkill plank && sed -i 's/DockItems=firefox.dockitem;;pantheon-terminal.dockitem;;pantheon-files.dockitem;;sublime-text-3.dockitem;;pgadmin3.dockitem;;switchboard.dockitem;;softwarecenter.dockitem;;update-manager.dockitem/g' .config/plank/dock1/settings
gsettings set org.gnome.desktop.interface ubuntu-overlay-scrollbars false

cat <<"EOF" > .profile
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

EOF

# cat <<"EOF" > /etc/environment
# PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/ghc/7.8.3/bin:/opt/cabal/1.20/bin:/opt/happy/1.19.4/bin"
# EOF

cat <<"EOF" > .'gconf/desktop/gnone/interface/%gconf.xml'
<?xml version="1.0"?>
<gconf>
	<entry name="monospace_font_name" mtime="1415630398" type="string">
		<stringvalue>Inconsolata Medium 10</stringvalue>
	</entry>
</gconf>
EOF

echo "Setting GRUB default choice to #2..."
sed -i 's/GRUB_DEFAULT=[0-9]*/GRUB_DEFAULT=3/g' /etc/default/grub
update-grub

echo "Cleaning up..."
apt-get -y -q autoremove
