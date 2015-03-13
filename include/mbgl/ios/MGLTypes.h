#import <Foundation/Foundation.h>

// style property value types
//
extern NSString *const MGLStyleValueTypeBoolean;
extern NSString *const MGLStyleValueTypeNumber;
extern NSString *const MGLStyleValueTypeNumberPair;
extern NSString *const MGLStyleValueTypeColor;
extern NSString *const MGLStyleValueTypeString;

// style property function types
//
extern NSString *const MGLStyleValueTypeFunctionMinimumZoom;
extern NSString *const MGLStyleValueTypeFunctionMaximumZoom;
extern NSString *const MGLStyleValueTypeFunctionLinear;
extern NSString *const MGLStyleValueTypeFunctionExponential;
extern NSString *const MGLStyleValueTypeFunctionStops;

typedef NS_ENUM(NSUInteger, MGLUserTrackingMode) {
    MGLUserTrackingModeNone              = 0,
    MGLUserTrackingModeFollow            = 1,
    MGLUserTrackingModeFollowWithHeading = 2
};
