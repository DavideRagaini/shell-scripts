#!/usr/bin/env sh
case "$1" in
    broken) nix-shell ~/sources/nix-matlab/shell.nix --run "$(printf "%s" "$(nix-build)/bin/matlab -desktop -nosplash -sd $HOME/Uni/Tirocinio/Appunti/Matlab -logfile=$HOME/MATLAB/LogFiles/matlab.log -nosoftwareopengl")" ;;
    *) cd ~/sources/nix-matlab &&
             git pull &&
             nix run -v ;;
esac
notify-send "Matlab terminated"
