// *---------------------------------------------------------------------------*
//
//   hbqt - Samples - Print to PDF Files
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
   LOCAL oPrinter
   LOCAL oPainter
   LOCAL cPDF := "testpdf.pdf"
   LOCAL i

   REQUEST HB_CODEPAGE_UTF8
   REQUEST HB_CODEPAGE_UTF8EX

   /* hbqt_errorsys() */
   hbqt_errorsys()

   SET( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   IF FILE( cPDF )
      FERASE( cPDF )
   ENDIF

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle("hbqt: Print to PDF Files")
      :resize(800,600)
   END WITH
   oWindow:show()

   WITH OBJECT oPrinter := QPrinter():new(QPrinter_HighResolution)
      :setOutputFileName( cPDF )
   END WITH

   WITH OBJECT oPainter := QPainter():new()
      :begin(oPrinter)
      FOR i := 1 to 2
         :drawText( 10, 10, "Page " + StrZero( i, 5) )
         :drawRect( 0+100, 0+100, oPrinter:width()-100,oPrinter:height()-100)
         :drawEllipse( 0+100, 0+100, oPrinter:width()-100,oPrinter:height()-100)
         IF i < 2
            oPrinter:newPage()
         ENDIF
      NEXT
   END WITH
   oPainter:end()

   oApp:exec()

RETURN
