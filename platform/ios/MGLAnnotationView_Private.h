//
//  MGLAnnotationView_Private.h
//  mbgl
//
//  Created by Minh Nguyen on 2015-03-05.
//
//

#import "MGLAnnotationView.h"

@class SMCalloutView;

@interface MGLAnnotationView (Private)

//! The callout view that pops up when the receiver is selected.
@property (nonatomic, strong) SMCalloutView *calloutView;

//! Updates the callout view to reflect the annotation data.
- (void)updateCalloutView;

@end
