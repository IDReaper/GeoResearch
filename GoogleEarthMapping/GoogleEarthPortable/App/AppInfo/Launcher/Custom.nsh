${SegmentFile}
!include "C:\Documents and Settings\pcpl\Desktop\GoogleEarthPortable\Other\Source\ReadINIStrWithDefault.nsh"
${SegmentPreExec}
${ReadINIStrWithDefault} "$0" "$EXEDIR\GoogleEarthPortable.ini" "GoogleEarthPortable" "EnableCache" "false"

${If} $0 == false
		${registry::Write} "HKEY_CURRENT_USER\Software\Google\Google Earth Plus" "CachePath" "$TEMP\GoogleEarthPortableTemp" "REG_SZ" $0
	${Else}
		CreateDirectory $EXEDIR\Data\Cache
		${registry::Write} "HKEY_CURRENT_USER\Software\Google\Google Earth Plus" "CachePath" "$EXEDIR\Data\Cache" "REG_SZ" $0
${EndIf}

CreateDirectory $EXEDIR\Data\KML
${registry::Write} "HKEY_CURRENT_USER\Software\Google\Google Earth Plus" "KMLPath" "$EXEDIR\Data\KML" "REG_SZ" $0

!macroend