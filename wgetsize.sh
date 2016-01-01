echo "Crawling $1"
size=$(($(wget --reject=*.html* --spider --timeout=3 --no-check-certificate -r -l 0 -np $1 2>&1 | grep 'Length' | grep -v 'unspecified' | awk '{print $2}' | xargs echo | tr ' ' '+')))

echo -n "Estimated size: "
if [ $size -ge 1073741824 ]
then
	echo $(bc <<< "scale=2;$size/1024/1024/1024") GB
elif [ $size -ge 1048576 ]
then
	echo $(bc <<< "scale=2;$size/1024/1024") MB
elif [ $size -ge 1024 ]
then
	echo $(bc <<< "scale=2;$size/1024") KB
else
	echo $((size)) B
fi
