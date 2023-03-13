@echo off & setlocal enableDelayedExpansion

set "revisionRequired=3.29.2"
set  "import(=(set "\i=?" & ren "%~nx0" -t.bat & ren "?.bat" "%~nx0""
set ")=ren "%~nx0" "^^!\i^^!.bat" & ren -t.bat "%~nx0")" & set "self=%~nx0"
set "failedLibrary=ren -t.bat "%~nx0" ^&echo  Missing Library. Required Revision:%revisionRequired% ^& timeout /t 3 ^& exit"
(2>nul %import(:?=Library% && ( call :revision ) || ( %failedLibrary% ))
	call :StdLib 100 100
	call :ExtLib
	call :math
	call :misc
	call :shapes
	call :algorithmicConditions
	call :turtleFunctions
	call :colorRange
	call :macros
	rem etc...
%)%  && ((title CHANGE ME) & goto :setup)
:setup
rem PLEASE NOTE: You do NOT have to call all of the functions above, you can call whichever ones you need to keep the variable environment low
rem YOUR CODE GOES HERE

pause 
