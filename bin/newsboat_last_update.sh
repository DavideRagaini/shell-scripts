#!/usr/bin/env sh

notify-send "Newsboat last database update:" "$(date -r ~/.local/share/newsboat/cache.db +'%T')"
