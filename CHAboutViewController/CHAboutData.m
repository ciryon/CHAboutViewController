//
//  CHAboutData.m
//  CHAboutViewController
//
//  Created by Christian Hedin on 2013-04-29.
//  Copyright (c) 2013 Christian Hedin. All rights reserved.
//

#import "CHAboutData.h"

@implementation CHAboutData

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

}

@end
