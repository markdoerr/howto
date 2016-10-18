
# Linux Audio howto

## converting flac to mp3

for f in *.flac; do flac -cd "$f" | lame -b 320 - "${f%.*}".mp3; done
