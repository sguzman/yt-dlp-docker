#!/usr/bin/fish
#
set -x fish_trace 1

while true; do
  cat urls.txt | while read msg
    echo start $msg
    yt-dlp --verbose -J "https://www.youtube.com/@$msg" > $msg.json;

    and cat $msg.json | jq --sort-keys '.' > $msg.pretty.json
    and rm $msg.json
    and zpaq add data/json.zpaq $msg.pretty.json -threads 16
    echo done $msg
    rm $msg.pretty.json
  end
end

