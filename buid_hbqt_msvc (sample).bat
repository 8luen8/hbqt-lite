@ECHO OFF
set QT_PATH=C:\Qt\Qt5.6.0\5.6\msvc2015
set QTBIN=%QT_PATH%\bin
set QTCONTRIBS_REBUILD=yes
set QTDIR=%QT_PATH%
set QTHOME=%QT_PATH%
set HB_QT_MAJOR_VER=5
set HB_QTPATH=%QTBIN%
set HB_WITH_QT=%QT_PATH%\include

IF "%VS140COMNTOOLS%" == "" GOTO Build_V120
set HB_COMPILER=msvc
set HB_COMPILER_VER=1900
set HB_PATH=C:\hb_msvc
set PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Util
CALL "%VS140COMNTOOLS%vsvars32.bat"
GOTO end

:Build_V120
IF "%VS120COMNTOOLS%" == "" GOTO Build_V110
set HB_COMPILER=msvc
REM set HB_COMPILER_VER=1800
set HB_PATH=C:\hb_msvc
set PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Util;%QT_PATH%\bin
CALL "%VS120COMNTOOLS%vsvars32.bat" x86
GOTO end

:Build_V110
IF "%VS110COMNTOOLS%" == "" GOTO Build_V100
set HB_COMPILER=msvc
REM set HB_COMPILER_VER=1700
set HB_PATH=C:\hb_msvc
set PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Util;%QT_PATH%\bin
CALL "%VS110COMNTOOLS%vsvars32.bat" x86
GOTO end

:Build_V100
IF "%VS100COMNTOOLS%" == "" GOTO Build_MingW
set HB_COMPILER=msvc
REM set HB_COMPILER_VER=1600
set HB_PATH=C:\hb_msvc
set PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Util;%QT_PATH%\bin
CALL "%VS100COMNTOOLS%vsvars32.bat" x86
GOTO end

:Build_MingW
set HB_COMPILER=mingw
set HB_COMPILER_VER=0480
set HB_PATH=C:\hb_mingw
set PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Util;C:\hb_make\comp\MingW\bin
GOTO end

:end
set ERRORLOG=C:\hb_Make\hb_error.log
set HB_BUILD_MODE=cpp
set HB_BUILD_OPTIM=yes
set HB_BUILD_PKG=yes
set HB_BUILD_STRIP=bin
set HB_INSTALL_PREFIX=%HB_PATH%
REM set HB_TIP_OPENSSL=yes
REM set HB_WITH_CURL=%HB_PATH%\curl\include
REM set HB_WITH_FREEIMAGE=%HB_PATH%\FreeImage\Dist
REM set HB_WITH_OPENSSL=%HB_PATH%\openssl\include
set HRBHOME=%HB_PATH%

set PATH=%PATH%;%HB_INSTALL_PREFIX%\bin

CD \hb_msvc
CD addons
CD hbqt
hbmk2 -info -jobs=16 hbqt.hbp

@ECHO *
%HB_INSTALL_PREFIX%\bin\HARBOUR.exe -build
@ECHO *

PAUSE
