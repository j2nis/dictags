/*
 File :     AppDelegate.h
 Module :   /
 Purpose :  Délégué principale de l'application
 -----------------------------------------------------------------------------*/
#import <UIKit/UIKit.h>
/* COMP */
#import "iAppManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    id<iAppManager> m_pAppManager;
}
@property (strong, nonatomic) UIWindow *window;

@end
