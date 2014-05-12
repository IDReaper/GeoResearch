!macro CustomCodePostInstall
RMDir /r "$INSTDIR\App\bin\LocalAppData"
delete "$INSTDIR\App\bin\*.ini"
delete "$INSTDIR\App\bin\*.mst"
delete "$INSTDIR\App\bin\*.msi"
delete "$INSTDIR\App\bin\GoogleEarth.exe"
RMDir /r "$INSTDIR\App\bin\program files\Google\Google Earth\plugin"
rename "$INSTDIR\App\bin\program files" "$INSTDIR\App\bin\main"
rename "$INSTDIR\App\bin" "$INSTDIR\App\GE"
Clearerrors
!macroend