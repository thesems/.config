# Instalation of packages
# General
pacman -S ttf-jetbrains-mono-nerd noto-fonts-cjk noto-fonts-emoji noto-fonts
# terminal
pacman -S kitty --noconfirm
# i3 with accompanying software
pacman -S i3-wm i3blocks i3status i3lock rofi dunst ttf-font-awesome --noconfirm
# nvim
sudo pacman -S nvim ripgrep fd --noconfirm

# Copy configuration
# i3
cp -r ./i3 ~/.config/
cp -r ./i3blocks ~/.config/
# Neovim
cp -r ./nvim ~/.config/
# Kitty
cp -r ./kitty/kitty.conf ~/.config/kitty/
# Fish
cp -r ./fish/config.fish ~/.config/fish/
