# Science Data Tarballs

The science data for the benchmarks lives in the directory pointed to by
$SCIENCE_DATA_ROOTDIR, which is set in science/science-benchmarks.env

This directory at AgResearch contains many symlinks.  When a tarball is made,
it should be created like this:

```
$ cd $SCIENCE_DATA_ROOTDIR
$ tar czhf ../data.tgz *
```

The `h` option follows symlinks, since the symlink itself is quite useless.
