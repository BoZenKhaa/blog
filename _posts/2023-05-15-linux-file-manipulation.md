# Manipulating files in Linux


## Useful snippets

Rename all files in a folder, recursively
```Bash
find /your/target/path/ -type f -exec rename 's/old_name/new_name/' '{}' \;
```

## Find command

Find specific files in subfolders and delete them
```Bash
find . -name \*my.log -type f -delete
```
Here:

- `-type f` selects files only, other options are `d` for directories and `l` for links. Selects evewrything without flag. 
- `-delete` deletes the files found
- `-name` select the file to find, can be a regex
- `-exec` executes a command on the found files, `{}` is a placeholder for the found file, `\;` is the end of the command. According to the man, you should use `execdir` to avoid security issues (`-exec` runs in current directory, `-execdir` in the directory of the found file).

To delete non-empty folders, [use](https://unix.stackexchange.com/a/249503/439089)
```Bash
find . -name someDir -type d -exec rm -rv {} \;
```
since `-delete` does not work for non-empty folders.

## Rename

Rename has following notable flags
```Bash
-n # show what will be done without doint it

```

### Issues installing
To install rename on Ubuntu:
```Bash
sudo apt install rename
```

If you get following error, do [following](https://stackoverflow.com/a/27724459/1400490):

```Bash
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```
then the locale is not configured correctly. Run
```Bash
sudo locale-gen
sudo dpkg-reconfigure locales
```
and set the locale to `en_US.UTF-8`.

Rename should work correctly now.

## Packaging, compression

Tar and zip are two common ways to package and compress files. Tar only packages files, zip also compresses them. You can combine tar with other compression tools, e.g. gzip.

7zip is a newer compression tool than zip, it achieves better compression rates (30-70% in practice). It's not as widely available. 

### Tar
`tar` is a command that creates single file from a folder. It does not compress the file, but can be used in conjunction with `gzip` to do so. Unlike zip, this is more efficient since it does not compress each file individually.

To create a zipped tar file from a folder:
```Bash 
tar czf name_of_archive_file.tar.gz name_of_directory_to_tar
```

The flags used are:
- `c` create an archive (as opposed to extract, `x`)
- `z` compress the archive with gzip
- `f` specify the name of the archive file

#### Tar and zip with progress bar

There is a [neat one-liner] for this:
```Bash
tar cf - /folder-with-big-files -P | pv -s $(du -sb /folder-with-big-files | awk '{print $1}') | gzip > big-files.tar.gz
```
But you need to install `pv` first. 