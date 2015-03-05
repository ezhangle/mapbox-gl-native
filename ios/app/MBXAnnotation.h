//
//  MBXAnnotation.h
//  mapboxgl-app
//
//  Created by Brad Leege on 3/3/15.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import <mbgl/ios/MGLAnnotation.h>
#import <mbgl/ios/MGLAnnotationView.h>

@interface MBXAnnotation : NSObject <MGLAnnotation>

+ (instancetype)annotationWithLocation:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

@end

@interface MBXAnnotationView : MGLAnnotationView

@end
