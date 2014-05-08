/*
 File :     MacrosUI.h
 Module :   TOOLS/Includes
 Purpose :  Macros utiles pour faire du graphique
 -----------------------------------------------------------------------------*/

#ifndef __MACROSUI__
#define __MACROSUI__
/* Dimensions */
#define HEIGHT(v)					v.frame.size.height
#define WIDTH(v)					v.frame.size.width
#define X(v)						v.frame.origin.x
#define Y(v)						v.frame.origin.y
/* Positionnement */
#define ADD_SUBVIEW(v, sv)			[v addSubview:sv];
/* Couleurs */
#define RGB_COLOR(r, g, b)			\
	[UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:1.0]
/* Images */
#define UIIMAGE_FROM_FILE(f)		\
	[UIImage imageNamed:f]
#endif // __MACROSUI__
