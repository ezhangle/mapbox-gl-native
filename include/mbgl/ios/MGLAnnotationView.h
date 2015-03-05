//
//  MGLAnnotationView.h
//  mbgl
//
//  Created by Minh Nguyen on 2015-03-04.
//
//

#import <UIKit/UIKit.h>

@class SMCalloutView;
@protocol MGLAnnotation;

@interface MGLAnnotationView : UIImageView

@property (nonatomic) id <MGLAnnotation> annotation;

//! The callout view that pops up when the receiver is selected.
@property (nonatomic) SMCalloutView *calloutView;

@end
