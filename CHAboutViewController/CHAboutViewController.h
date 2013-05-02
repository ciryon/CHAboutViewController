//
//  CHAboutViewController.h
//  CHAboutViewController
//
//  Created by Christian Hedin on 2013-04-29.
//  Copyright (c) 2013 Christian Hedin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAboutData;

@interface CHAboutViewController : UIViewController

- (id)initWithAboutData:(CHAboutData*)aboutData;


/* For customization of font, colors, etc */
@property(strong, nonatomic) IBOutlet UILabel *appNameLabel;
@property(strong, nonatomic) IBOutlet UILabel *appVersionsLabel;

@end
