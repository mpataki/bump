#! /usr/bin/env bash

show_usage() {
  echo "Usage:"
  printf "\t./bump {major|minor|patch}"
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
    ;;
  minor)
    ((minor++))
    ;;
  patch)
    ((patch++))
    ;;
  *)
    show_usage
    exit 1
    ;;
esac

echo "$major.$minor.$patch" > $version_file
