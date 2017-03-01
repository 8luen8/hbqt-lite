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

   LOCAL oApp
   LOCAL oWindow
   LOCAL oCal

   /* hbqt_errorsys() */
   hbqt_errorsys()

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle("hbqt: QCalendarWidget")
      :resize(800,600)
   END WITH
   oWindow:show()

   WITH OBJECT oCal := QCalendarWidget():new(oWindow)
      :move(20,20)
      :resize(320,240)
      :setTooltip("QCalendarWidget")
   END WITH
   oCal:show()

   oApp:exec()

RETURN
