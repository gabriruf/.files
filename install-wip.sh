#!/usr/bin/env bash

osname=$( cat /etc/os-release | sed 's/^[^=]*=//' | awk 'NR==2' ) # Retrieves the distribution id in order to know which distro is running the script
user=$(whoami)

echo "
###########################################
### RUFF'S DOTFILES INSTALLATION SCRIPT ###
###########################################
###       Select an option below        ###
###########################################
###                                     ###
### [1]: Install dotfiles               ###
### [2]: Revert changes                 ###
### [3]: Quit installer                 ###
###                                     ###
###########################################
"
echo -n "> "
read -r opt

case "$opt" in
    1)
        echo "Installing dotfiles"

        if [[ $(uname) == "Linux" ]]; then
            arch_linux() {
                echo "Please input your password to install the packages: " && sudo pacman -S --noconfirm --needed alacritty zsh zsh-completions tmux fastfetch hyprland waybar bemenu bemenu-wayland libnotify uwsm dunst pcmanfm neovim git curl wget rsync grim slurp pipewire wireplumber pipewire-pulse; echo "Required packages installed";
            }

            [[ $osname = "Arch Linux" ]]; arch_linux

            rm -rf ~/.files
            git clone https://github.com/gabriruf/.files ~/.files

            # /home/.config
            if [[ -d $HOME/.config ]]; then
                [[ -d $HOME/.config ]] && cp -r $HOME/.config $HOME/.config-backup && echo -e "Creating .config backup folder\n"
                cp -r $HOME/.files/.config/* $HOME/.config/
            else
                echo "\$HOME/.config directory not found, creating it..." && mkdir $HOME/.config && echo -e ".config folder created\n"
                cp -r $HOME/.files/.config/* $HOME/.config/
            fi

            # /home/.local/bin
            if [[ -d $HOME/.local ]]; then
                [[ -d $HOME/.local/bin ]] && cp -r $HOME/.local/bin $HOME/.local/bin-backup && echo -e ".local/bin backup folder created\n"
                cp $HOME/.files/.local/bin/* $HOME/.local/bin/ 
            else
                echo "\$HOME/.local directory not found, creating it and '.local/bin' subfolder..." && mkdir $HOME/.local/bin -p && echo -e ".local/bin folder created\n"
                cp $HOME/.files/.local/bin/* $HOME/.local/bin/
            fi

             # /home/.local/share/fonts
             if [[ -d $HOME/.local ]]; then
                 [[ -d $HOME/.local/share ]] || mkdir -p ~/.local/share/fonts && cp -r $HOME/.local/share/fonts $HOME/.local/share/fonts-backup && echo -e ".local/share/fonts backup created\n"
                 cp -r $HOME/.files/.local/share/fonts/* $HOME/.local/share/fonts/ 
                 fc-cache -fv
             else
                 echo "\$HOME/.local directory not found, creating it and '.local/share/fonts' subfolder..." && mkdir $HOME/.local/share/fonts -p && echo -e ".local/share/fonts folder created\n"
                 cp $HOME/.files/.local/share/fonts/* $HOME/.local/share/fonts/
                 fc-cache -fv
             fi

            # /home/Pictures/Wallpapers
            if [[ -d $HOME/Pictures ]]; then
                [[ -d $HOME/Pictures/Wallpapers ]] && cp -r $HOME/Pictures/Wallpapers $HOME/Pictures/Wallpapers-backup && echo -e "Pictures/Wallpapers backup created\n"
                cp $HOME/.files/Pictures/Wallpapers/* $HOME/Pictures/Wallpapers/ 
            else
                echo "\$HOME/Pictures directory not found, creating it and 'Pictures/Wallpapers' subfolder..." && mkdir $HOME/Pictures/Wallpapers -p && echo -e "Pictures/Wallpapers folder created\n"
                cp $HOME/.files/Pictures/Wallpapers/* $HOME/Pictures/Wallpapers/ 
            fi

            echo -e "Setting your zsh default config path to ~/.config/zsh"

            if [[ -e /etc/zsh/zshenv ]]; then
                echo "/etc/zsh/zshenv exists, creating backup"
                sudo cp /etc/zsh/zshenv /etc/zsh/zshenv-backup
                sudo bash -c "echo 'export ZDOTDIR="/home/$user/.config/zsh"' | tee /etc/zsh/zshenv"
            else
                sudo bash -c "echo 'export ZDOTDIR="/home/$user/.config/zsh"' | tee /etc/zsh/zshenv"
            fi

            sudo chsh -s /bin/zsh $user

            echo "You're all set, log off, log in again and then run 'dbus-run-session Hyprland'"

        else
            echo "Sorry, you're not running Linux"
        fi;;
    2)
        echo "Reverting changes"
        if [[ $(uname) == "Linux" ]]; then
            arch_linux() {
                echo "Please input your password to install the packages: " && sudo pacman -Rs --noconfirm alacritty zsh zsh-completions tmux fastfetch hyprland waybar bemenu pcmanfm neovim git curl wget rsync grim slurp pipewire wireplumber pipewire-pulse; echo "Packages removed";
            }

            [[ $osname = "Arch Linux" ]] && arch_linux

            # /home/.config
            if [[ -d $HOME/.config-backup ]]; then
                echo "Restoring previous '.config' folder"
                cp -r $HOME/.config-backup $HOME/.config
            else
                echo "backup folder not found"
            fi

            # /home/.local/bin
            if [[ -d $HOME/.local/bin-backup ]]; then
                echo "Restoring previous '.local/bin' folder"
                cp -r $HOME/.local/bin-backup $HOME/.local/bin/ 
            else
                echo "backup folder not found"
            fi

             # /home/.local/share/fonts
             if [[ -d $HOME/.local/share/fonts-backup ]]; then
                 echo "Restoring previous local fonts folder"
                 cp -r $HOME/.local/share/fonts-backup $HOME/.local/share/fonts/ 
             else
                 echo "backup folder not found"
             fi

            # /home/Pictures/Wallpapers
            if [[ -d $HOME/Pictures ]]; then
                echo "Restoring previous 'Wallpapers' folder"
                cp -r $HOME/Pictures/Wallpapers-backup $HOME/Pictures/Wallpapers/ 
            else
                echo "backup folder not found"
                rm -rf $HOME/Pictures/Wallpapers
            fi

            # /etc/zsh/zshenv
            if [[ -e /etc/zsh/zshenv-backup ]]; then
                echo "Restoring /etc/zsh/zshenv backup"
                sudo cp /etc/zsh/zshenv-backup /etc/zsh/zshenv
            else
                echo "backup file not found"
                sudo rm /etc/zsh/zshenv
            fi
           
            sudo chsh -s /bin/bash $user

            echo "All changes made by the installer previously have been reverted."

        else
            echo "Sorry, you're not running Linux"
        fi;;

    3)
        echo "Quitting installer..."
        exit 1;;
    *)
        echo "Options: 1-install, 2-revert, 3-quit";;
esac
