#! /usr/bin/env bash

show_usage() {
  echo "Usage:"
  printf "\t./bump {major|minor|patch} [version_file_name]\n\n"
  printf " - version_file_name default = 'VERION'\n"
  printf " - version file ex:\n"
  printf " \t0.0.0\n"
}

what_to_bump=$1
version_file=$2

if [ -z $version_file ]; then
  version_file=VERSION
fi

read major minor patch <<< $(cat $version_file | tr '.' ' ')

if [ $? -ne 0 ]; then
  show_usage
  exit $1
fi

case $what_to_bump in
  major)
    ((major++))
    minor=0
    patch=0
    ;;
  minor)
    ((minor++))
    patch=0
    ;;
  patch)
    ((patch++))
    ;;
  *)
    show_usage
    exit 1
    ;;
esac

echo "$what_to_bump bump"
echo "$major.$minor.$patch" > $version_file
