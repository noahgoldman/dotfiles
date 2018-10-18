# Define common aliases for GNU coreutils that will be the right binaries
# for each platform.
if [[ `uname` == 'Darwin' ]]
then
    SED_BIN=gsed
else
    SED_BIN=sed
fi
