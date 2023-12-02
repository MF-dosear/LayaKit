#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LayaKit.h"
#import "conchConfig.h"
#import "conchRuntime.h"

FOUNDATION_EXPORT double LayaKitVersionNumber;
FOUNDATION_EXPORT const unsigned char LayaKitVersionString[];

