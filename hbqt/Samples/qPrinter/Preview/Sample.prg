// *---------------------------------------------------------------------------*
//
//   hbqt - Samples - Print Preview
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
   LOCAL oButton

   REQUEST HB_CODEPAGE_UTF8
   REQUEST HB_CODEPAGE_UTF8EX

   /* hbqt_errorsys() */
   hbqt_errorsys()

   SET( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle("hbqt: Print Preview")
      :resize(800,600)
   END WITH
   oWindow:show()

   WITH OBJECT oButton := QPushButton():new( "Print Preview", oWindow )
      :resize(250,30)
      :move( 20, 20 )
      :setIcon( QIcon( "..\..\images\Tool_Print_32.png" ) )
      :connect( "clicked()", { || Print_Preview( oWindow ) } )
   END WITH
   oButton:show()

   oApp:exec()

RETURN

STATIC FUNCTION Print_Preview( oWindow )

   LOCAL oPrintPreviewDialog

   WITH OBJECT oPrintPreviewDialog := QPrintPreviewDialog():new( oWindow )
      :setwindowicon( QIcon( "..\..\images\Tool_Print_32.png" ) )
      :resize(720,480)
   END WITH
   oPrintPreviewDialog:exec()

RETURN NIL
