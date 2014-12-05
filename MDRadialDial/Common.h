//
//  Common.h
//  SmallTalk
//
//  Created by Michael Diakonov on 10/24/14.
//  Copyright (c) 2014 VenDia. All rights reserved.
//

#ifndef SmallTalk_Common_h
#define SmallTalk_Common_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#endif
