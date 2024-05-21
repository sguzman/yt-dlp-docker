#!/usr/bin/fish

while true; do
  cat urls.txt | while read msg
    echo start $msg
    yt-dlp --verbose -J "https://www.youtube.com/@$msg" > $msg.json;

    and cat $msg.json | jq --sort-keys '.' > $msg.pretty.json
    and rm $msg.json
    and zpaq add json.zpaq $msg.pretty.json -threads 16
    echo done $msg
    rm $msg.pretty.json
  end
end

