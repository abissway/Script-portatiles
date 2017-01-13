@echo off
cls 
color A  
cls  

:HEAD

echo =======================================
echo v1.01 (13/01/2017)
echo =======================================
rem author: Ruben de las Heras (ACPRO)

:MAIN 

rem PC 3 X=D Y=H
rem X es unidad local
rem Y es unidad servidor

call unidad.bat

CHOICE /m "Es un centre de mes d'un dia?"
  if errorlevel 2 goto PETIT
  if errorlevel 1 goto GRAN

:GRAN 

echo =========================================   
echo Data dia que vols copiar
echo =========================================  

set /p d1= Dia(dd)?
set /p m1= Mes(mm)?
set /p a1= Any(aa)?  

echo =========================================  
echo Data primer dia del centre vols copiar
echo =========================================  

set /p d= Dia(dd)?
set /p m= Mes(mm)?
set /p a= Any(aa)?

echo Carpeta 20%a%%m%%d% i dia %d1%-%m1%-20%a1%

CHOICE /m "Es correcte?"
  if errorlevel 2 goto GRAN
  if errorlevel 1 goto conti

:conti
xcopy /D:%m1%-%d1%-20%a1% /S /-Y /I %X%:\Unfors\20%a%\%m%\20%a%%m%%d% "%Y%:\Unfors plens\20%a1%\%m1%\20%a1%%m1%%d1%" 
pause
goto :copi

:PETIT
echo =================================  
echo Data que vols copiar els plens
echo =================================  

set /p d= Dia(dd)?
set /p m= Mes(mm)?
set /p a= Any(aa)?  

echo dia %d%-%m%-20%a%

CHOICE /m "Es correcte?"
  if errorlevel 2 goto PETIT
  if errorlevel 1 goto conti2

:conti2
xcopy /D:%m%-%d%-20%a% /S /-Y /I %X%:\Unfors\20%a%\%m%\20%a%%m%%d% "%Y%:\Unfors plens\20%a%\%m%\20%a%%m%%d%" 
pause

:copi
cls
echo =================================  
echo Copia els buits
echo =================================  

set aa=%date:~8,4%
set mm=%date:~3,2%
set dd=%date --date='+1 day':~0,2%
set dd_c=%DATE:~0,1%
if %dd_c% NEQ 0 set dd=%DATE:~0,2%
if %dd_c% EQU 0 set dd=%DATE:~1,1%
set /a dd=dd + 1
set N_DD=%dd% 

for /L %%i in (%dd%,1,9) do (xcopy /S /I /Y "%Y%:\Unfors buits\20%aa%\%mm%\20%aa%%mm%0%%i" %X%:\Unfors\20%aa%\%mm%\20%aa%%mm%0%%i)
for /L %%i in (%dd%,1,31) do (xcopy /S /I /Y "%Y%:\Unfors buits\20%aa%\%mm%\20%aa%%mm%%%i" %X%:\Unfors\20%aa%\%mm%\20%aa%%mm%%%i)

set mm_c=%DATE:~3,1%
  if %mm_c% NEQ 0 set mm=%DATE:~3,2%
  if %mm_c% EQU 0 set mm=%DATE:~4,1%
set /a mmm=%mm%+1 
  if %mm% equ 1 set /a mmm=02
  if %mm% equ 2 set /a mmm=03
  if %mm% equ 3 set /a mmm=04
  if %mm% equ 4 set /a mmm=05
  if %mm% equ 5 set /a mmm=06
  if %mm% equ 6 set /a mmm=07
  if %mm% equ 7 set /a mmm=08
  if %mm% equ 8 set /a mmm=09
  if %mm% equ 9 set /a mmm=10
  if %mm% equ 10 set /a mmm=11
  if %mm% equ 11 set /a mmm=12
  if %mm% equ 12 set /a mmm=01
  if %mm% equ 12 set /a aa=aa+1
  if %mmm% LSS 10 set mmm=0%mmm%

for /L %%i in (1,1,9) do (xcopy /S /Y /I "%Y%:\Unfors buits\20%aa%\%mmm%\20%aa%%mmm%0%%i" %X%:\Unfors\20%aa%\%mmm%\20%aa%%mmm%0%%i)
for /L %%i in (10,1,31) do (xcopy /S /Y /I "%Y%:\Unfors buits\20%aa%\%mmm%\20%aa%%mmm%%%i" %X%:\Unfors\20%aa%\%mmm%\20%aa%%mmm%%%i)
pause

echo =================================  
echo Copia els Manuals equips
echo =================================  
xcopy /S /I /Y /D "%Y%:\manuals equips" "%X%:\Manuals equips"

echo =================================  
echo Copia els Plantilles
echo ================================= 
pscp -pw "fernandez" jesus@192.168.1.6:"/home/rx/Unfors\ buits/Plantilles\ PECCR\ 2011/*" "%X%:\Unfors\Plantilles PECCR 2011" 
pause





