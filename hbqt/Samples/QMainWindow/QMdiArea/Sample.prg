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

   LOCAL i
   LOCAL oApp
   LOCAL oWindow
   LOCAL oMdiArea
   LOCAL hMdiWindow := hb_Hash()

   REQUEST HB_CODEPAGE_UTF8
   REQUEST HB_CODEPAGE_UTF8EX

   Set( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   /* hbqt_errorsys() */
   hbqt_errorsys()

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle( "hbqt: QMdiArea" )
      :resize( 920, 720 )
   END WITH

   WITH OBJECT oMdiArea := QMdiArea():new()
   END WITH
   oWindow:setCentralWidget(oMdiArea)

   FOR i := 1 TO 9
      WITH OBJECT hMdiWindow[i] := QMdiSubWindow():new(oMdiArea)
         :setWindowTitle("MDI Window " + Str( i ) )
         :resize(320,240)
      END WITH
   NEXT

   oWindow:show()

   oApp:exec()

RETURN
