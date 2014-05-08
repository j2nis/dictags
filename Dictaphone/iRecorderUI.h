/*
 File :     iRecorderUI.h
 Module :   UI/Includes
 Purpose :  Interface d'un gestionnaire graphique de dictaphone
 -----------------------------------------------------------------------------*/

#ifndef __RECORDERUI_
#define __RECORDERUI_

/*------------------------------------------------------------------------------
 iRecorderUI
	Interface d'un gestionnaire graphique de dictaphone
 -----------------------------------------------------------------------------*/
@protocol iRecorderUI <NSObject>
/*------------------------------------------------------------------------------
 iInit
    Initialisation de l'objet
 -----------------------------------------------------------------------------*/
-(void)iInit;
/*------------------------------------------------------------------------------
 iStart
    Démarre graphiquement un enregistrement
 -----------------------------------------------------------------------------*/
-(void)iStart;
/*------------------------------------------------------------------------------
 iPause
    Met en pause graphiquement un enregistrement
 -----------------------------------------------------------------------------*/
-(void)iPause;
/*------------------------------------------------------------------------------
 iStop
    Arrête graphiquement un enregistrement
 -----------------------------------------------------------------------------*/
-(void)iStop;
/*------------------------------------------------------------------------------
 iGetViewController
	Retourne le vue controlleur d'enregistrement
 UIViewController [ret]
	ViewController à afficher
 -----------------------------------------------------------------------------*/
-(UIViewController *)iGetViewController;

@end

/*------------------------------------------------------------------------------
 RecorderUI_Create
    Crée une instance iRecorderUI
 id<iAppManager> [ret]
    Instance iRecorderUI
 -----------------------------------------------------------------------------*/
id<iRecorderUI> RecorderUI_Create();

#endif // __RECORDERUI_
