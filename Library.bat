(call :buildSketch) & exit
:revision
	set "revision=3.28"
	set "libraryError=False"
	for /f "tokens=4-5 delims=. " %%i in ('ver') do set "winVERSION=%%i.%%j"
	if %revision:.=% lss %revisionRequired:.=% (
		echo Updated Library.bat Required
		set "libraryError=True"
	)
	if "%winversion%" neq "10.0" (
		echo %~n0 is not supported on this version of Windows: %winVERSION%"
		set "libraryError=True"
	)
	if "%libraryError%" equ "True" (
		ren "%~nx0" "Library.bat"
		ren "temp.bat" "%self%"
		del /f /q "temp.bat"
		timeout /t 3 & exit
	)
goto :eof
:StdLib
if "%~3" neq "/debug" (
	call :setfont 8 Terminal
	call :size %~1 %~2
) else (
	@echo on
	call :setfont 14 Consolas
	call :size 150 100
)
rem "pixel"
set "pixel=Û"
rem newLine
(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
rem ESC
(for /f %%a in ('echo prompt $E^| cmd') do set "esc=%%a" ) & <nul set /p "=!esc![?25l"
if /i "%~3" equ "/extlib" (
	rem Backspace
	for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
	rem BEL (sound)
	for /f %%i in ('forfiles /m "%~nx0" /c "cmd /c echo 0x07"') do set "BEL=%%i"
	rem Carriage Return  0x0D  decimal 13
	for /f %%A in ('copy /z "%~dpf0" nul') do set "CR=%%A"
	rem Tab 0x09
	for /f "delims=" %%T in ('forfiles /p "%~dp0." /m "%~nx0" /c "cmd /c echo(0x09"') do set "TAB=%%T"
)
goto :eof

:size
if "%~2" equ "" goto :eof
set /a "wid=%~1, hei=%~2"
mode !wid!,!hei!
goto :eof

:setFont
if "%~2" equ "" goto :eof
call :init_setfont
%setFont% %~1 %~2
goto :eof

:math
set /a "PI=(35500000/113+5)/10, HALF_PI=(35500000/113/2+5)/10, TWO_PI=2*PI, PI32=PI+PI_div_2, neg_PI=PI * -1, neg_HALF_PI=HALF_PI *-1"
set "_SIN=a-a*a/1920*a/312500+a*a/1920*a/15625*a/15625*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000"
set "sin=(a=(x * 31416 / 180)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), %_SIN%) / 10000"
set "cos=(a=(15708 - x * 31416 / 180)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), %_SIN%) / 10000"
set "sinr=(a=(x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), %_SIN%) / 10000"
set "cosr=(a=(15708 - x)%%62832, c=(a>>31|1)*a, a-=(((c-47125)>>31)+1)*((a>>31|1)*62832)  +  (-((c-47125)>>31))*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), %_SIN%) / 10000"
set "Sqrt(N)=( x=(N)/(11*1024)+40, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2 )"
set "Sign=1 / (x & 1)"
set "Abs=(((x)>>31|1)*(x))"
set "dist(x2,x1,y2,y1)=( @=x2-x1, $=y2-y1, ?=(((@>>31|1)*@-(($>>31|1)*$))>>31)+1, ?*(2*(@>>31|1)*@-($>>31|1)*$-((@>>31|1)*@-($>>31|1)*$)) + ^^^!?*((@>>31|1)*@-($>>31|1)*$-((@>>31|1)*@-($>>31|1)*$*2)) )"
set "avg=(x&y)+(x^y)/2"
goto :eof
:misc
set "rndsign=$o=(^!random^!%%3+-1),out=(((((~(0-$o)>>31)&1)&((~($o-0)>>31)&1))*($o+def))|((~(((~(0-$o)>>31)&1)&((~($o-0)>>31)&1))&1)*($o*num)))"
set "gravity=grav=1, a#+=grav, v#+=a#, a#*=0, #+=v#"
set "swap(x,y)=t=x, x=y, y=t"
set "getState=a*8+b*4+c*2+d*1"
set "map=x2+(y2-x2)*(v-x1)/(y1-x1)"
set "map=(c)+((d)-(c))*((v)-(a))/((b)-(a))"
set "lerp=?=(a+c*(b-a)*10)/1000+a"
set "percentOf=p=x*y/100"
set "odds=1/((((^!random^!%%100)-x)>>31)&1)"
set "every=1/(((~(0-(frames%%n))>>31)&1)&((~((frames%%n)-0)>>31)&1))"
set "smoothStep=(3*100 - 2 * x) * x/100 * x/100"
set "bitColor=C=((r)*6/256)*36+((g)*6/256)*6+((b)*6/256)+16"
set "infiniteLoop=for /l %%# in () do "
set "throttle=for /l %%# in (1,?,1000000) do rem"
set "RCX=1/((((x-wid)>>31)&1)^(((0-x)>>31)&1))"
set "RCY=1/((((x-hei)>>31)&1)^(((0-x)>>31)&1))"
set "inScr=((wid-x-1)>>31)|((hei-y-2)>>31)"
set "edgeCase=1/(((x-0)>>31)&1)|((~(x-wid)>>31)&1)|(((y-0)>>31)&1)|((~(y-=hei)>>31)&1)"
set "rndBetween=(^!random^! %% (x*2+1) + -x)"
set "fib=?=c=a+b, a=b, b=c"
set "rndRGB=r=^!random^! %% 255, g=^!random^! %% 255, b=^!random^! %% 255"
set "mouseBound=1/(((~(mouseY-ma)>>31)&1)&((~(mb-mouseY)>>31)&1)&((~(mouseX-mc)>>31)&1)&((~(md-mouseX)>>31)&1))"goto :eof
:shapes
set "SQ(x)=x*x"
set "CUBE(x)=x*x*x"
set "pmSQ(x)=x+x+x+x"
set "pmREC(l,w)=l+w+l+w"
set "pmTRI(a,b,c)=a+b+c"
set "areaREC(l,w)=l*w"
set "areaTRI(b,h)=(b*h)/2"
set "areaTRA(b1,b2,h)=(b1*b2)*h/2"
set "volBOX(l,w,h)=l*w*h"
goto :eof
:algorithicConditions
set "LSS(x,y)=(((x-y)>>31)&1)"                     &REM <
set "LEQ(x,y)=((~(y-x)>>31)&1)"                    &REM <=
set "GTR(x,y)=(((y-x)>>31)&1)"                     &REM >
set "GEQ(x,y)=((~(x-y)>>31)&1)"                    &REM >=
set "EQU(x,y)=(((~(y-x)>>31)&1)&((~(x-y)>>31)&1))" &REM ==
set "NEQ(x,y)=((((x-y)>>31)&1)|(((y-x)>>31)&1))"   &REM !=
set "AND(b1,b2)=(b1&b2)"                           &REM &&
set "OR(b1,b2)=(b1|b2)"                            &REM ||
set "XOR(b1,b2)=(b1^b2)"                           &REM ^
set "TERN(bool,v1,v2)=((bool*v1)|((~bool&1)*v2))"  &REM ?:
goto :eof
:turtleFunctions
set /a "DFX=%~1", "DFY=%~2", "DFA=%~3"
set "forward=DFX+=(?+1)*^!cos:x=DFA^!, DFY+=(?+1)*^!sin:x=DFA^!"
set "turnLeft=DFA-=?"
set "turnRight=DFA+=?"
set "push=sX=DFX, sY=DFY, sA=DFA"
set "pop=DFX=sX, DFY=sY, DFA=sA"
set "draw=?=^!?^!%esc%[^!DFY^!;^!DFX^!H%pixel%"
set "home=DFX=0, DFY=0, DFA=0"
set "cent=DFX=wid/2, DFY=hei/2"
set "penDown=for /l %%a in (1,1,#) do set /a "^!forward:?=1^!" ^& set "turtleGraphics=%esc%[^!DFY^!;^!DFX^!H%pixel%""
goto :eof
:mouseMacros
set "allowMouseClicks=for /f "tokens=1-3" %%W in ('"%temp%\Mouse.exe"') do set /a "mouseC=%%W,mouseX=%%X,mouseY=%%Y""
set "clearMouse=set "mouseX=" ^& set "mouseY=" ^& set "mouseC=""
goto :eof
:quikzip
set "ZIP=tar -cf ?.zip ?"
set "unZIP=tar -xf ?.zip"
set "unZIP_PS=powershell.exe -nologo -noprofile -command "Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('?', '.');"
goto :eof

:colorRange
REM 1, 3, 5, 15, 17, 51, 85, 255
set "range=%~1"
for /l %%a in (0,%range%,255) do set /a "colors+=1" & set "color[!colors!]=%esc%[38;2;255;%%a;0m"
for /l %%a in (255,-%range%,0) do set /a "colors+=1" & set "color[!colors!]=%esc%[38;2;%%a;255;0m"
for /l %%a in (0,%range%,255) do set /a "colors+=1" & set "color[!colors!]=%esc%[38;2;0;255;%%am"
for /l %%a in (255,-%range%,0) do set /a "colors+=1" & set "color[!colors!]=%esc%[38;2;0;%%a;255m"
for /l %%a in (0,%range%,255) do set /a "colors+=1" & set "color[!colors!]=%esc%[38;2;%%a;0;255m"
for /l %%a in (255,-%range%,0) do set /a "colors+=1" & set "color[!colors!]=%esc%[38;2;255;0;%%am"
goto :eof

:loadArray
	set "i=1" & set "array[!i!]=%load:.=" & set /a i+=1 & set "array[!i!]=%"
goto :eof

:macros
:_point
rem %point% x y <rtn> _$_
set .=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	set "_$_=^!_$_^!!esc![%%2;%%1H%pixel%!esc![0m"%\n%
)) else set args=

:_plot
rem %plot% x y 0-255 CHAR <rtn> _$_
set plot=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "_$_=^!_$_^!!esc![%%2;%%1H!esc![38;5;%%3m%%~4!esc![0m"%\n%
)) else set args=

:_RGBpoint
rem %RGBpoint% x y 0-255 0-255 0-255 CHAR
set rgbpoint=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set "_$_=^!_$_^!!esc![%%2;%%1H!esc![38;2;%%3;%%4;%%5m%pixel%!esc![0m"%\n%
)) else set args=

:_download
rem %download% url file
set download=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	Powershell.exe -command "(New-Object System.Net.WebClient).DownloadFile('%%~1','%%~2')"%\n%
)) else set args=

:_ZIP
rem %zip% file.ext zipFileName
set ZIP=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
	tar -cf %%~2.zip %%~1%\n%
)) else set args=

:_UNZIP
rem %unzip% zipFileName
set UNZIP=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	tar -xf %%~1.zip%\n%
)) else set args=

:_License DO NOT use unless you are DONE editing your code.
rem %license% "mySignature" NOTE: You MUST add at least 1 signature to your script ":::mySignature" without the quotes
set License=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (%\n%
	for /f "tokens=*" %%x in ("^!self^!") do set /a "x=%%~zx"%\n%
	for /f "tokens=1,2 delims=:" %%a in ('findstr /n ":::" "%~F0"') do (%\n%
        if "%%b" equ %%1 set /a "i+=1", "x+=i+%%a"%\n%
	)%\n%
	if not exist "^!temp^!\%~n0_cP.txt" echo ^^!x^^!^>"^!temp^!\%~n0_cP.txt"%\n%
	if exist "^!temp^!\%~n0_cP.txt" ^<"^!temp^!\%~n0_cP.txt" set /p "g="%\n%
	if "^!x^!" neq "^!g^!" start /b "" cmd /c del "%~f0" ^& exit%\n%
)) else set args=

:_injectLineIntoFile
rem %injectLineIntoFile:?=FILE NAME.EXT% "String":Line#
set injectLineIntoFile=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3 delims=:" %%1 in ("?:^!args^!") do (%\n%
	for /f "usebackq tokens=*" %%i in ("%%~1") do (%\n%
		set /a "linesInFile+=1"%\n%
		if ^^!linesInFile^^! equ %%~3 echo %%~2^>^>-temp-.txt%\n%
		echo %%i^>^>-temp-.txt%\n%
	)%\n%
	ren "%%~1" "deltmp.txt" ^& ren "-temp-.txt" "%%~1" ^& del /f /q "deltmp.txt"%\n%
)) else set args=

:_getLen
rem %getlen% "string" <rtn> $length
set getLen=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (set "$_str=%%~1" ^& set "$length="^&(for %%P in (64 32 16 8 4 2 1) do if "^!$_str:~%%P,1^!" NEQ "" set /a "$length+=%%P" ^& set "$_str=^!$_str:~%%P^!") ^& set /a "$length-=2")) else set args=

:_pad
rem %pad% "string".int <rtn> $padding
set "$paddingBuffer=                                                                                "
set pad=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3 delims=." %%x in ("^!args^!") do (%\n%
    set "$padding="^&set "$_str=%%~x"^&set "len="%\n%
    (for %%P in (32 16 8 4 2 1) do if "^!$_str:~%%P,1^!" NEQ "" set /a "len+=%%P" ^& set "$_str=^!$_str:~%%P^!") ^& set /a "len-=2"%\n%
    set /a "s=%%~y-len"^&for %%a in (^^!s^^!) do set "$padding=^!$paddingBuffer:~0,%%a^!"%\n%
    if "%%~z" neq "" set "%%~z=^!$padding^!"%\n%
)) else set args=

:_$string_
rem %string_ "string" <rtn> $_len, $_rev $_upp $_low
set $string_=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1 delims=" %%1 in ("^!args^!") do (%\n%
    set "$_str=%%~1" ^& set "$_strC=%%~1" ^& set "$_upp=^!$_strC:~1^!" ^& set "$_low=^!$_strC:~1^!"%\n%
    for %%P in (64 32 16 8 4 2 1) do if "^!$_str:~%%P,1^!" NEQ "" set /a "$_len+=%%P" ^& set "$_str=^!$_str:~%%P^!"%\n%
    set "$_str=^!$_strC:~1^!"%\n%
    for /l %%a in (^^!$_len^^!,-1,0) do set "$_rev=^!$_rev^!^!$_str:~%%~a,1^!"%\n%
    for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "$_upp=^!$_upp:%%i=%%i^!"%\n%
    for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "$_low=^!$_low:%%i=%%i^!"%\n%
)) else set args=

:_memset
rem %memset% var "replacement" "length"
set memset=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%0 in ("^!args^!") do ( for /f "tokens=1,2 delims=+" %%3 in ("%%~0") do (%\n%
	set /a "$l=%%~4, $k=%%~2", "ep=%%~4+$k" ^& set "$tr=^!%%~3^!" ^& set "$b="%\n%
	for %%j in (^^!$k^^!) do ( for /l %%a in (1,1,%%~j) do set "$b=^!$b^!%%~1"%\n%
		if "%%~4" equ "" ( set "%%~3=^!$b^!^!$tr:~%%~j^!"%\n%
		) else for /f "tokens=1,2" %%e in ("^!$l^! ^!ep^!") do (%\n%
			set "%%~3=^!$tr:~0,%%~e^!^!$b^!^!$tr:~%%~f^!"%\n%
))))) else set args=

:_translate
rem %translate% x Xoffset y Yoffset
set translate=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set /a "%%~1+=%%~2, %%3+=%%~4"%\n%
)) else set args=

:_BVector
rem x y theta(0-360) magnitude(rec.=4 max) <rtn> %~1[]./BV[].
set BVector=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
		   set /a "%%~1.x=^!random^! %% wid + 1"%\n%
		   set /a "%%~1.y=^!random^! %% hei + 1"%\n%
	if /i "%%~2" neq "RAD" (%\n%
		   set /a "%%~1.t=^!random^! %% 360"%\n%
	) else set /a "%%~1.t=^!random^! %% TWO_PI"%\n%
		   set /a "%%~1.m=^!random^! %% 4 + 1"%\n%
		   set /a "%%~1.i=^!random^! %% 3 + 1"%\n%
		   set /a "%%~1.j=^!random^! %% 3 + 1"%\n%
		   set /a "bvr=^!random^! %% 255","bvg=^!random^! %% 255","bvb=^!random^! %% 255"%\n%
		   set "%%~1.rgb=^!bvr^!;^!bvg^!;^!bvb^!"%\n%
		   for %%a in (bvr bvg bvb) do set "%%a="%\n%
)) else set args=

:_lerpRGB
rem %lerpRGB% rgb1 rgb2 1-100 <rtn> $r $g $b
set lerpRGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "a=r[%%~1], b=r[%%~2], c=%%~3, $r=^!lerp^!"%\n%
	set /a "a=g[%%~1], b=g[%%~2], c=%%~3, $g=^!lerp^!"%\n%
	set /a "a=b[%%~1], b=b[%%~2], c=%%~3, $b=^!lerp^!"%\n%
)) else set args=

:_getDistance
rem %getDistance% x2 x1 y2 y1 <rtnVar>
set getDistance=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set /a "%%5=( ?=((((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4))))>>31)+1, ?*(2*((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))-(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4))))) + ^^^!?*(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))-(((((%%1 - %%2))>>31|1)*((%%1 - %%2)))-((((%%3 - %%4))>>31|1)*((%%3 - %%4)))*2)) )"%\n%
)) else set args=

:_exp
rem %exp% num pow <rtnVar>
for /l %%a in (1,1,1095) do set "pb=!pb!x*"
set exp=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "x=%%~1","$p=%%~2*2-1"%\n%
	for %%a in (^^!$p^^!) do set /a "%%~3=^!pb:~0,%%a^!"%\n%
)) else set args=

:_circle
rem %circle% x y ch cw <rtn> $circle
set circle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$circle="%\n%
	for /l %%a in (0,3,360) do (%\n%
		set /a "xa=%%~3 * ^!cos:x=%%a^! + %%~1", "ya=%%~4 * ^!sin:x=%%a^! + %%~2"%\n%
		set "$circle=^!$circle^!%esc%[^!ya^!;^!xa^!H%pixel%"%\n%
	)%\n%
	set "$circle=^!$circle^!%esc%[0m"%\n%
)) else set args=

:_rect
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
	set "$rect=^!$rect^!%esc%[0m"%\n%
)) else set args=

:_line
rem line x0 y0 x1 y1 <rtn> $line
set line=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set "$line="%\n%
	set /a "xa=%%~1", "ya=%%~2", "xb=%%~3", "yb=%%~4", "dx=%%~3 - %%~1", "dy=%%~4 - %%~2"%\n%
	if ^^!dy^^! lss 0 ( set /a "dy=-dy", "stepy=-1" ) else ( set "stepy=1" )%\n%
	if ^^!dx^^! lss 0 ( set /a "dx=-dx", "stepx=-1" ) else ( set "stepx=1" )%\n%
	set /a "dx<<=1", "dy<<=1"%\n%
	if ^^!dx^^! gtr ^^!dy^^! (%\n%
		set /a "fraction=dy - (dx >> 1)"%\n%
		for /l %%x in (^^!xa^^!,^^!stepx^^!,^^!xb^^!) do (%\n%
			if ^^!fraction^^! geq 0 set /a "ya+=stepy", "fraction-=dx"%\n%
			set /a "fraction+=dy"%\n%
			set "$line=^!$line^!%esc%[^!ya^!;%%xH%pixel%"%\n%
		)%\n%
	) else (%\n%
		set /a "fraction=dx - (dy >> 1)"%\n%
		for /l %%y in (^^!ya^^!,^^!stepy^^!,^^!yb^^!) do (%\n%
			if ^^!fraction^^! geq 0 set /a "xa+=stepx", "fraction-=dy"%\n%
			set /a "fraction+=dx"%\n%
			set "$line=^!$line^!%esc%[%%y;^!xa^!H%pixel%"%\n%
		)%\n%
	)%\n%
	set "$line=^!$line^!%esc%[0m"%\n%
)) else set args=

:_$bezier
rem %bezier% x1 y1 x2 y2 x3 y3 x4 y4 length
set bezier=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%1 in ("^!args^!") do (%\n%
	set "$bezier=" ^& set "c=0"%\n%
	set /a "px[0]=%%~1","py[0]=%%~2", "px[1]=%%~3","py[1]=%%~4", "px[2]=%%~5","py[2]=%%~6", "px[3]=%%~7","py[3]=%%~8"%\n%
	for /l %%# in (1,1,%%~9) do (%\n%
		set /a "vx[1]=(px[0]+c*(px[1]-px[0])*10)/1000+px[0]","vy[1]=(py[0]+c*(py[1]-py[0])*10)/1000+py[0]","vx[2]=(px[1]+c*(px[2]-px[1])*10)/1000+px[1]","vy[2]=(py[1]+c*(py[2]-py[1])*10)/1000+py[1]","vx[3]=(px[2]+c*(px[3]-px[2])*10)/1000+px[2]","vy[3]=(py[2]+c*(py[3]-py[2])*10)/1000+py[2]","vx[4]=(vx[1]+c*(vx[2]-vx[1])*10)/1000+vx[1]","vy[4]=(vy[1]+c*(vy[2]-vy[1])*10)/1000+vy[1]","vx[5]=(vx[2]+c*(vx[3]-vx[2])*10)/1000+vx[2]","vy[5]=(vy[2]+c*(vy[3]-vy[2])*10)/1000+vy[2]","vx[6]=(vx[4]+c*(vx[5]-vx[4])*10)/1000+vx[4]","vy[6]=(vy[4]+c*(vy[5]-vy[4])*10)/1000+vy[4]","c+=1"%\n%
		set "$bezier=^!$bezier^!%esc%[^!vy[6]^!;^!vx[6]^!H%pixel%"%\n%
	)%\n%
)) else set args=

:_RGBezier
rem %bezier% x1 y1 x2 y2 x3 y3 x4 y4 length
set RGBezier=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-9" %%1 in ("^!args^!") do (%\n%
	set "$bezier=" ^& set "c=0"%\n%
	set /a "px[0]=%%~1","py[0]=%%~2", "px[1]=%%~3","py[1]=%%~4", "px[2]=%%~5","py[2]=%%~6", "px[3]=%%~7","py[3]=%%~8"%\n%
	for /l %%m in (1,1,%%~9) do (%\n%
		set /a "vx[1]=(px[0]+c*(px[1]-px[0])*10)/1000+px[0]","vy[1]=(py[0]+c*(py[1]-py[0])*10)/1000+py[0]","vx[2]=(px[1]+c*(px[2]-px[1])*10)/1000+px[1]","vy[2]=(py[1]+c*(py[2]-py[1])*10)/1000+py[1]","vx[3]=(px[2]+c*(px[3]-px[2])*10)/1000+px[2]","vy[3]=(py[2]+c*(py[3]-py[2])*10)/1000+py[2]","vx[4]=(vx[1]+c*(vx[2]-vx[1])*10)/1000+vx[1]","vy[4]=(vy[1]+c*(vy[2]-vy[1])*10)/1000+vy[1]","vx[5]=(vx[2]+c*(vx[3]-vx[2])*10)/1000+vx[2]","vy[5]=(vy[2]+c*(vy[3]-vy[2])*10)/1000+vy[2]","vx[6]=(vx[4]+c*(vx[5]-vx[4])*10)/1000+vx[4]","vy[6]=(vy[4]+c*(vy[5]-vy[4])*10)/1000+vy[4]","c+=1"%\n%
		set "$bezier=^!$bezier^!^!color[%%m]^!%esc%[^!vy[6]^!;^!vx[6]^!H%pixel%"%\n%
	)%\n%
)) else set args=

:_arc
rem arc x y size DEGREES(0-360) arcRotationDegrees(0-360) lineThinness color
set arc=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7" %%1 in ("^!args^!") do (%\n%
	if "%%~7" equ "" ( set "hue=30" ) else ( set "hue=%%~7")%\n%
    for /l %%e in (%%~4,%%~6,%%~5) do (%\n%
		set /a "_x=%%~3 * ^!cos:x=%%~e^! + %%~1", "_y=%%~3 * ^!sin:x=%%~e^! + %%~2"%\n%
		^!plot^! ^^!_x^^! ^^!_y^^! ^^!hue^^! %pixel%%\n%
	)%\n%
)) else set args=

:_plot_HSL_RGB
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
	^!rgbplot^! %%1 %%2 ^^!R^^! ^^!G^^! ^^!B^^!%\n%
)) else set args=

:_plot_HSV_RGB
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
	^!rgbplot^! %%1 %%2 ^^!R^^! ^^!G^^! ^^!B^^!%\n%
)) else set args=

:_ifAnd
rem %ifAnd% value LO HI RETURNVAR
set ifAnd=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set /a "aux=(%%~2-%%~1)*(%%~1-%%~3), %%~4=(aux-1)/aux"%\n%
)) else set args=

:_clamp
rem clamp x min max RETURNVAR
set clamp=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	set /a "xx=%%~1", "yy=%%2", "zz=%%3"%\n%
	for /f "tokens=1-3" %%x in ("^!xx^! ^!yy^! ^!zz^!") do (%\n%
			   if %%x lss %%y ( set /a "xx=%%y"%\n%
		) else if %%x gtr %%z ( set /a "xx=%%z" )%\n%
	)%\n%
	for /f "tokens=1" %%x in ("^!xx^!") do (%\n%
		if "%%4" neq "" ( set /a "%%4=%%x" ) else ( echo=%%x)%\n%
	)%\n%
)) else set args=

:__map
rem _map min max X RETURNVAR
set _map=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-4" %%1 in ("^!args^!") do (%\n%
	%= Scale, bias and saturate x to 0..100 range =%%\n%
	set /a "clamped=((%%3) - %%1) * 100 ^/ (%%2 - %%1) + 1"%\n%
	for /f "tokens=1" %%c in ("^!clamped^!") do ^!clamp^! %%c 0 100 CLAMPED_x %\n%
	%= Evaluate polynomial =%%\n%
	set /a "ss=^(3*100 - 2 * CLAMPED_x^) * CLAMPED_x^/100 * CLAMPED_x^/100"%\n%
	for /f "tokens=1" %%x in ("^!ss^!") do (%\n%
		if "%%4" neq "" ( set "%%4=%%x" ) else ( echo=%%x)%\n%
	)%\n%
)) else set args=

:_FNCross
rem FNcross x1 y1 x2 y2 RETURNVAR
set FNcross=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set /a "%%~5=%%~1*%%~4 - %%~2*%%~3"%\n%
)) else set args=

:_intersect
rem CROSS VECTOR PRODUCT algorithm
rem intersect x1 y1 x2 y2 x3 y3 x4 y4 RETURNVAR RETURNVAR
set intersect=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-10" %%a in ("^!args^!") do (%\n%
	%= x1-a y1-b x2-c y2-d x3-e y3-f x4-g y4-h x-i y-j =%%\n%
	!^FNcross^! %%a %%b %%c %%d FNx%\n%
	!^FNcross^! %%e %%f %%g %%h FNy%\n%
	set /a "_t1=%%a-%%c", "_t2=%%c-%%d", "_t3=%%e - %%g", "_t4=%%f-%%h"%\n%
	for /f "tokens=1-4" %%1 in ("^!_t1^! ^!_t2^! ^!_t3^! ^!_t4^!") do ^!FNcross^! %%1 %%2 %%3 %%4 det%\n%
	for /f "tokens=1-6" %%1 in ("^!_t1^! ^!_t2^! ^!_t3^! ^!_t4^! ^!FNx^! ^!FNy^!") do (%\n%
		^!FNcross^! %%5 %%1 %%6 %%3 _x1%\n%
		set /a "%%i=_x1 / det"%\n%
		^!FNcross^! %%5 %%1 %%6 %%3 _y1%\n%
		set /a "%%j=_y1 / det"%\n%
	)%\n%
)) else set args=

:_HSLline
rem HSLline x1 y1 x2 y2 0-360 0-10000 0-10000
set HSLline=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-7" %%1 in ("^!args^!") do (%\n%
	set /a "xa=%%~1", "ya=%%~2", "xb=%%~3", "yb=%%~4", "dx=%%~3 - %%~1", "dy=%%~4 - %%~2"%\n%
	for /f "tokens=1-2" %%j in ("^!dx^! ^!dy^!") do (%\n%
		if %%~k lss 0 ( set /a "dy=-%%~k", "stepy=-1" ) else ( set "stepy=1" )%\n%
		if %%~j lss 0 ( set /a "dx=-%%~j", "stepx=-1" ) else ( set "stepx=1" )%\n%
		set /a "dx<<=1", "dy<<=1"%\n%
	)%\n%
	for /f "tokens=1-8" %%a in ("^!dx^! ^!dy^! ^!xa^! ^!xb^! ^!ya^! ^!yb^! ^!stepx^! ^!stepy^!") do (%\n%
		if %%~a gtr %%~b (%\n%
			set /a "fraction=%%~b - (%%~a >> 1)"%\n%
			for /l %%x in (%%~c,%%~g,%%~d) do (%\n%
				for /f "tokens=1" %%j in ("^!fraction^!") do if %%~j geq 0 set /a "ya+=%%~h", "fraction-=%%~a"%\n%
				set /a "fraction+=%%~b"%\n%
				for /f "tokens=1" %%j in ("^!ya^!") do (%\n%
					if 0 leq %%x if 0 leq %%~j ^!plot_HSL_RGB^! %%x %%~j %%~5 %%~6 %%~7%\n%
				)%\n%
			)%\n%
		) else (%\n%
			set /a "fraction=%%~a - (%%~b >> 1)"%\n%
			for /l %%y in (%%~e,%%~h,%%~f) do (%\n%
				for /f "tokens=1" %%j in ("^!fraction^!") do if %%~j geq 0 set /a "xa+=%%~g", "fraction-=%%~b"%\n%
				set /a "fraction+=%%~a"%\n%
				for /f "tokens=1" %%j in ("^!xa^!") do (%\n%
					if 0 leq %%~j if 0 leq %%y ^!plot_HSL_RGB^! %%~j %%y %%~5 %%~6 %%~7%\n%
				)%\n%
			)%\n%
		)%\n%
	)%\n%
)) else set args=

goto :eof

:buildSketch
if exist Sketch.bat goto :eof
for %%i in (
"QGVjaG8gb2ZmICYgc2V0bG9jYWwgZW5hYmxlRGVsYXllZEV4cGFuc2lvbg0KDQpz"
"ZXQgInJldmlzaW9uUmVxdWlyZWQ9My4yOCINCnNldCAgIm9wZW5MaWI9KHJlbiAi"
"JX5ueDAiIHRlbXAuYmF0ICYgcmVuICJMaWJyYXJ5LmJhdCIgIiV+bngwIiINCnNl"
"dCAiY2xvc2VMaWI9cmVuICIlfm54MCIgIkxpYnJhcnkuYmF0IiAmIHJlbiB0ZW1w"
"LmJhdCAiJX5ueDAiKSIgJiBzZXQgInNlbGY9JX5ueDAiDQooMj5udWwgJW9wZW5M"
"aWIlICYmICggY2FsbCA6cmV2aXNpb24gKSB8fCAoIHJlbiB0ZW1wLmJhdCAiJX5u"
"eDAiICYgZWNobyBMaWJyYXJ5LmJhdCBSZXF1aXJlZCAmIHRpbWVvdXQgL3QgMyAm"
"IGV4aXQpKQ0KCWNhbGwgOnN0ZGxpYiAxMDAgMTAwDQolY2xvc2VMaWIlICAmJiAo"
"IGNscyAmIGdvdG8gOnNldHVwKQ0KOnNldHVwDQoNCnBhdXNlID4gbnVsICYgZXhp"
"dCAvYg=="
) do echo %%~i>>"encodedSketch.txt"
certutil -decode "encodedSketch.txt" "Sketch.bat"
del /q /f "encodedSketch.txt"
goto :eof

:mouse
    if exist "%temp%\mouse.exe" call :mouseMacros & goto :eof
    for %%a in (
		"TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        "AAAAAAAAAAAAAAAAgAAAAA4fug4AtAnNIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5v"
        "dCBiZSBydW4gaW4gRE9TIG1vZGUuDQ0KJAAAAAAAAABQRQAATAECAAAAAAAAAAAA"
        "AAAAAOAADwMLAQYAAAAAAAAAAAAAAAAAQBEAAAAQAAAAIAAAAABAAAAQAAAAAgAA"
        "BAAAAAAAAAAEAAAAAAAAAFAhAAAAAgAAAAAAAAMAAAAAABAAABAAAAAAEAAAEAAA"
        "AAAAABAAAAAAAAAAAAAAACAgAAA8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        "AAAAAAAAAABcIAAALAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC50ZXh0AAAA"
        "ABAAAAAQAAAAAgAAAAIAAAAAAAAAAAAAAAAAACAAAGAuZGF0YQAAAFABAAAAIAAA"
        "UgEAAAAEAAAAAAAAAAAAAAAAAABAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABVieWB7AgAAACQjUX6UOgs"
        "AAAAg8QED79F/lAPv0X8UA+2RfpQuAAgQABQ6IgBAACDxBC4AAAAAOkAAAAAycNV"
        "ieWB7CQAAACQuPb///9Q6GwBAACJRfy4AAAAAIlF3I1F+FCLRfxQ6FwBAACLRfiD"
        "yBCD4L+D4N9Qi0X8UOhOAQAAi0XchcAPhAUAAADpnAAAAI1F9FC4AQAAAFCNReBQ"
        "i0X8UOgvAQAAD7dF4IP4Ag+FcwAAAItF6IP4AbgAAAAAD5TAiUXchcAPhA8AAACL"
        "RQi5AQAAAIgI6SMAAACLReiD+AK4AAAAAA+UwIlF3IXAD4QKAAAAi0UIuQIAAACI"
        "CItF3IXAD4QdAAAAi0UIg8ACD79N5GaJCItFCIPAAoPAAg+/TeZmiQjpVP///4tF"
        "+FCLRfxQ6JUAAADJwwAAAFWJ5YHsFAAAAJC4AAAAAIlF7LgAAAMAULgAAAEAUOh9"
        "AAAAg8QIuAEAAABQ6HcAAACDxASNRexQuAAAAABQjUX0UI1F+FCNRfxQ6GEAAACD"
        "xBSLRfRQi0X4UItF/FDoXf7//4PEDIlF8ItF8FDoRgAAAIPEBMnDAP8lXCBAAAAA"
        "/yV0IEAAAAD/JXggQAAAAP8lfCBAAAAA/yWAIEAAAAD/JWAgQAAAAP8lZCBAAAAA"
        "/yVoIEAAAAD/JWwgQAAAACVkICVkICVkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        "iCAAAAAAAAAAAAAAtCAAAFwgAACgIAAAAAAAAAAAAAD9IAAAdCAAAAAAAAAAAAAA"
        "AAAAAAAAAAAAAAAAvyAAAMggAADVIAAA5iAAAPYgAAAAAAAACiEAABkhAAAqIQAA"
        "OyEAAAAAAAC/IAAAyCAAANUgAADmIAAA9iAAAAAAAAAKIQAAGSEAACohAAA7IQAA"
        "AAAAAG1zdmNydC5kbGwAAABwcmludGYAAABfY29udHJvbGZwAAAAX19zZXRfYXBw"
        "X3R5cGUAAABfX2dldG1haW5hcmdzAAAAZXhpdABrZXJuZWwzMi5kbGwAAABHZXRT"
        "dGRIYW5kbGUAAABHZXRDb25zb2xlTW9kZQAAAFNldENvbnNvbGVNb2RlAAAAUmVh"
        "ZENvbnNvbGVJbnB1dEEAAAAA"
) do echo %%~a>>cMouse.txt
certutil -decode cMouse.txt %temp%\mouse.exe
del /f /q cmouse.txt
call :mouseMacros
goto :eof

:init_setfont
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
