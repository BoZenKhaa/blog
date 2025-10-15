
## Issues

To kill running WSL when other kill commands fail, e.g. when vmemm is full, run following command in PowerShell:
```PowerShell
taskkill -IM "wslservice.exe" /F
```

There is an ongoing [issue](https://github.com/microsoft/WSL/issues/6982) associated with this.
