/*
 File :     iAppManager,h
 Module :   COMP/Includes
 Purpose :  Interface du gestionnaire d'application
 -----------------------------------------------------------------------------*/

#ifndef __APPMANAGER_
#define __APPMANAGER_

/*------------------------------------------------------------------------------
 iAppManager
    Interface du gestionnaire d'application
 -----------------------------------------------------------------------------*/
@protocol iAppManager <NSObject>
/*------------------------------------------------------------------------------
 iInit
    Initialisation de l'objet
 pWindow [in]
    Fenêtre principale de l'application
 -----------------------------------------------------------------------------*/
-(void)iInit:(UIWindow *)pWindow;
/*------------------------------------------------------------------------------
 iStart
    Démarrage de l'application
 -----------------------------------------------------------------------------*/
-(void)iStart;

@end

/*------------------------------------------------------------------------------
 AppManager_Create
    Crée une instance iAppManagerÒ
 id<iAppManager> [ret]
    Instance iAppManager
 -----------------------------------------------------------------------------*/
id<iAppManager> AppManager_Create();

#endif // __APPMANAGER_
