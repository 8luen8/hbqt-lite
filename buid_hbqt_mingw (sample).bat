@ECHO OFF

set QT_PATH=C:\Qt\Qt5.6.0\5.6\mingw
set QTBIN=%QT_PATH%\bin
set QTCONTRIBS_REBUILD=yes
set QTDIR=%QT_PATH%
set QTHOME=%QT_PATH%

set HB_COMPILER=mingw
set HB_QT_MAJOR_VER=5
set HB_QTPATH=%QTBIN%
set HB_WITH_QT=%QT_PATH%\include

GOTO Build_MingW

:Build_MingW
set HB_COMPILER_VER=0480
set HB_PATH=C:\hb_mingw
set PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Util;C:\hb_make\comp\MingW\bin
GOTO end

:end
set ERRORLOG=C:\hb_error.log
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

CD hbqt
hbmk2 -info -jobs=16 hbqt.hbp

@ECHO *
%HB_INSTALL_PREFIX%\bin\HARBOUR.exe -build
@ECHO *

PAUSE
