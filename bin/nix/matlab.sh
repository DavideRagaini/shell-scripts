#!/usr/bin/env sh

DIR="$HOME/sources/nix-matlab"
LAST_UPDATE="$(date +%s -r "$DIR"/flake.lock)"
[ "$((LAST_UPDATE + 604800))" -le "$(date +%s)" ] &&
    git -C "$DIR" pull
# nix run -v -run > ~/matlab.log
# nix-shell "$DIR"/shell.nix --run "$(printf "%s" "$(nix-build)/bin/matlab -desktop -nosplash -sd $HOME/uni/Tirocinio/Appunti/Matlab -logfile=$HOME/MATLAB/LogFiles/matlab.log -nosoftwareopengl")"

case "$1" in
    'shell')
        nix-shell "$DIR"/shell.nix --run "$(printf "%s" "$(nix-build)/bin/matlab  -r 's = settings;s.matlab.desktop.DisplayScaleFactor.PersonalValue=$2;quit' -desktop -nosplash -sd $HOME/uni/Tirocinio/Appunti/Matlab -logfile=$HOME/MATLAB/LogFiles/matlab.log -nosoftwareopengl")"
        ;;
    '-desktop' | 'run' | *)
        cd "$DIR" &&
            nix run -v >~/matlab.log
        ;;
esac
# case "$1" in
#     broken) nix-shell ~/sources/nix-matlab/shell.nix --run "$(printf "%s" "$(nix-build)/bin/matlab -desktop -nosplash -sd $HOME/Uni/Tirocinio/Appunti/Matlab -logfile=$HOME/MATLAB/LogFiles/matlab.log -nosoftwareopengl")" ;;
#     *) cd ~/sources/nix-matlab &&
#              git pull &&
#              nix run -v ;;
# esac
notify-send "Matlab terminated"
