// *---------------------------------------------------------------------------*
//
//   hbqt - Samples - QTableView
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
   LOCAL oTable
   LOCAL r
   LOCAL c
   LOCAL nCols := 16
   LOCAL nRows := 16 * 32

   REQUEST HB_CODEPAGE_UTF8
   REQUEST HB_CODEPAGE_UTF8EX

   SET( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   /* hbqt_errorsys() */
   hbqt_errorsys()

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle("hbqt: QTableWidget")
      :resize(800,600)
   END WITH

   WITH OBJECT oTable := QTableWidget():new( nRows, nCols, oWindow )
      :setAlternatingRowColors( .T. )
      FOR r := 1 TO nRows
         FOR c := 1 TO nCols
            :setItem( r-1, c-1, QTableWidgetItem():new(alltrim(str(r))+","+alltrim(str(c))) )
         NEXT c
      NEXT r
   END WITH

   WITH OBJECT oWindow
      :setCentralWidget( oTable )
      :show()
   END WITH

   oApp:exec()

RETURN
