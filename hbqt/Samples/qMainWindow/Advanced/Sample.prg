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

#include "hbclass.ch"
#include "hbqtgui.ch"
#include "hbtrace.ch"

PROCEDURE Main ()

   LOCAL oApp
   LOCAL oWindow

   REQUEST HB_CODEPAGE_UTF8
   REQUEST HB_CODEPAGE_UTF8EX

   SET( _SET_CODEPAGE, "UTF8EX" )
   hb_cdpSelect( "UTF8EX" )

   /* hbqt_errorsys() */
   hbqt_errorsys()

   oApp := QApplication():new()

   oWindow := qt_FMain():new()

   oWindow:show()

   oApp:exec()

RETURN

// *---------------------------------------------------------------------------*
// CLASS qt_FMain
// *---------------------------------------------------------------------------*
CREATE CLASS qt_FMain INHERIT hb_QMainWindow

   EXPORTED:

   DATA   oMainMenu

   DATA   hActions                         INIT hb_hash()
   DATA   hMenuItems                       INIT hb_hash()
   DATA   hObjects                         INIT hb_hash()
   DATA   hStatusBarItems                  INIT hb_hash()

   METHOD Init( ... )

   PROTECTED:

   METHOD Actions_create()
   METHOD Actions_update()
   METHOD Menu_create()
   METHOD PopUpMenu_create()
   METHOD StatusBar_create()
   METHOD StatusBar_update()
   METHOD ToolBar_create()

   METHOD setProperties()
   METHOD showMessage(cText)

   METHOD __onExit( oEvent )

END CLASS

// *---------------------------------------------------------------------------*
// qt_FMain:Init( ... )
// *---------------------------------------------------------------------------*
METHOD Init(...) CLASS qt_FMain

   /* qt_FMain */
   ::super:Init( ... )

   /* setProperties */
   ::setProperties()

   /* hActions */
   ::Actions_create()

   /* oMainMenu */
   ::Menu_create()

   /* ::hObjects['TBarActions'] */
   ::ToolBar_create()

   /* PopUpMenu_create */
   ::PopUpMenu_create()

   /* ::hObjects['StatusBar'] */
   ::StatusBar_create()

   /* QEvent_ContextMenu */
   ::connect( QEvent_ContextMenu,    { |qEvent| ::hObjects['PopUpMenu']:exec( qEvent:globalPos() ) } )

   /* QEvent_Close */
   ::connect( QEvent_Close,          { |oEvent| ::__onExit( oEvent ) } )

   /* ::hObjects['Timer'] */
   WITH OBJECT ::hObjects['Timer'] := QTimer()
      :connect( "timeout()", { || ::StatusBar_update() } )
      :start( 1500 )
   END WITH

   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:setProperties()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:setProperties()

   /* WindowTitle */
   ::setWindowTitle("hbqt: QMainWindow Advanced")

   /* resize */
   ::resize(800,600)

   /* ContextMenuPolicy */
   ::setContextMenuPolicy( Qt_NoContextMenu )

   /* QIcon */
   ::setwindowicon( QIcon( '..\..\Images\Imatech.png' ) )

   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:Actions_create()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:Actions_create()

   WITH OBJECT ::hActions[ "File_New" ] := QAction( ::tr( "New" ), Self )
      :setIcon( QIcon( "..\..\images\new.png" ) )
      :setTooltip( ::tr( "File/New" ) )
      :connect( "triggered()", { || ::showMessage( "File/New" ) } )
   END WITH

   WITH OBJECT ::hActions[ "File_Open" ] := QAction( ::tr( "Open" ), Self )
      :setIcon( QIcon( "..\..\images\Open.png" ) )
      :setTooltip( ::tr( "File/Open" ) )
      :connect( "triggered()", { || ::showMessage( "File/Open" ) } )
   END WITH

   WITH OBJECT ::hActions[ "File_Save" ] := QAction( ::tr( "Save" ), Self )
      :setIcon( QIcon( "..\..\images\Save.png" ) )
      :setTooltip( ::tr( "File/Save" ) )
      :connect( "triggered()", { || ::showMessage( "File/Save" ) } )
   END WITH

   WITH OBJECT ::hActions[ "File_Exit" ] := QAction( ::tr( "Close" ) + CHR( 9 ) + "Alt+F4", Self )
      :setIcon( QIcon( '..\..\images\tool_ExitApp_32.png' ) )
      :setTooltip( ::tr( "File/Close" ) )
      :connect( "triggered()", { || ::close() } )
   END WITH

   WITH OBJECT ::hActions[ "Edit_cut" ] := QAction( ::tr( "Cut" ), Self )
      :setIcon( QIcon( '..\..\images\cut.png' ) )
      :setTooltip( ::tr( "Edit/Cut" ) )
      :connect( "triggered()", { || ::showMessage( "Edit/Cut" ) } )
   END WITH

   WITH OBJECT ::hActions[ "Edit_copy" ] := QAction( ::tr( "copy" ), Self )
      :setIcon( QIcon( '..\..\images\copy.png' ) )
      :setTooltip( ::tr( "Edit/Copy" ) )
      :connect( "triggered()", { || ::showMessage( "Edit/copy" ) } )
   END WITH

   WITH OBJECT ::hActions[ "Edit_paste" ] := QAction( ::tr( "paste" ), Self )
      :setIcon( QIcon( '..\..\images\paste.png' ) )
      :setTooltip( ::tr( "Edit/paste" ) )
      :connect( "triggered()", { || ::showMessage( "Edit/paste" ) } )
   END WITH

   WITH OBJECT ::hActions[ "Help_Sample" ] := QAction( ::tr( "Sample" ), Self )
      :setTooltip( ::tr( "Help/Sample" ) )
      :connect( "triggered()", { || ::showMessage( "Sample for QtMainWindow" ) } )
   END WITH

   WITH OBJECT ::hActions[ "Help_Harbour" ] := QAction( ::tr( "Harbour" ), Self )
      :setTooltip( ::tr( "Help/Harbour" ) )
      :connect( "triggered()", { || ::showMessage( version() ) } )
   END WITH

   WITH OBJECT ::hActions[ "Help_compiler" ] := QAction( ::tr( "compiler" ), Self )
      :setTooltip( ::tr( "Help/compiler" ) )
      :connect( "triggered()", { || ::showMessage( hb_compiler() ) } )
   END WITH

   WITH OBJECT ::hActions[ "Help_Qt_Framework" ] := QAction( ::tr( "Qt Framework" ), Self )
      :setTooltip( ::tr( "Help/Qt Framework" ) )
      :connect( "triggered()", { || QApplication():aboutQt() } )
   END WITH

   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:Menu_create()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:Menu_create()

   /* oMainMenu */
   ::oMainMenu := ::menuBar()

   /* hMenuItems[ "File" ] */
   WITH OBJECT ::hMenuItems[ "File" ] := QMenu( ::oMainMenu )
      :setTitle( ::tr( "&File" ) )
      :addAction( ::hActions[ "File_New" ] )
      :addAction( ::hActions[ "File_Open" ] )
      :addAction( ::hActions[ "File_Save" ] )
      :addSeparator()
      :addAction( ::hActions[ "File_Exit" ] )
   END WITH
   ::oMainMenu:addMenu( ::hMenuItems[ "File" ] )

   /* hMenuItems[ "Edit" ] */
   WITH OBJECT ::hMenuItems[ "Edit" ] := QMenu( ::oMainMenu )
      :setTitle( ::tr( "&Edit" ) )
      :addAction( ::hActions[ "Edit_cut" ] )
      :addAction( ::hActions[ "Edit_copy" ] )
      :addAction( ::hActions[ "Edit_paste" ] )
   END WITH
   ::oMainMenu:addMenu( ::hMenuItems[ "Edit" ] )

   /* hMenuItems[ "Help" ] */
   WITH OBJECT ::hMenuItems[ "Help" ] := QMenu( ::oMainMenu )
      :setTitle( ::tr( "&Help" ) )
      :addAction( ::hActions[ "Help_Sample" ] )
      :addAction( ::hActions[ "Help_Harbour" ] )
      :addAction( ::hActions[ "Help_compiler" ] )
      :addSeparator()
      :addAction( ::hActions[ "Help_Qt_Framework" ] )
   END WITH
   ::oMainMenu:addMenu( ::hMenuItems[ "Help" ] )

   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:ToolBar_create()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:ToolBar_create()

   /* ::hObjects['TBar_File'] */
   WITH OBJECT ::hObjects['TBar_File'] := QToolbar( "Actions Bar", Self )
      /* Configure */
      :setToolButtonStyle( Qt_ToolButtonTextUnderIcon )
      :setIconSize( QSize( 48, 48 ) )
      :setFloatable( .T. )
      :setMovable( .T. )
      /* Actions */
      :addAction( ::hActions[ "File_New" ] )
      :addAction( ::hActions[ "File_Open" ] )
      :addAction( ::hActions[ "File_Save" ] )
   END WITH
   ::addToolBar( Qt_TopToolBarArea, ::hObjects['TBar_File'] )

   /* ::hObjects['TBar_Edit'] */
   WITH OBJECT ::hObjects['TBar_Edit'] := QToolbar( "Tolls Bar", Self )
      /* Configure */
      :setToolButtonStyle( Qt_ToolButtonTextUnderIcon )
      :setIconSize( QSize( 48, 48 ) )
      :setFloatable( .T. )
      :setMovable( .T. )
      /* Actions */
      :addAction( ::hActions[ "Edit_cut" ] )
      :addAction( ::hActions[ "Edit_copy" ] )
      :addAction( ::hActions[ "Edit_paste" ] )
   END WITH
   ::addToolBar( Qt_TopToolBarArea, ::hObjects['TBar_Edit'] )

   /* ::hObjects['TBar_Exit'] */
   WITH OBJECT ::hObjects['TBar_Exit'] := QToolbar( "Exit Bar", Self )
      /* Configure */
      :setToolButtonStyle( Qt_ToolButtonTextUnderIcon )
      :setIconSize( QSize( 48, 48 ) )
      :setFloatable( .T. )
      :setMovable( .T. )
      /* Actions */
      :addAction( ::hActions[ "File_Exit" ] )
   END WITH
   ::addToolBar( Qt_TopToolBarArea, ::hObjects['TBar_Exit'] )

   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:PopUpMenu_create()           /* Must call after ::ToolBar_create() */
// *---------------------------------------------------------------------------*
METHOD QT_FMain:PopUpMenu_create()

   /* ::hObjects['PopUpMenu'] */
   WITH OBJECT ::hObjects['PopUpMenu'] := ::createPopupMenu( Self )
      :addSeparator()
      :addAction( ::hActions[ "Edit_cut" ] )
      :addAction( ::hActions[ "Edit_copy" ] )
      :addAction( ::hActions[ "Edit_paste" ] )
      :addSeparator()
      :addAction( ::hActions[ "File_Exit" ] )
   END WITH

   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:StatusBar_create()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:StatusBar_create()

   LOCAL oFont
   LOCAL oImage := Array( 4 )

   oFont := ::font()
   oFont:setBold( .T. )

   oImage[1] := '<img src=' + "..\..\images\led_off_20.png" + '>'
   oImage[2] := '<img src=' + "..\..\images\led_blue_20.png" + '>'
   oImage[3] := '<img src=' + "..\..\images\led_green_20.png" + '>'
   oImage[4] := '<img src=' + "..\..\images\led_orange_20.png" + '>'

   WITH OBJECT ::hStatusBarItems[ "Message" ] := QLabel( Self )
      :setAlignment( Qt_AlignCenter )
      :setText( 'Advanced: Sample for QtMainWindow' )
   END WITH
   WITH OBJECT ::hStatusBarItems[ "Caps_Lock" ] := QLabel( Self )
      :setAlignment( Qt_AlignCenter )
      :setText( 'Caps Lock ' + IIF( .T., oImage[2], oImage[1] ) )
   END WITH
   WITH OBJECT ::hStatusBarItems[ "Num_Lock" ] := QLabel( Self )
      :setAlignment( Qt_AlignCenter )
      :setText( 'Num Lock ' + IIF( .T., oImage[3], oImage[1] ) )
   END WITH
   WITH OBJECT ::hStatusBarItems[ "Key_Insert" ] := QLabel( Self )
      :setAlignment( Qt_AlignCenter )
      :setText( 'Insert ' + IIF( .T., oImage[4], oImage[1] ) )
   END WITH

   /* ::hObjects['StatusBar'] */
   WITH OBJECT ::hObjects['StatusBar'] := ::statusBar( Self )
      :addPermanentWidget( ::hStatusBarItems[ "Message" ], 10 )
      :addPermanentWidget( ::hStatusBarItems[ "Caps_Lock" ], 1 )
      :addPermanentWidget( ::hStatusBarItems[ "Num_Lock" ], 1 )
      :addPermanentWidget( ::hStatusBarItems[ "Key_Insert" ], 1 )
      :setMaximumHeight( 32 )
      :setMinimumHeight( 32 )
      :setSizeGripEnabled( .T. )
      :setStyleSheet( "QStatusBar::item { border: 1px solid darkgray; border-radius: 3px; }" )
   END WITH

   ::setStatusBar( ::hObjects['StatusBar'] )

   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:Actions_update()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:Actions_update()
   // Code to update menus
   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:StatusBar_update()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:StatusBar_update()
   // Code to update StatusBar
   RETURN( Self )

// *---------------------------------------------------------------------------*
// QT_FMain:__onExit()
// *---------------------------------------------------------------------------*
METHOD QT_FMain:__onExit( oEvent )

   /* if !... clipboard:clear() */
   IF !( hb_osIsWinVista() )
      QApplication():clipboard:clear( QClipboard_Clipboard )
      QApplication():clipboard:clear( QClipboard_Selection )
   ENDIF

   /* close objects */
   ::hObjects['Timer']:stop()

   /* oEvent:Accept() */
   oEvent:Accept()

RETURN( .F. )

// *---------------------------------------------------------------------------*
// QT_FMain:showMessage(cText)
// *---------------------------------------------------------------------------*
METHOD QT_FMain:showMessage(cText)

   LOCAL oMB

   oMB := QMessageBox():new(QMessageBox_Information,"Information",cText,QMessageBox_Ok,self)

   oMB:exec()

RETURN NIL
