# Packaging Benchmarks' Input Data

This directory at AgResearch contains many symlinks.  When a tarball is made,
it should be created like this:

```
$ cd $INPUT_DATA_ROOT_DIR
$ tar czhf ../data.tgz *
```

The `h` option follows symlinks, since the symlink itself is quite useless.
