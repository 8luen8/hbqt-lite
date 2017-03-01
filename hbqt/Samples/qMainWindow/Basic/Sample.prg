// *---------------------------------------------------------------------------*
//
//   hbqt - Samples
//
//   Copyright (C) 2012-2017 hbQT
//   Author: M.,Ronaldo <ronmesq@gmail.com>
//
//   www: http://harbour-project.org
//   github: https://github.com/MRonaldo/hbqt-lite
//   google groups: https://groups.google.com/forum/#!forum/qtcontribs
//
// *---------------------------------------------------------------------------*

#include "hbqtgui.ch"

PROCEDURE Main ()

   lOCAL oApp
   LOCAL oWindow

   /* hbqt_errorsys() */
   hbqt_errorsys()

   oApp := QApplication():new()

   oWindow := QMainWindow():new()

   oWindow:setWindowTitle("hbqt: QMainWindow Basic")

   oWindow:resize(800,600)

   oWindow:show()

   oApp:exec()

RETURN
