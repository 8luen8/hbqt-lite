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
   LOCAL oDB
   LOCAL oModel
   LOCAL oWindow
   LOCAL oView
   LOCAL cDB := "cidades.db"

   REQUEST HB_CODEPAGE_UTF8
   REQUEST HB_CODEPAGE_UTF8EX

   SET( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   /* hbqt_errorsys() */
   hbqt_errorsys()

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle("hbqt: QTableView ( QSqlDatabase, QSqlQueryModel )")
      :resize(800,600)
   END WITH

   WITH OBJECT oDB := QSqlDatabase():addDatabase( "QSQLITE" )
      :setHostName("localhost")
      :setDatabaseName( cDB )
      :setUserName("usuario")
      :setPassword("senha")
   END WITH

   IF !( oDB:open() )
      QUIT
   ENDIF

   WITH OBJECT oModel := QSqlQueryModel():new( oWindow )
      :setQuery("SELECT * FROM cidades ORDER BY nommun")
   END WITH

   WITH OBJECT oView := QTableView( oWindow )
      :setModel( oModel )
      :hideColumn(0) /* Hide 1st Col - 'Id' */
   END WITH

   WITH OBJECT oWindow
      :setCentralWidget( oView )
      :show()
   END WITH

   oApp:exec()

RETURN
