#!/bin/bash
#
# This script installs Packer on your machine (http://www.packer.io/downloads.html)
#
# Run this script:
# source ./install_packer.sh



# environment variables: set here your preferences
tmp_dir='/tmp' # default '/tmp"
system='linux' # default 'linux'
architecture='amd64' # either 'amd64' or '386'
parent_dir='/home/damko/applications' # whatever you like
packer_dir='packer' # default 'packer'
packer_version='0.7.2' # default '0.5.2' @2014-04-20
bashrc_file='/home/damko/.bashrc_custom' # default $HOME'/.bashrc'




# checks if the programs required by this script are installed
command -v unzip > /dev/null 2>&1 || { echo -e "Please install unzip: \nsudo apt-get install unzip"; exit 1; }
command -v wget > /dev/null 2>&1 || { echo -e "Please install wget: \nsudo apt-get install wget"; exit 1; }

# checks if $parent_dir exist
if [ ! -d "$parent_dir" ]; then
	echo ""
	echo "The directory $parent_dir does not exist. Please check the variables settings"
	exit 1
fi

# checks if $bashrc_file is a file
if [ ! -f "$bashrc_file" ]; then
	echo "$bashrc_file is not a file"
	exit 1
fi

# generated variables
packer_version_dir="$parent_dir/$packer_dir/$packer_version" #this is where the current version of the package will be unzipped
packer_home="$parent_dir/$packer_dir/current" #alias for $packer_version_dir
packer_package="packer_$packer_version"_"$system"_"$architecture".zip
packer_package_url="https://dl.bintray.com/mitchellh/packer/$packer_package"




echo ""
echo "Creating the skeleton ..."
mkdir -p "$packer_version_dir" &> /dev/null

# removes and creates the alias for $packer_version_dir
rm "$packer_home" &> /dev/null
ln -s "$packer_version_dir" "$packer_home"




# downloads the packegs and unzips it in $packer_home
echo ""
echo "Downloading packer binaries ..."
cd $tmp_dir
wget -c "$packer_package_url" && cd "$packer_home" && unzip -o "$tmp_dir/$packer_package" && chmod +x packer*




# updates $PATH
echo ""
echo "Configuring environment ..."
echo "$PATH" | grep -q "$packer_home"
if [ $? -ne 0 ]; then
	echo '' >> "$bashrc_file"
	echo '# add Packer binaries to PATH' >> "$bashrc_file"
	echo 'echo "$PATH" | grep -q "'"$packer_home"'"' >> "$bashrc_file"
	echo 'if [[ $? != 0 ]]; then' >> "$bashrc_file"
	echo 'export PATH="$PATH":'"$packer_home" >> "$bashrc_file"
	echo 'fi' >> "$bashrc_file"
fi
source "$bashrc_file"

# tests if packer is in PATH
command -v packer > /dev/null 2>&1 || { echo -e "packer binary can not be found. \nPlease check your $bashrc_file and reload the terminal"; exit 1; }

echo ""
echo "Packer has been installed"
echo ""
