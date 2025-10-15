# Useful Windows utilities

Good place to find more is 
- the [Microsoft Store Community Awards page](https://blogs.windows.com/windowsdeveloper/2022/05/27/announcing-the-microsoft-store-app-awards-winners/#:~:text=open%20platform%20category)
- [Scott Hanselman's blog](https://www.hanselman.com/blog/) and [Scott Hanselman's Ultimate Tools List](https://www.hanselman.com/blog/scott-hanselmans-2021-ultimate-developer-and-power-users-tool-list-for-windows)
- 

## [Everything](https://www.voidtools.com/downloads/)

Free useful search utility. Can be integrated into toolbar with [EverythingToolbar](https://github.com/srwi/EverythingToolbar)

### Remote GoogleDrive folders
Just add the remote drives as folders in Tools -> Options -> Folders and scan them. 

## [EarTrumpet](https://github.com/File-New-Project/EarTrumpet)

Free and open source tool that's a massive improvement on sound control settings in Win10. Unlike the existing settings, EarTrumpet enables easy switching of devices and per-app volume control from clean and accessible GUI. 

### [ZoomIt](https://learn.microsoft.com/en-us/sysinternals/downloads/zoomit?WT.mc_id=-blog-scottha)

Windows utility for live-annotating the screen using hotkeys only.

## [WinMerge](https://winmerge.org/)

Useful difftool. A distinguishing feature is that it can do multi-threaded folder diffing, which is useful for large projects.

## [TreeSize Free]()
Useful for finding large files and folders on the disk.

## Windows command line

### Regex delete files

From [SO](https://stackoverflow.com/a/23768332)

```cmd
// Test with echo
Get-ChildItem $Path -Recurse | Where{$_.Name -Match "<RegEx Pattern>"} 

// Run recursively
Get-ChildItem $Path -Recurse | Where{$_.Name -Match "<RegEx Pattern>"} | Remove-Item -Recurse
```