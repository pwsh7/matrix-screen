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
