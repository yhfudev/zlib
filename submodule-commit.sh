#!/bin/sh

echo "update zlib submodules ..."
./submodule-update.sh

cd lib/libosporting
./submodule-commit.sh
cd -

echo "commit zlib submodules"
git add lib/libosporting
git commit -m "update submodules."
git push

