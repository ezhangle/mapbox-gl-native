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

//! The receiver’s title string.
@property (nonatomic) NSString *title;

//! The receiver’s subtitle string.
@property (nonatomic) NSString *subtitle;

@end
