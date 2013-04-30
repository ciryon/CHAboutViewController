//
//  CHAboutData.h
//  CHAboutViewController
//
//  Created by Christian Hedin on 2013-04-29.
//  Copyright (c) 2013 Christian Hedin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  CHAboutDataContactMethodNone,
  CHAboutDataContactMethodEmail,
  CHAboutDataContactMethodWebPage,
  CHAboutDataContactMethodTestFlight
} CHAboutDataContactMethod;

@interface CHAboutData : NSObject

+(CHAboutData *)sharedAboutData;


@property (nonatomic, readonly) NSString *appName;
@property (nonatomic, readonly) NSString *appDetailedVersion;
@property (nonatomic, readonly) NSString *appMarketingVersion;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSURL    *appInfoURL;
@property (nonatomic, strong) NSURL    *appSupportURL;
@property (nonatomic, strong) UIImage    *appImage;

@property (nonatomic, assign) CHAboutDataContactMethod contactMethod;
@property (nonatomic, assign) id contactMethodValue;

@end
