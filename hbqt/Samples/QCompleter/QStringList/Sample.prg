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
   LOCAL oCompleter
   LOCAL oLineEdit
   LOCAL oWords

   REQUEST HB_CODEPAGE_UTF8
   REQUEST HB_CODEPAGE_UTF8EX

   Set( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   /* hbqt_errorsys() */
   hbqt_errorsys()

   WITH OBJECT oWords := QStringList()
      :append( "Marcia" )
      :append( "Marcelo" )
      :append( "Marcelino" )
      :append( "Marcos" )
      :append( "Marcolino" )
      :append( "Maria" )
      :append( "Margarida" )
      :append( "Mario" )
      :append( "Maristela" )
      :sort()
   END WITH

   oApp := QApplication():new()

   WITH OBJECT oWindow := QMainWindow():new()
      :setWindowTitle("hbqt: QCompleter ( QStringList )")
      :resize(800,600)
   END WITH

   WITH OBJECT oCompleter := QCompleter( oWords, oWindow )
      :setCaseSensitivity(Qt_CaseInsensitive)
      :setModelSorting( QCompleter_CaseInsensitivelySortedModel )
      :setCompletionMode( QCompleter_UnfilteredPopupCompletion )
   END WITH

   WITH OBJECT oLineEdit := QLineEdit():new( oWindow )
      :resize(200,20)
      :move(20,20)
   END WITH
   oLineEdit:setCompleter(oCompleter)

   oWindow:show()

   oApp:exec()

RETURN
