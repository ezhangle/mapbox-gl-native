//
//  MGLAnnotation.h
//  mbgl
//
//  Created by Minh Nguyen on 2015-03-04.
//
//

#import <Foundation/Foundation.h>

@protocol MGLAnnotation <NSObject>

//! The receiver’s center, expressed as a coordinate on the containing map.
@property (assign) CLLocationCoordinate2D coordinate;

@end
