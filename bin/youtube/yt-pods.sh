#!/usr/bin/env bash

date
# parallel --progress \
#         'yt-dlp \
#         --extract-audio \
#         --add-metadata \
#         --paths "/media/media/podcasts/raw" \
#         --audio-quality 0 \
#         --output "%(uploader)s/%(playlist)s/[%(upload_date>%Y-%m-%d)s] %(playlist_index)s %(title)s.%(ext)s" \
#         --download-archive "/media/media/podcasts/archive.txt" \
#         --playlist-end=50' \
#         :::: "$HOME/pods/test.txt"
#         # --audio-format "mp3" \

root_dir="/media/media/podcasts"
set -x
find "$root_dir/raw" -mindepth 2 -type d -not -path "*/speedup/*" | while read dir; do
        pushd "$dir" || exit
        mkdir -p speedup
        parallel -j 3 ffmpeg -i {} -filter 'atempo=1.25' speedup/{} ::: *.mp3
        pushd speedup || exit
        parallel -j 3 ffmpeg-normalize {} -v --progress --auto-lower-loudness-target -c:a libmp3lame -ext mp3 ::: *.mp3
        popd || exit
        popd || exit
        name="$(echo "$dir" | cut -d'/' -f6-)"
        mkdir -p "$root_dir/ready"
        mv "$dir/speedup/normalized" "$root_dir/ready/$name"
        mv "$dir" "$root_dir/archive/"
done
        # mkdir -p "$dir/speedup" && parallel ffmpeg -i {} -filter 'atempo=1.25' "$dir"/speedup/{} ::: * && cd speedup && parallel ffmpeg-normalize {} -v --progress --auto-lower-loudness-target -ext mp3 ::: "$dir/*.mp3"
        # parallel ffmpeg-normalize {} -v --progress --auto-lower-loudness-target -ext mp3 ::: "$dir/*.mp3"; done
        # parallel ffmpeg -i {} -filter 'atempo=1.25' ::: "$dir/*.m4a"
        # parallel ffmpeg -i {} -filter 'atempo=1.25' ::: "$dir/*.mp3"
        # echo "$dir"
        # ls "$dir" | wc -l
date




#         --output "latest/[%(upload_date>%Y-%m-%d)s] %(playlist)s: %(title)s.%(ext)s" \
#         --playlist-end=30 \
#         --match-filter "duration>1800" \
#         --match-filter "upload_date > 20250101" \
#         ::: "$latest"
