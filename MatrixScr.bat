@Echo Off & CD "%~dp0"
cls & title Matrix Select
	
	Set "AlignFile=%~dpnx0"

    Setlocal DisableDelayedExpansion

    (Set LF=^


    %= NewLine =%)

    Set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

%= cursor Positiong bookends used to prevent ansi escape code disrupting macro during definition =%
	Set "[=["
	Set "]=H"

%= Color Macro Variables =%

	Set @P=for /L %%n in (1 1 2) do if %%n==2 (%\n%
		For /F "tokens=1,2,3 delims=, " %%G in ("!argv!") do (%\n%
			Echo(![!%%G!]!!%%I!!%%H!!Off!^&^&Endlocal%\n%
		) %\n%
	) ELSE setlocal enableDelayedExpansion ^& set argv=, 

	Setlocal EnableDelayedExpansion
	Set /A Red=31,Green=32,Yellow=33,Blue=34,Purple=35,Cyan=36,White=37,Grey=90,Pink=91,Beige=93,Aqua=94,Magenta=95,Teal=96,Off=0,CI#=0
	For %%A in (Red,Yellow,Green,Blue,Purple,Cyan,White,Grey,Pink,Beige,Aqua,Magenta,Teal,Off) do (
		Set "%%A=[!%%A!m"
		Set /A "CI#+=1"
		Set "C#[!CI#!]=%%A"
	)
	Setlocal DisableDelayedExpansion

	Set "C1=A"
	Set "C2=B"
	Set "C3=C"
	Set "C4=D"
	Set "C5=E"
	Set "C6=F"
	Set "C7=G"
	Set "C8=H"
	Set "C9=I"
	Set "C10=J"
	Set "C11=K"
	Set "C12=L"
	Set "C13=M"
	Set "C14=N"
	Set "C15=O"
	Set "C16=P"
	Set "C17=Q"
	Set "C18=R"
	Set "C19=S"
	Set "C20=T"
	Set "C21=U"
	Set "C22=V"
	Set "C23=W"
	Set "C24=X"
	Set "C25=Y"
	Set "C26=Z"
	Set "C27=0"
	Set "C28=1"
	Set "C29=2"
	Set "C30=3"
	Set "C31=4"
	Set "C32=5"
	Set "C33=6"
	Set "C34=7"
	Set "C35=8"
	Set "C36=9"
	Set "C37=a"
	Set "C38=b"
	Set "C39=c"
	Set "C40=d"
	Set "C41=e"
	Set "C42=f"
	Set "C43=g"
	Set "C44=h"
	Set "C45=i"
	Set "C46=j"
	Set "C47=k"
	Set "C48=l"
	Set "C49=m"
	Set "C50=n"
	Set "C51=o"
	Set "C52=p"
	Set "C53=q"
	Set "C54=r"
	Set "C55=s"
	Set "C56=t"
	Set "C57=u"
	Set "C58=v"
	Set "C59=w"
	Set "C60=x"
	Set "C61=y"
	Set "C62=z"
	Set "C63=~"
	Set "C64=&"
	Set "C65=$"
	Set "C66=@"
	Set "C67=<"
	Set "C68=>"
	Set "C69=~"
	Set "C70=^"
	Set "C71=|"
	Set "C72={"
	Set "C73=}"
	Set "C74=?"
	Set "C75=/"
	Set "C76=\"
	Set "C77=["
	Set "C78=["
	Set "C79=+"
	Set "C80=-"

	If Not "%~3"=="" (
		Set "Console_Hieght=%~1"
		Set "Console_Width=%~2"
		Set "AlignFile=%~4"
		Goto :%~3
	) Else (Goto :main)

%= Subroutine to process output of wmic command into usable variables  for screen dimensions (resolution) =%

	:ChangeConsole <Lines> <Columns> <Label to Resume From> <If a 4th parameter is Defined, Aligns screen at top left>
%= Get screen Dimensions =%
	For /f "delims=" %%# in  ('"wmic path Win32_VideoController  get CurrentHorizontalResolution,CurrentVerticalResolution /format:value"') do (
		Set "%%#">nul
	)

%= Calculation of X axis relative to screen resolution and console size =%

	Set /A CentreX= ( ( CurrentHorizontalResolution / 2 ) - ( %~2 * 4 ) ) + 8

%= Sub Optimal calculation of Y axis relative to screen resolution and console size =%
	For /L %%A in (10,10,%1) DO Set /A VertMod+=1
	Set /A CentreY= ( CurrentVerticalResolution / 4 ) - ( %~1 * Vertmod )
	For /L %%B in (1,1,%VertMod%) do Set /A CentreY+= ( VertMod * 2 )

%= Optional 4th parameter can be used to align console at top left of screen instead of screen centre =%
	If Not "%~4"=="" (Set /A CentreY=0,CentreX=-8)

	Set "Console_Width=%~2"

%= Creates a batch file to reopen the main script using Call with parameters to define properties for console change and the label to resume from =%
		(
		Echo.@Mode Con: lines=%~1 cols=%~2
		Echo.@Title Rainbow Matrix
		Echo.@Call "%AlignFile%" "%~1" "%~2" "%~3" "%AlignFile%" 
		)>"%temp%\ChangeConsole.bat"

%= .Vbs script creation and launch to reopen batch with new console settings, combines with ChangeConsole.bat to control window size and position =%
		(
		Echo.Set objWMIService = GetObject^("winmgmts:\\.\root\cimv2"^)
		Echo.Set objConfig = objWMIService.Get^("Win32_ProcessStartup"^)
		Echo.objConfig.SpawnInstance_
		Echo.objConfig.X = %CentreX%
		Echo.objConfig.Y = %CentreY%
		Echo.Set objNewProcess = objWMIService.Get^("Win32_Process"^)
		Echo.intReturn = objNewProcess.Create^("%temp%\ChangeConsole.bat", Null, objConfig, intProcessID^)
		)>"%temp%\Consolepos.vbs"

%= Starts the companion batch script to Change Console properties, ends the parent =%
	Start "" "%temp%\Consolepos.vbs" & Exit

:main
%= Remainder of Script examples the usage of Subroutines and macro's =%


%= If a 4rd parameter is used, Console will be positioned at top left of screen =%

	Call :ChangeConsole 45 170 Matrix top
	
:Matrix
Setlocal enableDelayedExpansion

%= Numbers higher than actual console hieght cause the the console to scroll. the higher the number, the smoother the scroll =%
%= and the less dense the characters on screen will be. =%

	Set /A Console_Hieght*=2

%= Define menu options accessed with the choice command. Each option becomes a loop number equal to the errorlevel of the option. =%
	Set "Opt1=(W)aterfall %yellow%Matrix"
	Set "Opt2=(C)haos     %red%M%yellow%a%green%t%blue%r%purple%i%magenta%x"
	Set "Opt3=%red%(%pink%R%magenta%)%purple%a%blue%i%aqua%n%cyan%b%green%o%yellow%w %red%painting"

%= Display the menu options =%

	Set "Opt1=(W)aterfall %cyan%Matrix"
	Set "Opt2=(C)haos     %red%M%yellow%a%green%t%blue%r%purple%i%magenta%x"
	Set "Opt3=%red%(%pink%R%magenta%)%purple%a%blue%i%aqua%n%cyan%b%green%o%yellow%w %red%painting"
	Set "Opt4=(F)laming %yellow%Matrix"
	%@P% 1;1 Opt1 blue
	%@P% 2;1 Opt2 magenta
	%@P% 3;1 Opt3 aqua
	%@P% 4;1 Opt4 red
%= Force selection of valid option, goto selected option as loop# =%
	Choice /N /C WCRF /M ""
	CLS & Goto :loop%Errorlevel%

:loop1
TITLE Flow Matrix
:1loop
	For /L %%A in (1,1,125) do (
%= lower for loop end value equals faster transition, higher equals slower. Result of nCI color variable not being expanded with new value during for loop =%
		Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		%@P% !Ypos!;!Xpos! C!Char! !C#[%nCI%]!
	)
Goto :1loop

:loop2
TITLE Chaos Matrix
:2loop
	For /L %%A in (1,1,5000) do ( 
		Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[%%B]!
	)
Goto :2loop

:loop3
TITLE Rainbow Painter
	Set /A Console_Hieght=( Console_Hieght / 2 ) - 4
:3loop
	Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
	For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[%%B]!
Goto :3loop

:loop4
TITLE Flaming Matrix
Set /A Console_Height= ( ( Console_Height / 5 ) * 3 ) - 10
:4loop
	For /L %%A in (1,1,200000) do ( 
		Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[2]!
		Set /A Xpos-=1,Ypos+=1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[1]!
		Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[2]!
		Set /A Xpos-=1,Ypos+=1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[1]!
		Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[2]!
		Set /A Xpos+=1,Ypos+=1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[1]!
		Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[2]!
		Set /A Xpos+=1,Ypos-=1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[1]!
		Set /A Xpos=!random! %%!Console_Width! + 1,Ypos=!random! %%!Console_Hieght! + 1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[2]!
		Set /A Xpos-=1,Ypos-=1,Char=!random! %%80 + 1,nCI=!random! %%!CI#! + 1
		For %%B in (!nCI!) do %@P% !Ypos!;!Xpos! C!Char! !C#[1]!
	)
