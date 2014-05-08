/*
 File :     CRecorderUI.mm
 Module :   UI/Recorder
 Purpose :  Gestionnaire graphique d'un dictaphone
 -----------------------------------------------------------------------------*/
#import <Foundation/Foundation.h>
/* TOOLS */
#import "MacrosUI.h"
/* UI */
#import "iRecorderUI.h"
/* Internal */
#import "CRecorderUI.h"

/*------------------------------------------------------------------------------
 RecorderUI_Create
    Crée une instance iRecorderUI
 id<iAppManager> [ret]
    Instance iRecorderUI
 -----------------------------------------------------------------------------*/
id<iRecorderUI> RecorderUI_Create()
{
    CRecorderUI *pi=nil;
    @try {
        pi=[[CRecorderUI alloc] init];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    return pi;
}
/*------------------------------------------------------------------------------
 CRecorderUI
	Gestionnaire graphique d'un dictaphone
 -----------------------------------------------------------------------------*/
@implementation CRecorderUI
/*------------------------------------------------------------------------------
 Defines
 -----------------------------------------------------------------------------*/
/* UI */
#define BG_COLOR						RGB_COLOR(34, 150, 193)
#define LBL_TIME_HEIGHT					80
#define MARGIN_TOP						20
#define MARGIN_BOTTOM					20
#define LBL_FONT						\
	[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60.f]
#define IMG_RECORD_ON					@"icon_record_on"
#define IMG_RECORD_OFF					@"icon_record_off"
/* Macros */
/* Retourne un entier précédé de 0 si < 10 */
#define GET_PRINTABLE_INT(i)												\
	((i<10)?[NSString stringWithFormat:@"0%d", i]:							\
		[NSString stringWithFormat:@"%d", i])
/* Pour afficher le temps écoulé */
#define GET_ELAPSE_TIME														\
	[NSString stringWithFormat:@"%@:%@:%@", GET_PRINTABLE_INT(m_uiHours),	\
		GET_PRINTABLE_INT(m_uiMins), GET_PRINTABLE_INT(m_uiSecs)]
/*------------------------------------------------------------------------------
 Méthodes privées
 -----------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
 _ConfigView
	Configure le style graphique de la vue
 -----------------------------------------------------------------------------*/
-(void)_ConfigView
{
	UIViewController *pvc=nil;
	UIImage *pimgRecordOff=nil;
	CGRect frame;
	@try {
		/* Configuration du ViewController */
		pvc=[[UIViewController alloc] init];
		pvc.view.backgroundColor=BG_COLOR;
		/* Temps écoulé */
		m_plblTime=[[UILabel alloc] init];
		m_plblTime.backgroundColor=[UIColor clearColor];
		m_plblTime.frame=CGRectMake(0, MARGIN_TOP, WIDTH(pvc.view), LBL_TIME_HEIGHT);
		m_plblTime.textColor=[UIColor whiteColor];
		m_plblTime.textAlignment=NSTextAlignmentCenter;
		m_plblTime.font=LBL_FONT;
		m_plblTime.text=GET_ELAPSE_TIME;
		/* Bouton d'enregistrement */
		pimgRecordOff=UIIMAGE_FROM_FILE(IMG_RECORD_OFF);
		m_pbtnRecord=[UIButton buttonWithType:UIButtonTypeCustom];
		frame.size=pimgRecordOff.size;
		frame.origin=CGPointMake(
			(WIDTH(pvc.view)-pimgRecordOff.size.width)/2,
			HEIGHT(pvc.view)-pimgRecordOff.size.height-MARGIN_BOTTOM);
		m_pbtnRecord.frame=frame;
		m_pbtnRecord.backgroundColor=[UIColor clearColor];
		[m_pbtnRecord setBackgroundImage:pimgRecordOff
			forState:UIControlStateNormal];
		[m_pbtnRecord addTarget:self action:@selector(_listenUIButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
		/* Ajout des vues */
		ADD_SUBVIEW(pvc.view, m_plblTime);
		ADD_SUBVIEW(pvc.view, m_pbtnRecord);
		m_pvcCtx=pvc; pvc=nil;
    }
    @catch (NSException *exception) {
        @throw exception;
    }
	@finally {
		[pvc release];
	}
}
/*------------------------------------------------------------------------------
 _StartTimer
	Démarre le timer
 -----------------------------------------------------------------------------*/
-(void)_StartTimer
{
	@try {
		/* Changement de l'état du bouton */
		[m_pbtnRecord setBackgroundImage:UIIMAGE_FROM_FILE(IMG_RECORD_ON)
			forState:UIControlStateNormal];
		/* Nouveau timer */
		if (m_pTimer==nil) {
			m_pTimer=[NSTimer scheduledTimerWithTimeInterval:1.f target:self
				selector:@selector(_listenUITimer:) userInfo:nil repeats:YES];
		}
		[m_pTimer fire];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}
/*------------------------------------------------------------------------------
 _StopTimer
	Stop le timer
 -----------------------------------------------------------------------------*/
-(void)_StopTimer
{
	@try {
		/* Changement de l'état du bouton */
		[m_pbtnRecord setBackgroundImage:UIIMAGE_FROM_FILE(IMG_RECORD_OFF)
			forState:UIControlStateNormal];
		/* Arrêt du timer */
		[m_pTimer invalidate]; m_pTimer=nil;
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}
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
		m_pvcCtx=nil;
		m_plblTime=nil;
		m_pbtnRecord=nil;
		m_pTimer=nil;
		m_bRecording=NO;
		m_uiSecs=0;
		m_uiMins=0;
		m_uiHours=0;
		m_eStatus=eRecordStatus_Unknown;
    }
    return self;
}
/*------------------------------------------------------------------------------
 dealloc
    libération
 -----------------------------------------------------------------------------*/
-(void)dealloc
{
	[m_pvcCtx release];
	[m_plblTime release];
	[m_pbtnRecord release];
    [super dealloc];
}
/*------------------------------------------------------------------------------
 Implémentation de iAppManager
 -----------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
 iInit
    Initialisation de l'objet
 -----------------------------------------------------------------------------*/
-(void)iInit
{
    @try {
		[self _ConfigView];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}
/*------------------------------------------------------------------------------
 iStart
    Démarre graphiquement un enregistrement
 -----------------------------------------------------------------------------*/
-(void)iStart
{
    @try {
		m_bRecording=YES;
		m_eStatus=eRecordStatus_Recording;
		/* Démarrage du timer */
		[self _StartTimer];
    }
    @catch (NSException *exception) {
		NSLog(@"Exception: %@", [exception description]);
        @throw exception;
    }
}
/*------------------------------------------------------------------------------
 iPause
    Met en pause graphiquement un enregistrement
 -----------------------------------------------------------------------------*/
-(void)iPause
{
    @try {
		/* Relance du timer */
		if (m_bRecording==NO) {
			[self _StartTimer];
		} else {
			/* Pause du timer */
			[self _StopTimer];
		}
		m_eStatus=eRecordStatus_Pause;
		m_bRecording=!m_bRecording;
    }
    @catch (NSException *exception) {
		NSLog(@"Exception: %@", [exception description]);
        @throw exception;
    }
}
/*------------------------------------------------------------------------------
 iStop
    Arrête graphiquement un enregistrement
 -----------------------------------------------------------------------------*/
-(void)iStop
{
    @try {
		m_eStatus=eRecordStatus_Stop;
		m_bRecording=NO;
		m_uiSecs=0;
		m_uiMins=0;
		m_uiHours=0;;
		/* Arrêt du timer */
		[self _StopTimer];
		/* Mise à jour du temps écoulé */
		[m_plblTime setText:GET_ELAPSE_TIME];
    }
    @catch (NSException *exception) {
		NSLog(@"Exception: %@", [exception description]);
        @throw exception;
    }
}
/*------------------------------------------------------------------------------
 iGetViewController
	Retourne le vue controlleur d'enregistrement
 UIViewController [ret]
	ViewController à afficher
 -----------------------------------------------------------------------------*/
-(UIViewController *)iGetViewController
{
	UIViewController *pvcRet=nil;
    @try {
		pvcRet=m_pvcCtx;
    }
    @catch (NSException *exception) {
        @throw exception;
    }
	return pvcRet;
}
/*------------------------------------------------------------------------------
 Listerners
 -----------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
 _listenUITimer
    Méthode appelée par le timer
 -----------------------------------------------------------------------------*/
-(void)_listenUITimer:(NSTimer *)timer
{
    @try {
		m_uiSecs++;
		if (m_uiSecs==60) {
			m_uiSecs=0;
			m_uiMins++;
			if (m_uiSecs==60) {
				m_uiMins=0;
				m_uiHours++;
			}
		}
		/* Mise à jour du temps écoulé */
		[m_plblTime setText:GET_ELAPSE_TIME];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}
/*------------------------------------------------------------------------------
 _listenUITimer
    Méthode appelée par le timer
 -----------------------------------------------------------------------------*/
-(void)_listenUIButtonTouched:(id)sender
{
    @try {
		switch (m_eStatus) {
			/* Enregistrement en cours, on met en pause */
			case eRecordStatus_Recording:
				[self iPause];
				break;
			/* Enregistrement en pause, on relance */
			case eRecordStatus_Pause:
				[self iPause];
			/* Enregistrement non démarré */
			default:
				[self iStart];
				break;
		}
    }
    @catch (NSException *exception) {
		NSLog(@"Exception: %@", [exception description]);
        @throw exception;
    }
}
@end
