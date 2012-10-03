//
//  URLShortener.m
//  BitlyIntegrationSample
//
//  Created by rashid khaleefa on 03/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "URLShortener.h"

@implementation URLShortener

@synthesize
delegate = _delegate,
loginID = _loginID,
userKey = _userKey,
url = _url;


- (NSString*) _formEncodeString: (NSString*) string
{
	NSString* encoded = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                            (CFStringRef) string, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
	return [encoded autorelease];
}

#pragma mark -

- (void) execute
{
	if (_connection == nil)
	{
		_data = [NSMutableData new];
		
		NSString* urlString = [NSString stringWithFormat: @"http://api.bit.ly/v3/shorten?login=%@&apiKey=%@&uri=%@&format=txt",
                               [self _formEncodeString: _loginID],
                               [self _formEncodeString: _userKey],
                               [self _formEncodeString: [_url absoluteString]]];
        
		NSURLRequest* request = [NSURLRequest requestWithURL: [NSURL URLWithString: urlString]
                                                 cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 30.0];
		_connection = [[NSURLConnection connectionWithRequest: request delegate: self] retain];
	}
}

- (NSString*)executeSyncCall
{
	if (_connection == nil)
	{
		_data = [NSMutableData new];
		
		NSString* urlString = [NSString stringWithFormat: @"http://api.bit.ly/v3/shorten?login=%@&apiKey=%@&uri=%@&format=txt",
							   [self _formEncodeString: _loginID],
							   [self _formEncodeString: _userKey],
							   [self _formEncodeString: [_url absoluteString]]];
		
		NSURLRequest* request = [NSURLRequest requestWithURL: [NSURL URLWithString: urlString]
												 cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 30.0];
		//_connection = [[NSURLConnection connectionWithRequest: request delegate: self] retain];
		
		NSError             *errorResponse = nil;
		NSHTTPURLResponse   *ShortURLResponse;	
		
		NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&ShortURLResponse error:&errorResponse];
		NSString* string = [[[NSString alloc] initWithData: returnData encoding: NSASCIIStringEncoding] autorelease];
		string = [string stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
		NSLog(@"this is the final trimmed url that is generated: %@",string);
		return string;
	}
	return nil;
}

#pragma mark -

- (void) connection: (NSURLConnection*) connection didReceiveData: (NSData*) data
{
	[_data appendData: data];
}

- (void)connection: (NSURLConnection*) connection didReceiveResponse: (NSHTTPURLResponse*) response
{
	_statusCode = [response statusCode];
}

- (void) connection: (NSURLConnection*) connection didFailWithError: (NSError*) error
{
	[_delegate shortener: self didFailWithError: error];
    
	[_connection release];
	_connection = nil;
    
	[_data release];
	_data = nil;
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection
{
	if (_statusCode != 200) {
		[_delegate shortener: self didFailWithStatusCode: _statusCode];
	} 
	else 
	{
		NSString* string = [[[NSString alloc] initWithData: _data encoding: NSASCIIStringEncoding] autorelease];
		string = [string stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        
		[_delegate shortener:self didSucceedWithShortenedURL:[NSURL URLWithString: string]];
	}
    
	[_connection release];
	_connection = nil;
	
	[_data release];
	_data = nil;
}

#pragma mark -

- (id) init
{
    self = [super init];
    return self;
}

-(id)initWithURL:(NSString*)strSrcUrl withDelegate:(id)theDelegate 
{
    self = [super init];
    
    _loginID = BITLY_USERNAME;
    _userKey = BITLY_USERKEY;
    
    _url = [NSURL URLWithString:strSrcUrl];
    _delegate = theDelegate;
    
    return self;
}

- (void) dealloc
{
	[_loginID release];
    [_userKey release];
	[_url release];
    
	[super dealloc];
}

@end