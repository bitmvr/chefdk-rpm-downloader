#!/usr/bin/env bash

function chefDK::latestRelease() {
	local url="https://downloads.chef.io/chefdk/stable"
	echo $(curl -s $url | grep -o "<h1 class=\"product-heading\">.*</h1>" | grep -o -e "\d\.\d\.\d")
}
	
download_page="https://packages.chef.io/files/stable/chefdk/$(chefDK::latestRelease)/el/7/"

function chefDK::packageName() {
	echo $(curl -s "$download_page" | grep -o -e ">chefdk-.*\.rpm" | tr -d '>' | head -1)
}

function chefDK::download() {
	if curl -sO "${download_page}/$(chefDK::packageName)"; then
		return 0
	else
		return 1
	fi
}

download_dir="$HOME/Downloads"

mkdir -p $download_dir && cd $download_dir || exit
echo "Prepared Download Directiory : $HOME/Downloads"

echo "Chef Download: Started"
if chefDK::download; then
	echo "Chef Download: Complete"
fi
