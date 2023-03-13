@echo off & setlocal enableDelayedExpansion

set "revisionRequired=3.29.1"
set  "openLib=(ren "%~nx0" temp.bat & ren "Library.bat" "%~nx0""
set "closeLib=ren "%~nx0" "Library.bat" & ren temp.bat "%~nx0")" & set "self=%~nx0"
echo.&echo  Please do NOT close %~n0 while Library is loading...&echo.
(2>nul %openLib% && ( call :revision ) || ( ren temp.bat "%~nx0" &echo  Missing Library. Required Revision:%revisionRequired% & timeout /t 3 & exit))
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
%closeLib%  && ( (title CHANGE ME) & cls & goto :setup)
:setup
rem PLEASE NOTE: You do NOT have to call all of the functions above, you can call whichever ones you need to keep the variable environment low
rem YOUR CODE GOES HERE

pause 
