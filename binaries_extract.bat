@echo off

setlocal EnableDelayedExpansion

set "componentsPath=%~dp0ext_components"

if NOT exist %componentsPath% (
	powershell Invoke-WebRequest https://github.com/Danily07/Translumo/releases/download/v.0.8.5/_Components-v.0.8.0.zip -OutFile components.zip
	powershell Expand-Archive "%~dp0components.zip" -DestinationPath !componentsPath!
	del "%~dp0components.zip"
)

set "targetPaths[0]=%1python\"
set "targetPaths[1]=%1models\easyocr\"
set "targetPaths[2]=%1models\tessdata\"
set "targetPaths[3]=%1models\prediction\"

set "inputBinariesPaths[0]=%componentsPath%\python"
set "inputBinariesPaths[1]=%componentsPath%\models\easyocr"
set "inputBinariesPaths[2]=%componentsPath%\models\tesseract"
set "inputBinariesPaths[3]=%componentsPath%\models\prediction"

for %%i in (0,1,2,3) do (
	if NOT exist !targetPaths[%%i]! (
		xcopy /s !inputBinariesPaths[%%i]! !targetPaths[%%i]!
	)
)