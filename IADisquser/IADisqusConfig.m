//
//  IADisqusConfig.m
//  Disquser
//
//  Created by Dmitriy Zakharkin on 11/18/13.
//  Copyright (c) 2013 Beetlebox. All rights reserved.
//

#import "IADisqusConfig.h"
#import "IADisquser.h"

@interface IADisqusConfig ()
{
    NSString* _baseURL;
    NSString* _forumName;
    NSString* _apiSecret;
    NSString* _apiPublic;
    NSString* _apiToken;
    NSString* _authorName;
    NSString* _authorEMail;
    NSString* _authorAccessToken;
    NSString* _authorRefreshToken;
    NSDate*   _authorAccessTokenExpire;
}

@end

static dispatch_once_t onceToken;
static IADisqusConfig* instance;

@implementation IADisqusConfig

#define DISQUS_BASE_URL     @"DISQUS_BASE_URL"
#define DISQUS_FORUM_NAME   @"DISQUS_FORUM_NAME"
#define DISQUS_API_SECRET   @"DISQUS_API_SECRET"
#define DISQUS_API_PUBLIC   @"DISQUS_API_PUBLIC"
#define DISQUS_API_TOKEN    @"DISQUS_API_TOKEN"
#define DISQUS_AUTHOR_NAME  @"DISQUS_AUTHOR_NAME"
#define DISQUS_AUTHOR_EMAIL @"DISQUS_AUTHOR_EMAIL"
#define DISQUS_AUTHOR_TOCKEN  @"DISQUS_AUTHOR_TOCKEN"
#define DISQUS_AUTHOR_TOCKEN_EXPR @"DISQUS_AUTHOR_TOCKEN_EXPR"
#define DISQUS_REFRESH_TOCKEN @"DISQUS_REFRESH_TOCKEN"

-(void)initializeInstance
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    _baseURL = [ud stringForKey:DISQUS_BASE_URL];
    if(_baseURL==nil)
    {
        _baseURL = @"http://disqus.com/api/3.0/";
        [ud setObject:_baseURL forKey:DISQUS_BASE_URL];
    }
    _forumName   = [ud stringForKey:DISQUS_FORUM_NAME];
    _apiPublic   = [ud stringForKey:DISQUS_API_PUBLIC];
    _apiSecret   = [ud stringForKey:DISQUS_API_SECRET];
    _apiToken    = [ud stringForKey:DISQUS_API_TOKEN];
    _authorName  = [ud stringForKey:DISQUS_AUTHOR_NAME];
    _authorEMail = [ud stringForKey:DISQUS_AUTHOR_EMAIL];
    _authorAccessToken = [ud stringForKey:DISQUS_AUTHOR_TOCKEN];
    _authorRefreshToken = [ud stringForKey:DISQUS_REFRESH_TOCKEN];
    _authorAccessTokenExpire = [ud objectForKey:DISQUS_AUTHOR_TOCKEN_EXPR];
}

+(IADisqusConfig*)sharedConfig
{
    dispatch_once(&onceToken, ^{
        instance = [[IADisqusConfig alloc] init];
        [instance initializeInstance];
    });
    return instance;
}

+(BOOL)isRegistered
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if(config->_authorAccessToken.length>0)
    {
        if([config->_authorAccessTokenExpire compare:[NSDate date]]==NSOrderedAscending)
        {
            // expired
            return NO;
        }
        if(config->_authorRefreshToken.length>0 && [config->_authorAccessTokenExpire compare:[NSDate dateWithTimeIntervalSinceNow:-48*3600]]==NSOrderedAscending)
        {
            // refresh token now
            if( [IADisquser refreshToken] )
                return YES;
            return NO;
        }
        return YES;
    }
    return NO;
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

+(NSString*)authorAccessToken
{
    return [IADisqusConfig sharedConfig]->_authorAccessToken;
}

+(NSString*)authorRefreshToken
{
    return [IADisqusConfig sharedConfig]->_authorRefreshToken;
}

+(NSDate*)authorAccessTokenExpire
{
    return [IADisqusConfig sharedConfig]->_authorAccessTokenExpire;
}

+(NSString *)apiAccessToken
{
    return [IADisqusConfig sharedConfig]->_apiToken;
}

+(NSString *)authorName
{
    return [IADisqusConfig sharedConfig]->_authorName;
}

+(NSString *)authorEMail
{
    return [IADisqusConfig sharedConfig]->_authorEMail;
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

+(void)setApiAccessToken:(NSString *)accessToken
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_apiToken isEqualToString:accessToken])
        return;
    config->_apiToken = accessToken;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_apiToken forKey:DISQUS_API_TOKEN];
}

+(void)setAuthorName:(NSString *)name
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_authorName isEqualToString:name])
        return;
    config->_authorName = name;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_authorName forKey:DISQUS_AUTHOR_NAME];
}

+(void)setAuthorEMail:(NSString *)email
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_authorEMail isEqualToString:email])
        return;
    config->_authorEMail = email;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_authorEMail forKey:DISQUS_AUTHOR_EMAIL];
}

+(void)setAuthorAccessToken:(NSString *)accessToken
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_authorAccessToken isEqualToString:accessToken])
        return;
    config->_authorAccessToken = accessToken;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_authorAccessToken forKey:DISQUS_AUTHOR_TOCKEN];
}

+(void)setAuthorRefreshToken:(NSString *)RefreshToken
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_authorRefreshToken isEqualToString:RefreshToken])
        return;
    config->_authorRefreshToken = RefreshToken;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_authorRefreshToken forKey:DISQUS_AUTHOR_TOCKEN];
}

+(void)setAuthorAccessTokenExpire:(NSDate *)accessTokenExpire
{
    IADisqusConfig* config = [IADisqusConfig sharedConfig];
    if([config->_authorAccessTokenExpire isEqual:accessTokenExpire])
        return;
    config->_authorAccessTokenExpire = accessTokenExpire;
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:config->_authorAccessTokenExpire forKey:DISQUS_AUTHOR_TOCKEN_EXPR];
}

@end