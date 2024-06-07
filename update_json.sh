#!/bin/bash

tmp=$(mktemp)
curl -sI https://frippery.org/files/busybox/SHA256SUM | grep Last-Modified > $tmp

# diff コマンドを実行し、結果に応じて処理を分岐
if diff last.txt $tmp > /dev/null; then
	echo "No differences found."
else
	echo "Differences found."

	sum=$(curl https://frippery.org/files/busybox/SHA256SUM)
	ver=$(echo "$sum" | grep "$(echo "$sum" | grep -v "busybox-w" | head -n 1 | awk '{print $1}')" | grep busybox- | awk '{print $2}' | sed 's/[^-]*-[^-]*-//; s/\.exe//')
	files=$(echo "$sum" | awk '{print $2}' | grep -v "busybox-w")

	for bin in $files; do
		echo "{}" \
			| jq --arg k "version" --arg v "$ver" '. + {($k): $v}' \
			| jq --arg k "url" --arg v "https://frippery.org/files/busybox/$bin" '. + {($k): $v}' \
			| jq --arg k "bin" --arg v "$bin" '. + {($k): $v}' \
			> $(echo $bin | sed 's/\.exe//').json
	done

	mv $tmp last.txt

	git add last.txt *.json
	git commit -m "$ver"
fi

