/*
 File :     CAppManager.m
 Module :   COMP/AppManager
 Purpose :  Gestionnaire principale de l'application.
 -----------------------------------------------------------------------------*/
/* COMP */
#import "iAppManager.h"
/* UI */
#import "iRecorderUI.h"
/* Internal */
#import "CAppManager.h"

/*------------------------------------------------------------------------------
 AppManager_Create
    Crée une instance iAppManagerÒ
 id<iAppManager> [ret]
    Instance iAppManager
 -----------------------------------------------------------------------------*/
id<iAppManager> AppManager_Create()
{
    CAppManager *pi=nil;
    @try {
        pi=[[CAppManager alloc] init];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    return pi;
}
/*------------------------------------------------------------------------------
 CAppManager
	Gestionnaire principale de l'application.
 -----------------------------------------------------------------------------*/
@implementation CAppManager
/*------------------------------------------------------------------------------
 Méthodes publiques
 -----------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
 init
 -----------------------------------------------------------------------------*/
-(id)init
{
    self=[super init];
    if (self) {
        m_pWindow=nil;
		m_pRecorderUI=nil;
    }
    return self;
}
/*------------------------------------------------------------------------------
 dealloc
    libération
 -----------------------------------------------------------------------------*/
-(void)dealloc
{
	[m_pWindow release];
	[m_pRecorderUI release];
    [super dealloc];
}
/*------------------------------------------------------------------------------
 Implémentation de iAppManager
 -----------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
 iInit
    Initialisation de l'objet
 pWindow [in]
    Fenêtre principale de l'application
 -----------------------------------------------------------------------------*/
-(void)iInit:(UIWindow *)pWindow
{
	UIApplication *app=nil;
    @try {
		app=[UIApplication sharedApplication];
		/* Status bar */
		[app setStatusBarStyle:UIStatusBarStyleLightContent];
		/* Vue d'enregistrement */
		m_pRecorderUI=RecorderUI_Create();
		[m_pRecorderUI iInit];
        m_pWindow=[pWindow retain];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}
/*------------------------------------------------------------------------------
 iStart
    Démarrage de l'application
 -----------------------------------------------------------------------------*/
-(void)iStart
{
    @try {
		m_pWindow.rootViewController=[m_pRecorderUI iGetViewController];
        [m_pWindow makeKeyAndVisible];
    }
    @catch (NSException *exception) {
		NSLog(@"Exception: %@", [exception description]);
        @throw exception;
    }
}
@end
