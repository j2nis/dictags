/*
 File :     CRecorderUI.h
 Module :   UI/Recorder
 Purpose :  Gestionnaire graphique d'un dictaphone
 -----------------------------------------------------------------------------*/
 /*------------------------------------------------------------------------------
 eRecordStatus
	Type énuméré définissant le statut d'un enregistrement
 -----------------------------------------------------------------------------*/
 typedef enum _eRecordStatus {
	eRecordStatus_Unknown	=	0,
	eRecordStatus_Recording,
	eRecordStatus_Pause,
	eRecordStatus_Stop
 } eRecordStatus;
/*------------------------------------------------------------------------------
 CRecorderUI
	Gestionnaire graphique d'un dictaphone
 -----------------------------------------------------------------------------*/
@interface CRecorderUI : NSObject
	<iRecorderUI>
{
	UIViewController *m_pvcCtx;
	UILabel *m_plblTime;
	UIButton *m_pbtnRecord;
	NSTimer *m_pTimer;
	BOOL m_bRecording;
	unsigned int m_uiSecs;
	unsigned int m_uiMins;
	unsigned int m_uiHours;
	eRecordStatus m_eStatus;
}

@end
