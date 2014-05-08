/*
 File :     CAppManager.h
 Module :   COMP/AppManager
 Purpose :  Gestionnaire principale de l'application.
 -----------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
 CAppManager
	Gestionnaire principale de l'application.
 -----------------------------------------------------------------------------*/
@interface CAppManager : NSObject
    <iAppManager>
{
    UIWindow *m_pWindow;
	id<iRecorderUI> m_pRecorderUI;
}

@end
