# Instalation of packages
# General
pacman -S ttf-jetbrains-mono-nerd noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-font-awesome

# terminal, shell
pacman -S kitty fish --noconfirm

# fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# TODO: fisher: nvm

# i3
pacman -S i3-wm i3blocks i3status i3lock rofi dunst diodon --noconfirm

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
