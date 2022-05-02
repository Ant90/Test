#!/usr/bin/env sh


echo "Downloading and setting up stack" 
curl -sSL https://get.haskellstack.org | sh

echo "Installing dependencies" 
sudo zypper -n in zsh neovim git \
    gcc make libffi-devel zlib-devel gmp-devel \
    libX11-devel libXft-devel libXinerama-devel libXrandr-devel libXss-devel

echo "Creating ~/.local/bin and adding it to PATH"
mkdir ~/.local/bin

echo "adding $HOME/.local/bin to PATH"
PATH="$HOME/.local/bin:$PATH"
echo $PATH

echo "Creating ~/.config/xmonad/ and writing a basic xmonad.hs"
mkdir -p ~/.config/xmonad
echo "import XMonad" >> ~/.config/xmonad/xmonad.hs
echo "" >> ~/.config/xmonad/xmonad.hs
echo "main = xmonad def" >> ~/.config/xmonad/xmonad.hs
echo "Cloning the xmonad  and the xmonad-contrib repos"
git clone https://github.com/xmonad/xmonad ~/.config/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib ~/.config/xmonad/xmonad-contrib

echo "Linking ~/.local/bin/xmonad to /usr/bin/xmonad"
sudo ln -s ~/.local/bin/xmonad /usr/bin/
echo "Creating xsessions entry"
echo "[Desktop Entry]" >> ~/xmonad.desktop
echo "Name = XMonad" >> ~/xmonad.desktop
echo "Exec = xmonad" >> ~/xmonad.desktop
echo "Type = Xsession" >> ~/xmonad.desktop
sudo mv ~/xmonad.desktop /usr/share/xsessions/



stack setup
echo "Moving into ~/.config/xmonad/ and initiating stack"
cd ~/.config/xmonad
stack init
echo "Installing everything"
stack install

echo "Done"







