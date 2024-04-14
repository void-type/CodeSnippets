# Windows Snippets

Wipe and format disk. /p:X does X passes of random data then zeros. /p:0 is just zeros. Use /Q instead to quick format with no cleaning.
`format e: /V:MY_LABEL /FS:NTFS /P:1`

Make a folder hard link in Windows /J or can make a file hard link /H
Useful moving plex downloads
`mklink /J "D:\Plex\Sync" "$env:LOCALAPPDATA\Plex\Plex Media Server\Sync"`

Check for possibly failing drives
`wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus`

SFC and DISM

```pwsh
Dism /Online /Cleanup-Image /RestoreHealth; sfc /scannow
```
