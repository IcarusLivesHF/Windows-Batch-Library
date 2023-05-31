rem PLEASE READ DOCUMENTATION IN MY GITHUB!
(call :buildSketch) & (exit) & rem Double click the library to build a new sketch.
:revision DON'T CALL
	set "revision=4.1.1"
	set "libraryError=False"
	for /f "tokens=4-6 delims=. " %%i in ('ver') do set "winVERSION=%%i.%%j" & set "winBuild=%%k"
	if "%revision%" neq "%~1" (
		echo.&echo  This Revision: %revision% of Library.bat is not supported in this script.
		echo.&echo  Revision: %~1 of Library.bat required to run this script.
		set "libraryError=True"
	)
	if "%winversion%" neq "10.0" (
		echo %~n0 is not supported on this version of Windows: %winVERSION%"
		set "libraryError=True"
	)
	if %winbuild% lss 10589 (
		echo %~n0 is not supported on this build of Windows: %winbuild%"
		set "libraryError=True"
	)
	if "%libraryError%" equ "True" (
		ren "%~nx0" "Library.bat"
		ren "-t.bat" "%self%"
		del /f /q "-t.bat"
		timeout /t 3 /nobreak & exit
	)
goto :eof
:StdLib /w:N /h:N /fs:N /title:"foobar" /debug /extlib /math /misc /shape /ac /cursor /cr:N /gfx /util
title Powered by: Windows Batch Library - Revision: %Revision%
REM echo Loading Windows Batch Library - Revision: %Revision%...[B[G[38;5;9mPlease do not exit at this time..[0m

set "defaultFontSize=8"

set "defaultFont=terminal"

set "libraryDefaultFont_ON=False"

set "debug=False"

set "debugPrompt=False"

<nul set /p "=[?25l">con

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

chcp 437>nul
set "server.bat_Logo=[38;5;220m[2C_[B[3D[38;5;208m>[38;5;220m([38;5;15m.[38;5;220m)__[B[5D(___/[0m"

rem global vars above this line not intended for user use.
rem ---------------------------------------------------------------------------------------------------------------------------------
for /f "tokens=2 delims=: " %%i in ('mode') do ( 2>nul set /a "0/%%i" && ( 
	if defined hei (set /a "wid=width=%%i") else (set /a "hei=height=%%i")
))

(for /f %%a in ('echo prompt $E^| cmd') do set "esc=%%a" ) || ( set "esc=" ) & set "\e="

set "pixel=Û" & set ".=%pixel%"

set  "\rgb=[38;2;^!r^!;^!g^!;^!b^!m" & set "\fcol=[48;2;^!r^!;^!g^!;^!b^!m"

set "cls=[2J" & set "\c=[2J"

set "list.hex=0 1 2 3 4 5 6 7 8 9 A B C D E F"

set "limit.4bit=0xF"
set "limit.8bit=0xFF"
set "limit.12bit=0xFFF"
set "limit.13bit=0x1FFF"
set "limit.16bit=0xFFFF"
set "limit.20bit=0xFFFFF"
set "limit.24bit=0xFFFFFF"
set "limit.28bit=0xFFFFFFF"
set "limit.31bit=0x7FFFFFFF"

rem multiline Comment     %rem[%    %]rem%
set "rem[=rem/||(" & set "rem]=)"

rem -Parse each argument as a 'command' with up to 2 'arguments'---------------------------------------------------------------------

for %%a in (%*) do (
	set /a "totalArguemnts+=1"
	set "fullArgument=%%a"
	for /f "tokens=1-3 delims=:" %%i in ("!fullArgument:~1!") do (
		set "argumentCommand[!totalArguemnts!]=%%~i"
		set "argumentArgument[!totalArguemnts!][1]=%%~j"
		set "argumentArgument[!totalArguemnts!][2]=%%~k"
	)
)
rem -For each chunk of the library desired to be used--------------------------------------------------------------------------------
for /l %%i in (1,1,%totalArguemnts%) do (

	REM -Set width of console--------------------------------------------------------------------------------------------------------W
		   if /i "!argumentCommand[%%i]!" equ "w" (
			set /a "wid=width=!argumentArgument[%%i][1]!"
			
	REM -Set height of console-------------------------------------------------------------------------------------------------------H
	) else if /i "!argumentCommand[%%i]!" equ "h" (
			set /a "hei=height=!argumentArgument[%%i][1]!"
			
	REM -Set font size---------------------------------------------------------------------------------------------------------------FS
	) else if /i "!argumentCommand[%%i]!" equ "fs" (
			call :setfont !argumentArgument[%%i][1]! "%defaultFont%"
			
	REM -Set title-------------------------------------------------------------------------------------------------------------------TITLE t
	) else if /i "!argumentCommand[%%i]:~0,1!" equ "t" (
			title !argumentArgument[%%i][1]!
			
	REM -DEBUG MODE------------------------------------------------------------------------------------------------------------------DEBUG d
	) else if /i "!argumentCommand[%%i]:~0,1!" equ "d" (
			set "debug=True"
			if /i "!argumentArgument[%%i][1]:~0,1!" equ "p" (
				set "debugPrompt=True"
			)
			
	REM -install mouse---------------------------------------------------------------------------------------------------------------mouse
	) else if /i "!argumentCommand[%%i]!" equ "mouse" (
			if not exist "%temp%\mouse.exe" (
				echo Will be installed to: %temp%& echo.
				set /p "consentToInstall=Would you like to install mouse.exe? Y/N: "
				if /i "!consentToInstall!" equ "y" (
					pushd %temp%
					echo=TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAA4fug4AtAnNIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5vdCBiZSBydW4gaW4gRE9TIG1vZGUuDQ0KJAAAAAAAAABQRQAATAECAAAAAAAAAAAAAAAAAOAADwMLAQYAAAAAAAAAAAAAAAAAQBEAAAAQAAAAIAAAAABAAAAQAAAAAgAABAAAAAAAAAAEAAAAAAAAAFAhAAAAAgAAAAAAAAMAAAAAABAAABAAAAAAEAAAEAAAAAAAABAAAAAAAAAAAAAAACAgAAA8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABcIAAALAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC50ZXh0AAAAABAAAAAQAAAAAgAAAAIAAAAAAAAAAAAAAAAAACAAAGAuZGF0YQAAAFABAAAAIAAAUgEAAAAEAAAAAAAAAAAAAAAAAABAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABVieWB7AgAAACQjUX6UOgsAAAAg8QED79F/lAPv0X8UA+2RfpQuAAgQABQ6IgBAACDxBC4AAAAAOkAAAAAycNVieWB7CQAAACQuPb///9Q6GwBAACJRfy4AAAAAIlF3I1F+FCLRfxQ6FwBAACLRfiDyBCD4L+D4N9Qi0X8UOhOAQAAi0XchcAPhAUAAADpnAAAAI1F9FC4AQAAAFCNReBQi0X8UOgvAQAAD7dF4IP4Ag+FcwAAAItF6IP4AbgAAAAAD5TAiUXchcAPhA8AAACLRQi5AQAAAIgI6SMAAACLReiD+AK4AAAAAA+UwIlF3IXAD4QKAAAAi0UIuQIAAACICItF3IXAD4QdAAAAi0UIg8ACD79N5GaJCItFCIPAAoPAAg+/TeZmiQjpVP///4tF+FCLRfxQ6JUAAADJwwAAAFWJ5YHsFAAAAJC4AAAAAIlF7LgAAAMAULgAAAEAUOh9AAAAg8QIuAEAAABQ6HcAAACDxASNRexQuAAAAABQjUX0UI1F+FCNRfxQ6GEAAACDxBSLRfRQi0X4UItF/FDoXf7//4PEDIlF8ItF8FDoRgAAAIPEBMnDAP8lXCBAAAAA/yV0IEAAAAD/JXggQAAAAP8lfCBAAAAA/yWAIEAAAAD/JWAgQAAAAP8lZCBAAAAA/yVoIEAAAAD/JWwgQAAAACVkICVkICVkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAiCAAAAAAAAAAAAAAtCAAAFwgAACgIAAAAAAAAAAAAAD9IAAAdCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvyAAAMggAADVIAAA5iAAAPYgAAAAAAAACiEAABkhAAAqIQAAOyEAAAAAAAC/IAAAyCAAANUgAADmIAAA9iAAAAAAAAAKIQAAGSEAACohAAA7IQAAAAAAAG1zdmNydC5kbGwAAABwcmludGYAAABfY29udHJvbGZwAAAAX19zZXRfYXBwX3R5cGUAAABfX2dldG1haW5hcmdzAAAAZXhpdABrZXJuZWwzMi5kbGwAAABHZXRTdGRIYW5kbGUAAABHZXRDb25zb2xlTW9kZQAAAFNldENvbnNvbGVNb2RlAAAAUmVhZENvbnNvbGVJbnB1dEEAAAAA>mouse.txt
					(certutil -decode mouse.txt mouse.exe) || ( echo You may need to run as ADMIN & pause )
					(del /f /q mouse.txt >nul ) & popd
				) else echo mouse.exe not installed. You will not be able to click anything. & pause
			)
			set "getMouse=for /f "tokens=1-3" %%W in ('%temp%\Mouse.exe') do set /a "mouse.C=%%W,mouse.X=%%X,mouse.Y=%%Y""

	REM -Enable for extra special characters-----------------------------------------------------------------------------------------EXTLIB e
	) else if /i "!argumentCommand[%%i]:~0,1!" equ "e" (
			rem Backspace
			for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
			rem Carriage Return
			for /f %%A in ('copy /z "%~dpf0" nul') do set "CR=%%A"
			rem Tab 0x09
			for /f "delims=" %%T in ('forfiles /p "%~dp0." /m "%~nx0" /c "cmd /c echo(0x09"') do set "TAB=%%T"

			set "pixel[2]=%ESC%(0a%ESC%(B"
			set "degreeSymbol=%ESC%(0f%ESC%(B"
			set "border[NW]=%ESC%(0l%ESC%(B"
			set "border[NE]=%ESC%(0k%ESC%(B"
			set "border[SW]=%ESC%(0m%ESC%(B"
			set "border[SE]=%ESC%(0j%ESC%(B"
			set "border[H]=%ESC%(0q%ESC%(B"
			set "border[V]=%ESC%(0x%ESC%(B"
			set "border[+]=%ESC%(0n%ESC%(B"
			set "border[HS]=%ESC%(0w%ESC%(B"
			set "border[HN]=%ESC%(0v%ESC%(B"
			set "border[VW]=%ESC%(0u%ESC%(B"
			set "border[VE]=%ESC%(0t%ESC%(B"
			for %%i in ("pointer[R].10" "pointer[L].11" "pointer[U].1E" "pointer[D].1F"
					   "pixel[0].DB" "pixel[1].B0" "pixel[3].B2"
					   "face[0].01" "face[1].02" "musicNote.0E" "diamond.04" "club.05" "spade.06" "BEL.07" "<3.03" "degree.F8"
			) do for /f "tokens=1,2 delims=." %%a in ("%%~i") do (
				for /f %%i in ('forfiles /m "%~nx0" /c "cmd /c echo 0x%%~b"') do set "%%~a=%%~i"
			)

	REM -Get math functions----------------------------------------------------------------------------------------------------------MATH
	) else if /i "!argumentCommand[%%i]!" equ "math" (
			set /a "PI=(35500000/113+5)/10, HALF_PI=(35500000/113/2+5)/10, TWO_PI=2*PI, PI32=PI+HALF_PI, neg_PI=PI * -1, neg_HALF_PI=HALF_PI *-1"
			set "sin=(a=((x*31416/180)%%62832)+(((x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
			set "cos=(a=((15708-x*31416/180)%%62832)+(((15708-x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
			set "sinr=(a=(x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!) / 10000"
			set "cosr=(a=(15708 - x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), !_SIN!) / 10000"
			set "Sqrt(N)=( x=(N)/(11*1024)+40, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2 )"
			set "Sign(x)=(x)>>31 | -(x)>>31 & 1" 
			set "Abs=(((x)>>31|1)*(x))"
			set "dist(x2,x1,y2,y1)=( @=x2-x1, $=y2-y1, ?=(((@>>31|1)*@-(($>>31|1)*$))>>31)+1, ?*(2*(@>>31|1)*@-($>>31|1)*$-((@>>31|1)*@-($>>31|1)*$)) + ^^^!?*((@>>31|1)*@-($>>31|1)*$-((@>>31|1)*@-($>>31|1)*$*2)) )"
			set "map=(c)+((d)-(c))*((v)-(a))/((b)-(a))"
			set "lerp=?=(a+c*(b-a)*10)/1000+a"
			set "swap=x^=y, y^=x, x^=y"
			set "getState=a*8+b*4+c*2+d*1"
			set "max=(x - ((((x - y) >> 31) & 1) * (x - y)))"
			set "min=(y - ((((x - y) >> 31) & 1) * (y - x)))"
			set "percentOf=p=x*y/100"
			set "clamp=(low - ((((low - (x - ((((high - x) >> 31) & 1) * (x - high)))) >> 31) & 1) * (low - (x - ((((high - x) >> 31) & 1) * (x - high))))))"

			
	REM -Get misc functions----------------------------------------------------------------------------------------------------------MISC
	) else if /i "!argumentCommand[%%i]!" equ "misc" (
			set "gravity=_G_=1, ?.acceleration+=_G_, ?.velocity+=?.acceleration, ?.acceleration*=0, ?+=?.velocity"
			set "chance=1/((((^!random^!%%100)-x)>>31)&1)"
			set "smoothStep=(3*100 - 2 * x) * x/100 * x/100"
			set "bitColor=C=((r)*6/256)*36+((g)*6/256)*6+((b)*6/256)+16"
			set "RCX=1/((((x-wid)>>31)&1)^(((0-x)>>31)&1))"
			set "RCY=1/((((x-hei)>>31)&1)^(((0-x)>>31)&1))"
			set "edgeCase=1/(((x-0)>>31)&1)|((~(x-wid)>>31)&1)|(((y-0)>>31)&1)|((~(y-=hei)>>31)&1)"
			set "rndBetween=(^!random^! %% (x*2+1) + -x)"
			set "fib=?=c=a+b, a=b, b=c"
			set "rndRGB=r=^!random^! %% 255, g=^!random^! %% 255, b=^!random^! %% 255"
			set "boundingBox=1/(((~(y-a)>>31)&1)&((~(b-y)>>31)&1)&((~(x-c)>>31)&1)&((~(d-x)>>31)&1))"
			set "every=1/(((~(0-(frameCount%%x))>>31)&1)&((~((frameCount%%x)-0)>>31)&1))"
			set "FNCross=a * d - b * c"

	REM -Get shape functions---------------------------------------------------------------------------------------------------------SHAPE sh
	) else if /i "!argumentCommand[%%i]:~0,2!" equ "sh" (
			set "SQ(x)=x*x"
			set "CUBE(x)=x*x*x"
			set "pmSQ(x)=x+x+x+x"
			set "pmREC(l,w)=l+w+l+w"
			set "pmTRI(a,b,c)=a+b+c"
			set "areaREC(l,w)=l*w"
			set "areaTRI(b,h)=(b*h)/2"
			set "areaTRA(b1,b2,h)=(b1*b2)*h/2"
			set "volBOX(l,w,h)=l*w*h"
			
	REM -Get algorithmic conditional functions---------------------------------------------------------------------------------------AC
	) else if /i "!argumentCommand[%%i]!" equ "ac" (
			set "LSS(x,y)=(((x-y)>>31)&1)"
			set "LEQ(x,y)=((~(y-x)>>31)&1)"
			set "GTR(x,y)=(((y-x)>>31)&1)"
			set "GEQ(x,y)=((~(x-y)>>31)&1)"
			set "EQU(x,y)=(((~(y-x)>>31)&1)&((~(x-y)>>31)&1))"
			set "NEQ(x,y)=((((x-y)>>31)&1)|(((y-x)>>31)&1))"
			set "AND(b1,b2)=(b1&b2)"
			set "OR(b1,b2)=(b1|b2)"
			set "XOR(b1,b2)=(b1^b2)"
			set "TERN(bool,v1,v2)=((bool*v1)|((~bool&1)*v2))"  &REM ?:
				
	REM -Get cursor functions--------------------------------------------------------------------------------------------------------CURSOR c
	) else if /i "!argumentCommand[%%i]!" equ "cursor" (
			set ">=<nul set /p ="
			set "push=7"
			set "pop=8"
			set "cursor[U]=[?A"
			set "cursor[D]=[?B"
			set "cursor[L]=[?D"
			set "cursor[R]=[?C"
			set "cac=[1J"
			set "cbc=[0J"
			set "underLine=[4m"
			set "capIt=[0m"
			set "moveXY=[^!y^!;^!x^!H"
			set "home=[H"

	REM -Unpack gfx macros-----------------------------------------------------------------------------------------------------------GFX
	) else if /i "!argumentCommand[%%i]!" equ "gfx" (
			call :graphicsFunctions
			
	REM -Unpack utility macros-------------------------------------------------------------------------------------------------------UTIL
	) else if /i "!argumentCommand[%%i]!" equ "util" (
			call :utilityFunctions

	REM -Unpack utility macros-------------------------------------------------------------------------------------------------------BUTTON
	) else if /i "!argumentCommand[%%i]!" equ "buttons" (
			call :buttons

	REM -Get RGB color array---------------------------------------------------------------------------------------------------------CR
	) else if /i "!argumentCommand[%%i]!" equ "cr" (
			set /a "range=argumentArgument[%%i][1]"
			set "totalColorsInRange=0"
			for /l %%a in (0,!range!,255) do set /a "totalColorsInRange+=1" & set "color[!totalColorsInRange!]=[38;2;255;%%a;0m"
			for /l %%a in (255,-!range!,0) do set /a "totalColorsInRange+=1" & set "color[!totalColorsInRange!]=[38;2;%%a;255;0m"
			for /l %%a in (0,!range!,255) do set /a "totalColorsInRange+=1" & set "color[!totalColorsInRange!]=[38;2;0;255;%%am"
			for /l %%a in (255,-!range!,0) do set /a "totalColorsInRange+=1" & set "color[!totalColorsInRange!]=[38;2;0;%%a;255m"
			for /l %%a in (0,!range!,255) do set /a "totalColorsInRange+=1" & set "color[!totalColorsInRange!]=[38;2;%%a;0;255m"
			for /l %%a in (255,-!range!,0) do set /a "totalColorsInRange+=1" & set "color[!totalColorsInRange!]=[38;2;255;0;%%am"
			set /a "range=255 / argumentArgument[%%i][1]"
	)
	
	set "argumentCommand[%%i]="
	set "argumentArgument[%%i][1]="
	set "argumentArgument[%%i][2]="
)

if "%debug%" neq "False" (
	call :setfont 16 Consolas
	mode 180,100
	if "%debugPrompt%" neq "False" (
		prompt !server.bat_logo!
	)
	@echo on
) else (
	if "%libraryDefaultFont_ON%" neq "False" (
		call :setfont %defaultFontSize% "%defaultFont%"
	)
	mode %wid%,%hei%
)
cls
goto :eof

:___________________________________________________________________________________________
:graphicsFunctions
set "frames=frameCount=(frameCount + 1) %% Limit.32bit"
set "loop=for /l %%# in () do "
set "framedLoop=%loop% ( set /a "%frames%""
set "throttle=for /l %%# in (1,x,1000000) do rem"
set "every=1/(((~(0-(frameCount%%x))>>31)&1)&((~((frameCount%%x)-0)>>31)&1))"

:_point DON'T CALL
rem %point% x y <rtn> screen
set point=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set "screen=^!screen^![%%2;%%1H%pixel%[0m"%\n%
)) else set args=

:_plot DON'T CALL
rem %plot% x y 0-255 CHAR <rtn> screen
set plot=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "screen=^!screen^![%%2;%%1H[38;5;%%3m%%~4[0m"%\n%
)) else set args=

:_RGBpoint DON'T CALL
rem %RGBpoint% x y 0-255 0-255 0-255 CHAR
set rgbpoint=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set "screen=^!screen^![%%2;%%1H[38;2;%%3;%%4;%%5m%pixel%[0m"%\n%
)) else set args=

:_BVector DON'T CALL
rem x y theta(0-360) magnitude(rec.=4 max) <rtn> %~1.BV_ATTRIBUTES
set BVector=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	if /i "%%~2" equ "end" (%\n%
		for %%i in (x y i j td tr m rgb fcol vd vr vmw vmh ch) do set "%%~1.%%i="%\n%
	) else (%\n%
		set /a "%%~1.x=^!random^! %% wid + 1"%\n%
		set /a "%%~1.y=^!random^! %% hei + 1"%\n%
		set /a "%%~1.td=^!random^! %% 360"%\n%
		set /a "%%~1.tr=^!random^! %% 62832"%\n%
		set /a "%%~1.m=^!random^! %% 2 + 2"%\n%
		set /a "%%~1.i=^!random^! %% 3 + -1"%\n%
		set /a "%%~1.j=^!random^! %% 3 + -1"%\n%
		if "^!%%~1.i^!" equ "0" if "^!%%~1.j^!" equ "0" (%\n%
			set /a "%%~1.i=1"%\n%
		)%\n%
		set /a "bvr=^!random^! %% 255","bvg=^!random^! %% 255","bvb=^!random^! %% 255"%\n%
		set "%%~1.rgb=[38;2;^!bvr^!;^!bvg^!;^!bvb^!m"%\n%
		set "%%~1.fcol=[48;2;^!bvr^!;^!bvg^!;^!bvb^!m"%\n%
		for %%a in (bvr bvg bvb) do set "%%a="%\n%
		if "%%~2" neq "" (%\n%
			set /a "%%~1.vd=%%~2"%\n%
			set /a "%%~1.vr=%%~1.vd / 2"%\n%
			set /a "%%~1.vmw=wid - %%~1.vd"%\n%
			set /a "%%~1.vmh=hei - %%~1.vd"%\n%
			set /a "%%~1.x=^!random^! %% (wid - %%~1.vr) + %%~1.vd + 1"%\n%
			set /a "%%~1.y=^!random^! %% (hei - %%~1.vr) + %%~1.vd + 1"%\n%
		)%\n%
		if "%%~3" neq "" set "%%~1.ch=%%~3"%\n%
	)%\n%
)) else set args=

:_lerpRGB DON'T CALL
rem %lerpRGB% rgb1 rgb2 1-100 <rtn> $r $g $b
set lerpRGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "a=r[%%~1], b=r[%%~2], c=%%~3, $r=^!lerp^!", "a=g[%%~1], b=g[%%~2], c=%%~3, $g=^!lerp^!", "a=b[%%~1], b=b[%%~2], c=%%~3, $b=^!lerp^!"%\n%
)) else set args=

:_getDistance DON'T CALL
rem %getDistance% x2 x1 y2 y1 <rtnVar>
set getDistance=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set /a "%%5=( ?=((((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4))))>>31)+1, ?*(2*((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))-(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4))))) + ^^^!?*(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))-(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))*2)) )"%\n%
)) else set args=

:_exp DON'T CALL
rem %exp% num pow <rtnVar>
for /l %%a in (1,1,30) do set "pb=!pb!x*"
set exp=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "x=%%~1","$p=%%~2*2-1"%\n%
	for %%a in (^^!$p^^!) do set /a "%%~3=^!pb:~0,%%a^!"%\n%
)) else set args=

:_circle DON'T CALL
rem %circle% x y ch cw <rtn> $circle
set circle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$circle="%\n%
	for /l %%a in (0,3,360) do (%\n%
		set /a "xa=%%~3 * ^!cos:x=%%a^! + %%~1", "ya=%%~4 * ^!sin:x=%%a^! + %%~2"%\n%
		set "$circle=^!$circle^![^!ya^!;^!xa^!H%pixel%"%\n%
	)%\n%
	set "$circle=^!$circle^![0m"%\n%
)) else set args=

:_rect DON'T CALL
rem %rect% x r length <rtn> $rect
set rect=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$rect="%\n%
	set /a "$x=%%~1", "$y=%%~2", "rectw=%%~3", "recth=%%~4"%\n%
	for /l %%b in (1,1,^^!rectw^^!) do ( set /a "$x+=2 * ^!cos:x=0^!", "$y+=2 * ^!sin:x=0^!"%\n%
		set "$rect=^!$rect^!^!esc^![^!$y^!;^!$x^!H%pixel%"%\n%
	)%\n%
	for /l %%b in (1,1,^^!recth^^!) do ( set /a "$x+=2 * ^!cos:x=90^!", "$y+=2 * ^!sin:x=90^!"%\n%
		set "$rect=^!$rect^!^!esc^![^!$y^!;^!$x^!H%pixel%"%\n%
	)%\n%
	for /l %%b in (1,1,^^!rectw^^!) do ( set /a "$x+=2 * ^!cos:x=180^!", "$y+=2 * ^!sin:x=180^!"%\n%
		set "$rect=^!$rect^!^!esc^![^!$y^!;^!$x^!H%pixel%"%\n%
	)%\n%
	for /l %%b in (1,1,^^!recth^^!) do ( set /a "$x+=2 * ^!cos:x=270^!", "$y+=2 * ^!sin:x=270^!"%\n%
		set "$rect=^!$rect^!^!esc^![^!$y^!;^!$x^!H%pixel%"%\n%
	)%\n%
	set "$rect=^!$rect^![0m"%\n%
)) else set args=

:_line DON'T CALL
rem line x0 y0 x1 y1 color
set line=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	if "%%~5" equ "" ( set "hue=15" ) else ( set "hue=%%~5")%\n%
	set "$line=[38;5;^!hue^!m"%\n%
	set /a "xa=%%~1", "ya=%%~2", "xb=%%~3", "yb=%%~4", "dx=%%~3 - %%~1", "dy=%%~4 - %%~2"%\n%
	if ^^!dy^^! lss 0 ( set /a "dy=-dy", "stepy=-1" ) else ( set "stepy=1" )%\n%
	if ^^!dx^^! lss 0 ( set /a "dx=-dx", "stepx=-1" ) else ( set "stepx=1" )%\n%
	set /a "dx<<=1", "dy<<=1"%\n%
	if ^^!dx^^! gtr ^^!dy^^! (%\n%
		set /a "fraction=dy - (dx >> 1)"%\n%
		for /l %%x in (^^!xa^^!,^^!stepx^^!,^^!xb^^!) do (%\n%
			if ^^!fraction^^! geq 0 set /a "ya+=stepy", "fraction-=dx"%\n%
			set /a "fraction+=dy"%\n%
			set "$line=^!$line^![^!ya^!;%%xH%pixel%"%\n%
		)%\n%
	) else (%\n%
		set /a "fraction=dx - (dy >> 1)"%\n%
		for /l %%y in (^^!ya^^!,^^!stepy^^!,^^!yb^^!) do (%\n%
			if ^^!fraction^^! geq 0 set /a "xa+=stepx", "fraction-=dy"%\n%
			set /a "fraction+=dx"%\n%
			set "$line=^!$line^![%%y;^!xa^!H%pixel%"%\n%
		)%\n%
	)%\n%
	set "$line=^!$line^![0m"%\n%
)) else set args=

:_bezier DON'T CALL
rem %bezier% x1 y1 x2 y2 x3 y3 x4 y4 length
set bezier=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%1 in ("^!args^!") do (%\n%
	set "$bezier=" ^& set "c=0"%\n%
	set /a "px[0]=%%~1","py[0]=%%~2", "px[1]=%%~3","py[1]=%%~4", "px[2]=%%~5","py[2]=%%~6", "px[3]=%%~7","py[3]=%%~8"%\n%
	for /l %%# in (1,1,%%~9) do (%\n%
		set /a "vx[1]=(px[0]+c*(px[1]-px[0])*10)/1000+px[0]","vy[1]=(py[0]+c*(py[1]-py[0])*10)/1000+py[0]","vx[2]=(px[1]+c*(px[2]-px[1])*10)/1000+px[1]","vy[2]=(py[1]+c*(py[2]-py[1])*10)/1000+py[1]","vx[3]=(px[2]+c*(px[3]-px[2])*10)/1000+px[2]","vy[3]=(py[2]+c*(py[3]-py[2])*10)/1000+py[2]","vx[4]=(vx[1]+c*(vx[2]-vx[1])*10)/1000+vx[1]","vy[4]=(vy[1]+c*(vy[2]-vy[1])*10)/1000+vy[1]","vx[5]=(vx[2]+c*(vx[3]-vx[2])*10)/1000+vx[2]","vy[5]=(vy[2]+c*(vy[3]-vy[2])*10)/1000+vy[2]","vx[6]=(vx[4]+c*(vx[5]-vx[4])*10)/1000+vx[4]","vy[6]=(vy[4]+c*(vy[5]-vy[4])*10)/1000+vy[4]","c+=1"%\n%
		set "$bezier=^!$bezier^![^!vy[6]^!;^!vx[6]^!H%pixel%"%\n%
	)%\n%
)) else set args=

:_RGBezier DON'T CALL    -     WORKS WITH /cr
rem %bezier% x1 y1 x2 y2 x3 y3 x4 y4
set RGBezier=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%1 in ("^!args^!") do (%\n%
	set "$rgbezier=" ^& set "c=0"%\n%
	set /a "px[0]=%%~1","py[0]=%%~2", "px[1]=%%~3","py[1]=%%~4", "px[2]=%%~5","py[2]=%%~6", "px[3]=%%~7","py[3]=%%~8"%\n%
	for /l %%m in (1,1,^^!totalColorsInRange^^!) do (%\n%
		set /a "vx[1]=(px[0]+c*(px[1]-px[0])*10)/1000+px[0]","vy[1]=(py[0]+c*(py[1]-py[0])*10)/1000+py[0]","vx[2]=(px[1]+c*(px[2]-px[1])*10)/1000+px[1]","vy[2]=(py[1]+c*(py[2]-py[1])*10)/1000+py[1]","vx[3]=(px[2]+c*(px[3]-px[2])*10)/1000+px[2]","vy[3]=(py[2]+c*(py[3]-py[2])*10)/1000+py[2]","vx[4]=(vx[1]+c*(vx[2]-vx[1])*10)/1000+vx[1]","vy[4]=(vy[1]+c*(vy[2]-vy[1])*10)/1000+vy[1]","vx[5]=(vx[2]+c*(vx[3]-vx[2])*10)/1000+vx[2]","vy[5]=(vy[2]+c*(vy[3]-vy[2])*10)/1000+vy[2]","vx[6]=(vx[4]+c*(vx[5]-vx[4])*10)/1000+vx[4]","vy[6]=(vy[4]+c*(vy[5]-vy[4])*10)/1000+vy[4]","c+=1"%\n%
		set "$rgbezier=^!$rgbezier^!^!color[%%m]^![^!vy[6]^!;^!vx[6]^!H%pixel%"%\n%
	)%\n%
)) else set args=

:_arc DON'T CALL
rem arc x y size DEGREES(0-360) arcRotationDegrees(0-360) lineThinness color
set arc=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7" %%1 in ("^!args^!") do (%\n%
	set "$arc=[38;5;15m"%\n%
    for /l %%e in (%%~4,%%~6,%%~5) do (%\n%
		set /a "_x=%%~3 * ^!cos:x=%%e^! + %%~1", "_y=%%~3 * ^!sin:x=%%e^! + %%~2"%\n%
		set "$arc=^!$arc^![^!_y^!;^!_x^!H%pixel%"%\n%
	)%\n%
	set "$arc=^!$arc^![0m"%\n%
)) else set args=

:_plot_HSL_RGB DON'T CALL
rem plot_HSL_RGB x y 0-360 0-10000 0-10000
set plot_HSL_RGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set /a "H=%%3", "S=%%4", "L=%%5"%\n%
	if %%3 geq 360 set /a "H=360"%\n%
	if %%3 leq 0   set /a "H=0"%\n%
	set /a "va=2*L-10000"%\n%
	for /f "tokens=1" %%a in ("^!va^!") do if %%a lss 0 set /a "va=-va"%\n%
	set /a "C=(10000-va)*S/10000"%\n%
	set /a "h1=H*10000/60"%\n%
	set /a "mm=(h1 %% 20000) - 10000"%\n%
	for /f "tokens=1" %%a in ("^!mm^!")  do if %%a lss 0 set /a "mm=-mm"%\n%
	set /a "X=C *(10000 - mm)/10000"%\n%
	set /a "m=L - C/2"%\n%
	for /f "tokens=1" %%a in ("^!H^!") do (%\n%
		if %%a lss 60  ( set /a "R=C+m", "G=X+m", "B=0+m" ) else (%\n%
		if %%a lss 120 ( set /a "R=X+m", "G=C+m", "B=0+m" ) else (%\n%
		if %%a lss 180 ( set /a "R=0+m", "G=C+m", "B=X+m" ) else (%\n%
		if %%a lss 240 ( set /a "R=0+m", "G=X+m", "B=C+m" ) else (%\n%
		if %%a lss 300 ( set /a "R=X+m", "G=0+m", "B=C+m" ) else (%\n%
		if %%a lss 360 ( set /a "R=C+m", "G=0+m", "B=X+m" ))))))%\n%
	)%\n%
	set /a "R=R*255/10000", "G=G*255/10000", "B=B*255/10000"%\n%
	^!rgbpoint^! %%1 %%2 ^^!R^^! ^^!G^^! ^^!B^^!%\n%
)) else set args=

:_plot_HSV_RGB DON'T CALL
rem plot_HSV_RGB x y 0-360 0-10000 0-10000
set plot_HSV_RGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set /a "H=%%3", "S=%%4", "V=%%5"%\n%
	if %%3 geq 360 set /a "H=360"%\n%
	if %%3 leq 0   set /a "H=0"%\n%
	set /a "h1=h*10000/60"%\n%
	set /a "mm=(h1 %% 20000) - 10000"%\n%
	for /f "tokens=1" %%a in ("^!mm^!") do if %%a lss 0 set /a "mm=-mm"%\n%
	set /a "C=(V * S) / 10000"%\n%
	set /a "X=C *(10000 - mm) / 10000"%\n%
	set /a "m=V - C"%\n%
	for /f "tokens=1" %%a in ("^!H^!") do (%\n%
		if %%a lss 60  ( set /a "R=C+m", "G=X+m", "B=0+m") else (%\n%
		if %%a lss 120 ( set /a "R=X+m", "G=C+m", "B=0+m") else (%\n%
		if %%a lss 180 ( set /a "R=0+m", "G=C+m", "B=X+m") else (%\n%
		if %%a lss 240 ( set /a "R=0+m", "G=X+m", "B=C+m") else (%\n%
		if %%a lss 300 ( set /a "R=X+m", "G=0+m", "B=C+m") else (%\n%
		if %%a lss 360 ( set /a "R=C+m", "G=0+m", "B=X+m"))))))%\n%
	)%\n%
	set /a "R=R*255/10000", "G=G*255/10000", "B=B*255/10000"%\n%
	^!rgbpoint^! %%1 %%2 ^^!R^^! ^^!G^^! ^^!B^^!%\n%
)) else set args=
goto :eof

:___________________________________________________________________________________________
:utilityFunctions
:_sortFWD DON'T CALL
rem %sort[fwd]:#=stingArray%
SET "sort[fwd]=(FOR %%S in (%%#%%) DO @ECHO %%S) ^| SORT"

:_sortREV DON'T CALL
rem %sort[rev]:#=stingArray%
SET "sort[rev]=(FOR %%S in (%%#%%) DO @ECHO %%S) ^| SORT /R"

:_filterFWD DON'T CALL
rem %filter[fwd]:#=stingArray%
SET "filter[fwd]=(FOR %%F in (%%#%%) DO @ECHO %%F) ^| SORT /UNIQ"

:_filterREV DON'T CALL
rem %filter[rev]:#=stingArray%
SET "filter[rev]=(FOR %%F in (%%#%%) DO @ECHO %%F) ^| SORT /UNIQ /R"

:_hexToRGB DON'T CALL
rem %hexToRGB% 00a2ed
set hexToRGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args:~1,2^! ^!args:~3,2^! ^!args:~5,2^!") do (%\n%
	set /a "R=0x%%~1", "G=0x%%~2", "B=0x%%~3"%\n%
)) else set args=

:_hexToBase2 DONT' CALL
rem %hexToBase2% 1B out <rtnVar>
set hexToBase2=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	for /l %%i in (7,-1,0) do (%\n%
		set /a "i=((0x%%1 >> %%i) & 1)"%\n%
		set "%%~2=^!%%~2^!^!i^!"%\n%
	)%\n%
)) else set args=

:_hexToBase4 DONT' CALL
rem %hexToBase4% 1B out <rtnVar>
set hexToBase4=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	for /l %%b in (7,-1,0) do (%\n%
		set /a "bit=(0x%%~1 >> %%b) & 1"%\n%
		set "bin=^!bin^!^!bit^!"%\n%
		if "^!bin:~1,1^!" neq "" (%\n%
			set /a "bit=^!bin:~0,1^! * 2 + ^!bin:~1,1^! * 1"%\n%
			set "%%~2=^!%%~2^!^!bit^!"%\n%
			set "bin="%\n%
		)%\n%
	)%\n%
	set "bin="%\n%
)) else set args=

:_getLen DON'T CALL
rem %getlen% "string" <rtn> $length / 
set getlen=for %%# in (1 2) do if %%#==2 ( for %%1 in (^^!args^^!) do (%\n%
	set "str=X%%~1" ^& set "length=0" ^& for /l %%b in (10,-1,0) do set /a "length|=1<<%%b" ^& for %%c in (^^!length^^!) do if "^!str:~%%c,1^!" equ "" set /a "length&=~1<<%%b"%\n%
)) else set args=

:_pad DON'T CALL
rem %pad% "string".int <rtn> $padding
set "$paddingBuffer=                                                                                "
set pad=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3 delims=." %%x in ("^!args^!") do (%\n%
    set "$padding="^&set "$_str=%%~x"^&set "len="%\n%
    (for %%P in (32 16 8 4 2 1) do if "^!$_str:~%%P,1^!" NEQ "" set /a "len+=%%P" ^& set "$_str=^!$_str:~%%P^!") ^& set /a "len-=2"%\n%
    set /a "s=%%~y-len"^&for %%a in (^^!s^^!) do set "$padding=^!$paddingBuffer:~0,%%a^!"%\n%
    if "%%~z" neq "" set "%%~z=^!$padding^!"%\n%
)) else set args=

:_encodeB64 DON'T CALL
rem %encode% "string" <rtn> base64
set encode=for %%# in (1 2) do if %%#==2 ( for /f "tokens=*" %%1 in ("^!args^!") do (%\n%
	echo=%%~1^>inFile.txt%\n%
	certutil -encode "inFile.txt" "outFile.txt"^>nul%\n%
	for /f "tokens=* skip=1" %%a in (outFile.txt) do (%\n%
		if "%%~a" neq "-----END CERTIFICATE-----" (%\n%
			set "base64=%%a"%\n%
		)%\n%
	)%\n%
	del /f /q "outFile.txt"%\n%
	del /f /q "inFile.txt"%\n%
)) else set args=

:_decodeB64 DON'T CALL
rem %decode:?=!base64!% <rtn> plainText.txt
set decode=for %%# in (1 2) do if %%#==2 ( for /f "tokens=*" %%1 in ("^!args^!") do (%\n%
	echo %%~1^>inFile.txt%\n%
	certutil -decode "inFile.txt" "outFile.txt"^>nul%\n%
	for /f "tokens=*" %%a in (outFile.txt) do (%\n%
		set "plainText=%%a"%\n%
	)%\n%
	del /f /q outFile.txt%\n%
	del /f /q inFile.txt%\n%
)) else set args=

:_string_properties DON'T CALL
rem %string_properties "string" <rtn> $_len, $_rev $_upp $_low
set string_properties=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (%\n%
	for %%i in ($_len $_rev $_upp $_low) do set "%%i="%\n%
    set "$_str=%%~1" ^& set "$_str=^!$_str:~1,-1^!" ^& set "string.upp=^!$_str:~1^!" ^& set "string.low=^!$_str:~1^!"%\n%
	for /l %%b in (10,-1,0) do set /a "string.len|=1<<%%b" ^& for %%c in (^^!string.len^^!) do if "^!$_str:~%%c,1^!" equ "" set /a "string.len&=~1<<%%b"%\n%
    for /l %%a in (^^!string.len^^!,-1,1) do set "string.rev=^!string.rev^!^!$_str:~%%~a,1^!"%\n%
    for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "string.upp=^!string.upp:%%i=%%i^!"%\n%
    for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "string.low=^!string.low:%%i=%%i^!"%\n%
)) else set args=

:_lineInject DON'T CALL
rem %lineInject:?=FILE NAME.EXT% "String":Line#
set lineInject=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4 delims=:/" %%1 in ("?:^!args:~1^!") do (%\n%
	set "linesInFile=0"%\n%
	for /f "usebackq tokens=*" %%i in ("%%~1") do (%\n%
		set /a "linesInFile+=1"%\n%
		if /i "%%~4" neq "s" (%\n%
			if ^^!linesInFile^^! equ %%~3 echo=%%~2^>^>-temp-.txt%\n%
			echo %%i^>^>-temp-.txt%\n%
		) else (%\n%
			if ^^!linesInFile^^! equ %%~3 ( echo=%%~2^>^>-temp-.txt ) else echo %%i^>^>-temp-.txt%\n%
		)%\n%
	)%\n%
	ren "%%~1" "deltmp.txt" ^& ren "-temp-.txt" "%%~1" ^& del /f /q "deltmp.txt"%\n%
)) else set args=

:_getLatency DON'T CALL
rem %getLatency% <rtn> %latency%
set "getLatency=for /f "tokens=2 delims==" %%l in ('ping -n 1 google.com ^| findstr /L "time="') do set "latency=%%l""

:_download DON'T CALL
rem %download% url file
set download=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	Powershell.exe -command "(New-Object System.Net.WebClient).DownloadFile('%%~1','%%~2')"%\n%
)) else set args=

:_ZIP DON'T CALL
rem %zip% file.ext zipFileName
set ZIP=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	tar -cf %%~2.zip %%~1%\n%
)) else set args=

:_UNZIP DON'T CALL
rem %unzip% zipFileName
set UNZIP=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	tar -xf %%~1.zip%\n%
)) else set args=

:_License DO NOT use unless you are DONE editing your code.
rem %license% "mySignature" NOTE: You MUST add at least 1 signature to your script ":::mySignature" without the quotes
set License=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (%\n%
	for /f "usebackq" %%i in ('%self%') do set /a "x=%%~zi"%\n%
	for /f "tokens=1,2 delims=:" %%a in ('findstr /n ":::" "%~F0"') do (%\n%
        if "%%b" equ %%1 set /a "i+=1", "x+=i+%%a"%\n%
	)%\n%
	if not exist "^!temp^!\%~n0_cP.txt" echo ^^!x^^!^>"^!temp^!\%~n0_cP.txt"%\n%
	if exist "^!temp^!\%~n0_cP.txt" ^<"^!temp^!\%~n0_cP.txt" set /p "g="%\n%
	if "^!x^!" neq "^!g^!" start /b "" cmd /c del "%~f0" ^& exit%\n%
)) else set args=
goto :eof

:___________________________________________________________________________________________
:buttons
:_makeButton DON'T CALL
rem %makeButton% x y ID clickID 'string' <- MUST USE SINGLE QUOTE
set makeButton=for %%# in (1 2) do if %%#==2 ( for %%i in ("^!args^!") do  for /f "tokens=1,2 delims='" %%1 in ("%%~i") do  for /f "tokens=1-4" %%w in ("%%~1") do (%\n%
	set /a "length=0" ^& set "bar=" ^& set "str=X%%~2"%\n%
	set "button.list=^!button.list^!%%~y "%\n%
	for /l %%b in (6,-1,0) do set /a "length|=1<<%%b" ^& for %%c in (^^!length^^!) do if "^!str:~%%c,1^!" equ "" set /a "length&=~1<<%%b"%\n%
	set /a "back=length + 2"%\n%
	for /l %%i in (1,1,^^!length^^!) do set "bar=^!bar^!Ä"%\n%
	set "button[%%~y].sprite=[%%~x;%%~wHÚ^!bar^!¿[^!back^!D[B³%%~2³[^!back^!D[BÀ^!bar^!Ù[0m"%\n%
	set "button.display=^!button.display^!^!button[%%~y].sprite^!"%\n%
	set /a "button[%%~y].xmin=%%~w - 1","button[%%~y].xmax=%%~w + length","button[%%~y].ymin=%%~x - 1","button[%%~y].ymax=%%~x + 1"%\n%
	set "button[%%~y].clicked=if ^^^!mouse.c^^^! equ %%~z if ^^^!mouse.Y^^^! geq ^!button[%%~y].ymin^! if ^^^!mouse.Y^^^! leq ^!button[%%~y].Ymax^! if ^^^!mouse.X^^^! geq ^!button[%%~y].Xmin^! if ^^^!mouse.X^^^! leq ^!button[%%~y].Xmax^!"%\n%
)) else set args=

:_killButton DON'T CALL
REM %killButton% 1 4 5 2 3 6 - to kill any or all buttons
set killButton=for %%# in (1 2) do if %%#==2 ( for /f "tokens=*" %%1 in ("^!args^!") do (%\n%
	for %%i in (%%~1) do (%\n%
		for %%j in ("^!button[%%i].sprite^!") do set "button.display=^!button.display:%%~j=^!"%\n%
		set "button[%%i].clicked="%\n%
		set "button[%%i].xmin="%\n%
		set "button[%%i].xmax="%\n%
		set "button[%%i].ymin="%\n%
		set "button[%%i].ymax="%\n%
		set "button[%%i].sprite="%\n%
		set "button.list=^!button.list:%%i =^!"%\n%
	)%\n%
)) else set args=

:_makeSlider DON'T CALL
rem %makeSlider% x y length min max sliderColor positionColor clickID
set "map=c+(d-c)*(v-a)/(b-a)" & rem required for slider
set makeSlider=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-8" %%1 in ("^!args^!") do (%\n%
	set "bar=" ^& set "slider.value=0"%\n%
	for /l %%i in (1,1,%%~3) do set "bar=^!bar^!Ä"%\n%
	set /a "slider.xmin=%%~1", "slider.xmax=%%~1 + %%~3 - 1", "slider.ymin=%%~2 - 2", "slider.ymax=%%~2", "slider.position=%%~1 + 1", "back=%%~3 + 2"%\n%
	set "slider.display=[38;5;%%~6m[%%~2;%%~1H[AÚ^!bar^!¿[^!back^!D[B(0t(B^!bar^!(0u(B[^!back^!D[BÀ^!bar^!Ù[0m[38;5;%%~7m[%%~2;^^^!slider.position^^^!HÛ[0m"%\n%
	set "slider.clicked=if ^^^!mouse.c^^^! equ %%~8 if ^^^!mouse.x^^^! geq %%~1 if ^^^!mouse.x^^^! leq ^!slider.xmax^! if ^^^!mouse.y^^^! geq ^!slider.ymin^! if ^^^!mouse.y^^^! leq ^!slider.ymax^!"%\n%
	set "move.slider=v=mouse.X, a=slider.Xmin, b=slider.Xmax, c=%%~4, d=%%~5, slider.value=%map%, slider.position=mouse.x + 1"%\n%
)) else set args=

:_makeInputBar DON'T CALL
rem %makeInputBar% rtnVar x y length TextColor BackColor clickID
set makeInputBar=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7" %%1 in ("^!args^!") do (%\n%
	set "bar=" ^& set "str=x%%~1"%\n%
	set /a "length=0", "back=%%~4 - 2"%\n%
	set /a "input.xmin=%%~2", "input.xmax=%%~2 + %%~4", "input.ymin=%%~3 - 1", "input.ymax=%%~3 + 1", "input.position.y=%%~3 + 1", "input.position.x=%%~2 + 1"%\n%
	for /l %%b in (6,-1,0) do set /a "length|=1<<%%b" ^& for %%c in (^^!length^^!) do if "^!str:~%%c,1^!" equ "" set /a "length&=~1<<%%b"%\n%
	for /l %%i in (3,1,%%~4) do set "bar=^!bar^!Ä"%\n%
	set "input.display=[A[38;5;%%~6m[%%~3;%%~2HÚ^!bar^!¿[%%~4D[B³[^!back^!C³[%%~4D[BÀ^!bar^!Ù[0m"%\n%
	set "input.clicked=if ^^^!mouse.c^^^! equ %%~7 if ^^^!mouse.Y^^^! geq ^!input.Ymin^! if ^^^!mouse.Y^^^! leq ^!input.Ymax^! if ^^^!mouse.X^^^! geq ^!input.Xmin^! if ^^^!mouse.X^^^! leq ^!input.Xmax^! set /p "%%~1=[38;5;%%~5m[^^!input.position.y^^!;^^!input.position.x^^!HInput: ""%\n%
)) else set args=
goto :eof

:___________________________________________________________________________________________
:buildSketch to avoid illegal characters, decode from base64 to bat file,. open and inspect sketch.bat
if exist Sketch.bat goto :eof
echo=QGVjaG8gb2ZmICYgc2V0bG9jYWwgZW5hYmxlRGVsYXllZEV4cGFuc2lvbiAmIHNldCAiKD0ocmVuICIlfm54MCIgLXQuYmF0ICYgcmVuICJMaWJyYXJ5LmJhdCIgIiV+bngwIiIgJiBzZXQgIik9cmVuICIlfm54MCIgIkxpYnJhcnkuYmF0IiAmIHJlbiAtdC5iYXQgIiV+bngwIikiICYgc2V0ICJzZWxmPSV+bngwIiAmIHNldCAiZmFpbExpYj1yZW4gLXQuYmF0ICIlfm54MCIgJmVjaG8gTGlicmFyeSBub3QgZm91bmQgJiB0aW1lb3V0IC90IDMgL25vYnJlYWsgJiBleGl0Ig0KDQolKCUgJiYgKGNhbGwgOnJldmlzaW9uIDQuMS4wKXx8KCVmYWlsTGliJSkNCgljYWxsIDpzdGRsaWINCiUpJQ0KDQpwYXVzZQ==>>"encodedSketch.txt"
certutil -decode "encodedSketch.txt" "Sketch.bat"
del /q /f "encodedSketch.txt"
goto :eof

:setFont DON'T CALL
if "%~2" equ "" goto :eof
call :init_setfont
%setFont% %~1 %~2
goto :eof

:init_setfont DON'T CALL
:: - BRIEF -
::  Get or set the console font size and font name.
:: - SYNTAX -
::  %setfont% [fontSize [fontName]]
::    fontSize   Size of the font. (Can be 0 to preserve the size.)
::    fontName   Name of the font. (Can be omitted to preserve the name.)
:: - EXAMPLES -
::  Output the current console font size and font name:
::    %setfont%
::  Set the console font size to 14 and the font name to Lucida Console:
::    %setfont% 14 Lucida Console
setlocal DisableDelayedExpansion
set setfont=for /l %%# in (1 1 2) do if %%#==2 (^
%=% for /f "tokens=1,2*" %%- in ("? ^^!arg^^!") do endlocal^&powershell.exe -nop -ep Bypass -c ^"Add-Type '^
%===% using System;^
%===% using System.Runtime.InteropServices;^
%===% [StructLayout(LayoutKind.Sequential,CharSet=CharSet.Unicode)] public struct FontInfo{^
%=====% public int objSize;^
%=====% public int nFont;^
%=====% public short fontSizeX;^
%=====% public short fontSizeY;^
%=====% public int fontFamily;^
%=====% public int fontWeight;^
%=====% [MarshalAs(UnmanagedType.ByValTStr,SizeConst=32)] public string faceName;}^
%===% public class WApi{^
%=====% [DllImport(\"kernel32.dll\")] public static extern IntPtr CreateFile(string name,int acc,int share,IntPtr sec,int how,int flags,IntPtr tmplt);^
%=====% [DllImport(\"kernel32.dll\")] public static extern void GetCurrentConsoleFontEx(IntPtr hOut,int maxWnd,ref FontInfo info);^
%=====% [DllImport(\"kernel32.dll\")] public static extern void SetCurrentConsoleFontEx(IntPtr hOut,int maxWnd,ref FontInfo info);^
%=====% [DllImport(\"kernel32.dll\")] public static extern void CloseHandle(IntPtr handle);}';^
%=% $hOut=[WApi]::CreateFile('CONOUT$',-1073741824,2,[IntPtr]::Zero,3,0,[IntPtr]::Zero);^
%=% $fInf=New-Object FontInfo;^
%=% $fInf.objSize=84;^
%=% [WApi]::GetCurrentConsoleFontEx($hOut,0,[ref]$fInf);^
%=% If('%%~.'){^
%===% $fInf.nFont=0; $fInf.fontSizeX=0; $fInf.fontFamily=0; $fInf.fontWeight=0;^
%===% If([Int16]'%%~.' -gt 0){$fInf.fontSizeY=[Int16]'%%~.'}^
%===% If('%%~/'){$fInf.faceName='%%~/'}^
%===% [WApi]::SetCurrentConsoleFontEx($hOut,0,[ref]$fInf);}^
%=% Else{(''+$fInf.fontSizeY+' '+$fInf.faceName)}^
%=% [WApi]::CloseHandle($hOut);^") else setlocal EnableDelayedExpansion^&set arg=
endlocal &set "setfont=%setfont%"
if !!# neq # set "setfont=%setfont:^^!=!%"
exit /b
