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
#include "hbclass.ch"

PROCEDURE Main ()

   lOCAL oApp
   LOCAL oWindow

   oApp := QApplication():new()

   oWindow := qt_FMain():new()

   oWindow:show()

   oApp:exec()

RETURN

// *---------------------------------------------------------------------------*
// CLASS qt_FMain
// *---------------------------------------------------------------------------*
CREATE CLASS qt_FMain INHERIT hb_QMainWindow

   DATA oMenuBar
   DATA oMenu1
   DATA oActionNew
   DATA oActionOpen
   DATA oActionSave
   DATA oMenu2
   DATA oActionCut
   DATA oActionCopy
   DATA oActionPaste
   DATA oMenu3
   DATA oActionAbout
   DATA oActionAboutxH
   DATA oActionAboutCC
   DATA oActionAboutQt
   DATA oActionAbout_hbqt
   DATA oToolBar
   DATA oStatusBar

   EXPORTED:

   METHOD Init( ... )
   METHOD defineProperties
   METHOD createMenuBar
   METHOD createToolBar
   METHOD createStatusBar
   METHOD defineEvents
   METHOD closeMainWindow
   METHOD showMessage

   PROTECTED:

END CLASS

// *---------------------------------------------------------------------------*
// qt_FMain:Init( ... )
// *---------------------------------------------------------------------------*
METHOD Init(...) CLASS qt_FMain

   /* qt_FMain */
   ::super:Init( ... )
   ::defineProperties()
//   ::createMenuBar()
//    ::createToolBar()
//   ::createStatusBar()
// ::defineEvents()

RETURN self

/*
  o m�todo 'defineProperties' define as propriedades
  'title' e 'size' da janela principal
*/
METHOD defineProperties () CLASS qt_FMain

   ::setWindowTitle("hbqt: QMainWindow")
   ::resize(800,600)

RETURN self

/*
  o m�todo 'createMenuBar' cria os menus da janela principal
  e configura a a��o que cada item do menu ir� executar
*/
METHOD createMenuBar () CLASS qt_FMain

   ::oMenuBar := ::menuBar()

   ::oMenu1 := ::oMenuBar:addMenu("&Arquivo")

   ::oActionNew := ::oMenu1:AddAction(QIcon():new("images\new.png"),"&Novo")
   ::oActionNew:setStatusTip("Executa a op��o NOVO")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( "Arquivo/Novo" ) } )

   ::oActionOpen := ::oMenu1:AddAction(QIcon():new("images\open.png"),"&Abrir")
   ::oActionOpen:setStatusTip("Executa a op��o ABRIR")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( "Arquivo/Abrir" ) } )

   ::oActionSave := ::oMenu1:AddAction(QIcon():new("images\save.png"),"&Salvar")
   ::oActionSave:setStatusTip("Executa a op��o SALVAR")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( "Arquivo/Salvar" ) } )

   ::oMenu2 := ::oMenuBar:AddMenu("&Editar")

   ::oActionCut := ::oMenu2:AddAction(QIcon():New("images\cut.png"),"&Recortar")
   ::oActionCut:setStatusTip("Executa a op��o RECORTAR")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( "Editar/Recortar" ) } )

   ::oActionCopy := ::oMenu2:AddAction(QIcon():new("images\copy.png"),"&Copiar")
   ::oActionCopy:setStatusTip("Executa a op��o COPIAR")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( "Editar/Copiar" ) } )

   ::oActionPaste := ::oMenu2:AddAction(QIcon():New("images\paste.png"),"C&olar")
   ::oActionPaste:setStatusTip("Executa a op��o COLAR")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( "Editar/Colar" ) } )

   ::oMenu3 := ::oMenuBar:AddMenu("&Sobre")

   ::oActionAbout := ::oMenu3:AddAction("&Exemplo")
   ::oActionAbout:setStatusTip("Exibe informa��es sobre este exemplo")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( "Sample for qtMainWindow" ) } )

   ::oActionAboutxH := ::oMenu3:AddAction("&[x]Harbour")
   ::oActionAboutxH:setStatusTip("Exibe a vers�o do Harbour/xHarbour")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( version() ) } )


   ::oActionAboutCC := ::oMenu3:AddAction("&C/C++ Compiler")
   ::oActionAboutCC:setStatusTip("Exibe informa��es sobre o compilador C/C++")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( hb_compiler() ) } )

   ::oActionAboutQt := ::oMenu3:AddAction("&Qt Framework")
   ::oActionAboutQt:setStatusTip("Exibe informa��es sobre o Qt Framework")
   ::oActionAboutxH:connect( "triggered()", { || QApplication():aboutQt() } )

   ::oActionAbout_hbqt := ::oMenu3:AddAction("&Qt5xHb")
   ::oActionAbout_hbqt:setStatusTip("Exibe a vers�o da hbqt")
   ::oActionAboutxH:connect( "triggered()", { || ::showMessage( version() ) } )

RETURN self

/*
  o m�todo 'createToolBar' cria a barra de ferramentas da janela principal
  e configura a a��o que cada bot�o ir� executar
*/
METHOD createToolBar () CLASS qt_FMain

   ::oToolBar := ::addToolBar("")

   ::oToolBar:addAction(::oActionNew)
   ::oToolBar:addAction(::oActionOpen)
   ::oToolBar:addAction(::oActionSave)

   ::oToolBar:addSeparator()

   ::oToolBar:addAction(::oActionCut)
   ::oToolBar:addAction(::oActionCopy)
   ::oToolBar:addAction(::oActionPaste)

RETURN self

/*
  o m�todo 'createStatusBar' cria a barra de status
*/
METHOD createStatusBar () CLASS qt_FMain

   ::oStatusBar := ::statusBar()

RETURN self

/*
 o m�todo 'defineEvent' define os eventos que ser�o processados
*/
METHOD defineEvents () CLASS qt_FMain

   ::onCloseEvent({|w,e|::CloseMainWindow(w,e)})

RETURN self

/*
 o m�todo 'closeMainWindow' confirma, com o usu�rio, se quer
 realmente sair do programa
*/
METHOD closeMainWindow (w,e) CLASS qt_FMain

   LOCAL oMB
   LOCAL nRet
   LOCAL oEvent := QEvent():newfrom(e)

   oMB := QMessageBox():new(QMessageBox_Question,;
                            "Aten��o",;
                            "Quer realmente sair do programa ?" + str( w ),;
                            QMessageBox_Yes+QMessageBox_No,;
                            self,;
                            Qt_Dialog+Qt_MSWindowsFixedSizeDialogHint)

   nRet := oMB:exec()

   oMB:delete()

   IF nRet == QMessageBox_Yes
      oEvent:accept()
   endif

   IF nRet == QMessageBox_No
      oEvent:ignore()
   endif

RETURN .T.

/*
  o m�todo 'showMessage' exibe uma janela com uma mensagem,
  usando a classe QMessageBox
*/
METHOD showMessage (cText) CLASS qt_FMain

   LOCAL oMB

   oMB := QMessageBox():new(QMessageBox_Information,"Informa��o",cText,QMessageBox_Ok,self)

   oMB:exec()

   oMB:delete()

RETURN NIL
