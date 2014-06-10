phototchouk
===========

Preparing pictures to be uploaded to Phototchouk.com and to be stored in the archive hard drive.

##Usage
`$ ./phototchouk.sh filename`
To use the current directory name as filename base:
`$ ./phototchouk.sh "$(printf '%q\n' "${PWD##*/}")"`
