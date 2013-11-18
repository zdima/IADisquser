//
//  IADisqusConfig.m
//  Disquser
//
//  Created by Dmitriy Zakharkin on 11/18/13.
//  Copyright (c) 2013 Beetlebox. All rights reserved.
//

#import "IADisqusConfig.h"

@interface IADisqusConfig ()
{
    NSString* _baseURL;
    NSString* _forumName;
    NSString* _apiSecret;
    NSString* _apiPublic;
}

@end

static dispatch_once_t onceToken;
static IADisqusConfig* instance;

@implementation IADisqusConfig

//#define DISQUS_BASE_URL     @"http://disqus.com/api/3.0/"
//#define DISQUS_FORUM_NAME   @"3kunci"
//#define DISQUS_API_SECRET   @"cGOvbAYKzWXFffL1h2uM1P2jIp3i816FR0tfMpmb5xHeAHbIJQRt1HYN1trZRmZ2"
//#define DISQUS_API_PUBLIC   @"KyaiUKCMWJIPpYXpXr6C3T134MhV3hpqpBrbbaHPorjkp4Mb8FNisVxmcKCz2FTK"
#define DISQUS_BASE_URL     @"DISQUS_BASE_URL"
#define DISQUS_FORUM_NAME   @"DISQUS_FORUM_NAME"
#define DISQUS_API_SECRET   @"DISQUS_API_SECRET"
#define DISQUS_API_PUBLIC   @"DISQUS_API_PUBLIC"

-(void)initialize
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    _baseURL = [ud stringForKey:DISQUS_BASE_URL];
    _forumName = [ud stringForKey:DISQUS_FORUM_NAME];
    _apiPublic = [ud stringForKey:DISQUS_API_PUBLIC];
    _apiSecret = [ud stringForKey:DISQUS_API_SECRET];
}

+(IADisqusConfig*)sharedConfig
{
    dispatch_once(&onceToken, ^{
        instance = [[IADisqusConfig alloc] init];
        [instance initialize];
    });
    return instance;
}

+(NSString*)baseURL
{
    return [IADisqusConfig sharedConfig]->_baseURL;
}

+(NSString*)forumName
{
    return [IADisqusConfig sharedConfig]->_forumName;
}

+(NSString*)apiSecret
{
    return [IADisqusConfig sharedConfig]->_apiSecret;
}

+(NSString*)apiPublic
{
    return [IADisqusConfig sharedConfig]->_apiPublic;
}

+(void)setDefaultBaseURL:(NSString*)url
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_baseURL isEqualToString:url])
        return;
    config->_baseURL = url;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_baseURL forKey:DISQUS_BASE_URL];
}

+(void)setDefaultForumName:(NSString*)name
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_forumName isEqualToString:name])
        return;
    config->_forumName = name;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_forumName forKey:DISQUS_FORUM_NAME];
}

+(void)setDefaultApiSecret:(NSString*)secretKey
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_apiSecret isEqualToString:secretKey])
        return;
    config->_apiSecret = secretKey;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_apiSecret forKey:DISQUS_API_SECRET];
}

+(void)setDefaultApiPublic:(NSString*)publicKey
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_apiPublic isEqualToString:publicKey])
        return;
    config->_apiPublic = publicKey;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_apiPublic forKey:DISQUS_API_PUBLIC];
}


@end