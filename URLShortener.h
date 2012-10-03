//
//  URLShortener.h
//  BitlyIntegrationSample
//
//  Created by rashid khaleefa on 03/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class URLShortener;

@protocol URLShortenerDelegate
@required
- (void) shortener: (URLShortener*) shortener didSucceedWithShortenedURL: (NSURL*) shortenedURL;
@optional
- (void) shortener: (URLShortener*) shortener didFailWithStatusCode: (int) statusCode;
- (void) shortener: (URLShortener*) shortener didFailWithError: (NSError*) error;
@end

@interface URLShortener : NSObject {
@private
	id<URLShortenerDelegate> _delegate;
    
    NSString* _loginID;
	NSString* _userKey;
    
	NSURL* _url;
    
@private
	NSURLConnection* _connection;
	NSInteger _statusCode;
	NSMutableData* _data;
}

-(id)initWithURL:(NSString*)strSrcUrl withDelegate:(id)theDelegate ;

@property (nonatomic,retain) id<URLShortenerDelegate> delegate;
@property (nonatomic,retain) NSString* loginID;
@property (nonatomic,retain) NSString* userKey;
@property (nonatomic,retain) NSURL* url;

- (void) execute;

- (NSString*) executeSyncCall;


@end