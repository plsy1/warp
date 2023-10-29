chcp 936
cls
@echo off & setlocal enabledelayedexpansion
goto start

:start
if not exist "warp.exe" echo 缺少 warp.exe 程序 & pause & exit
if not exist "ips-v4.txt" echo 缺少 IPV4 数据 ips-v4.txt & pause & exit
if not exist "ips-v6.txt" echo 缺少 IPV6 数据 ips-v6.txt & pause & exit
goto main

:main
title WARP Endpoint IP 一键优选脚本
set /a menu=1
echo #############################################################
echo #                WARP Endpoint IP 一键优选脚本              #
echo # 作者: MisakaNo の 小破站                                  #
echo # 博客: https://blog.misaka.rest                            #
echo # GitHub 项目: https://github.com/Misaka-blog               #
echo # GitLab 项目: https://gitlab.com/Misaka-blog               #
echo # Telegram 频道: https://t.me/misaka_noc                    #
echo # Telegram 群组: https://t.me/misaka_noc_chat               #
echo # YouTube 频道: https://www.youtube.com/@misaka-blog        #
echo #############################################################
echo.
echo 1. WARP IPv4 Endpoint IP 优选
echo 2. WARP IPv6 Endpoint IP 优选
echo -------------
echo 0. 退出
echo.
set /p menu=请输入选项 (默认%menu%):
if %menu%==0 exit
if %menu%==1 title WARP IPv4 Endpoint IP 优选 & set filename=ips-v4.txt & goto getv4
if %menu%==2 title WARP IPv6 Endpoint IP 优选 & set filename=ips-v6.txt & goto getv6
cls
goto main

:getv4
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_.=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv4
if not defined %%i.%%j.%%k.!cidr! set %%i.%%j.%%k.!cidr!=anycastip&set /a n+=1
if !n! EQU 100 goto getip
)
goto getv4

:randomcidrv4
set /a cidr=%random%%%256
goto :eof

:getv6
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_:=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv6
if not defined [%%i:%%j:%%k::!cidr!] set [%%i:%%j:%%k::!cidr!]=anycastip&set /a n+=1
if !n! EQU 100 goto getip
)
goto getv6

:randomcidrv6
set str=0123456789abcdef
set /a r=%random%%%16
set cidr=!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
goto :eof

:getip
del ip.txt > nul 2>&1
for /f "tokens=1 delims==" %%i in ('set ^| findstr =randomsort') do (
set %%i=
)
for /f "tokens=1 delims==" %%i in ('set ^| findstr =anycastip') do (
echo %%i>>ip.txt
)
for /f "tokens=1 delims==" %%i in ('set ^| findstr =anycastip') do (
set %%i=
)

warp
del ip.txt > nul 2>&1
echo 请按任意键关闭窗口
pause > nul
exit