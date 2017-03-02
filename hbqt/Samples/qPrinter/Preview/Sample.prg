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

   SET( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   /* hbqt_errorsys() */
   hbqt_errorsys()

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle("hbqt: Print Preview")
      :resize( 1024, 768 )
   END WITH

   WITH OBJECT oButton := QPushButton():new( "Print Preview", oWindow )
      :resize(250,30)
      :move( 20, 20 )
      :setIcon( QIcon( "..\..\images\Tool_Print_32.png" ) )
      :connect( "clicked()", { || Print_Preview( oWindow ) } )
   END WITH

   WITH OBJECT oWindow
      :setCentralWidget( oButton )
      :show()
   END WITH

   oApp:exec()

RETURN

STATIC FUNCTION Print_Preview( oWindow )

   LOCAL oPrinter
   LOCAL oPrintPreview

   WITH OBJECT oPrinter := QPrinter():new(QPrinter_HighResolution)
      :setPageOrientation( QPrinter_Portrait )
      :setPageSize( QPageSize( QPrinter_A4 ) )
   END WITH

   WITH OBJECT oPrintPreview := QPrintPreviewDialog( oPrinter, oWindow )
      :setwindowicon( QIcon( "..\..\images\Tool_Print_32.png" ) )
      :resize(940,720)
      :connect( "paintRequested(QPrinter*)", { |oPrn| report_Paint_Request( oPrn ) } )
      :setAttribute( Qt_WA_DeleteOnClose, .T. )
   END WITH

   oPrintPreview:exec()

RETURN NIL

STATIC FUNCTION report_Paint_Request( oPrinter )

   LOCAL i
   LOCAL oPainter

   WITH OBJECT oPainter := QPainter():new()
      :begin( oPrinter )
      FOR i := 1 to 4
         :drawText( 10, 10, "Page " + StrZero( i, 5) )
         :drawText( INT( ( oPrinter:width() / 2 ) - 48 ), INT( oPrinter:height() / 2 ), "Hello world!" )
         :drawRect( 99, 99, oPrinter:width()-240, oPrinter:height()-240)
         :drawEllipse( 99, 99, oPrinter:width()-240, oPrinter:height()-240)
         IF i < 4
            oPrinter:newPage()
         ENDIF
      NEXT
   END WITH
   oPainter:end()

RETURN NIL
