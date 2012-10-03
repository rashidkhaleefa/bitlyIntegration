//
//  BitlyViewController.m
//  BitlyIntegrationSample
//
//  Created by rashid khaleefa on 03/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BitlyViewController.h"

@implementation BitlyViewController
@synthesize shortUrl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    URLShortener *shorter =[[URLShortener alloc]initWithURL:URL_TO_SHORTEN withDelegate:nil];
    //shorter.delegate=self;
    shortUrl.text = [shorter executeSyncCall];
     
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
