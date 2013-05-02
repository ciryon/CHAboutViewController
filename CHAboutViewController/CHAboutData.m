//
//  CHAboutData.m
//  CHAboutViewController
//
//  Created by Christian Hedin on 2013-04-29.
//  Copyright (c) 2013 Christian Hedin. All rights reserved.
//

#import "CHAboutData.h"

@implementation CHAboutData

@synthesize appImage = _appImage;

+(CHAboutData *)sharedAboutData;
{
  static dispatch_once_t pred;
  static CHAboutData *shared = nil;
  
  dispatch_once(&pred, ^{
    shared = [[CHAboutData alloc] init];
  });
  return shared;
}

- (id)init
{
  self = [super init];
  if (self) {
    
  }
  return self;
}

-(NSString*)appMarketingVersion{
    return [[self infoDict] objectForKey:@"CFBundleShortVersionString"];
}

-(NSString*)appDetailedVersion{
    return [[self infoDict] objectForKey:@"CFBundleVersion"];
}

-(NSString*)appName{
    return [[self infoDict] objectForKey:@"CFBundleDisplayName"];
}

-(NSDictionary*)infoDict;
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    return infoDict;
}


-(UIImage*)appImage;
{
  if (_appImage) {
    return _appImage;
  }
  else {
    return [self iconImageFromPlist];
  }
}

-(UIImage*)iconImageFromPlist;
{
  NSDictionary *icons = [[self infoDict] objectForKey:@"CFBundleIcons"];
  NSDictionary *primaryIcon = [icons objectForKey:@"CFBundlePrimaryIcon"];
  NSArray *iconFiles = [primaryIcon objectForKey:@"CFBundleIconFiles"];
  NSString *iconFile = [iconFiles objectAtIndex:0];
  UIImage *image = [UIImage imageNamed:iconFile];
  return image;
}

@end
