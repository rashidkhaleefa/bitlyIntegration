//
//  delegateAppDelegate.h
//  BitlyIntegrationSample
//
//  Created by rashid khaleefa on 03/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BitlyViewController.h"
@interface delegateAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) BitlyViewController *rootViewController;
@property (nonatomic, retain) UINavigationController *navigationController;
@end
