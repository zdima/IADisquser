//
// IADisqusConfig.h
// Disquser
// 
// Copyright (c) 2011 Ikhsan Assaat. All Rights Reserved 
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


// Disqus API version 3.0 : http://disqus.com/api/docs/

@interface IADisqusConfig : NSObject

/*
 * initialize will read NSUserDefaults to get default parameters
 */
-(void)initialize;

+(NSString*)baseURL;
+(NSString*)forumName;
+(NSString*)apiSecret;
+(NSString*)apiPublic;

/*
 * Application can set defailt or new parameters when require
 */
+(void)setDefaultBaseURL:(NSString*)url;
+(void)setDefaultForumName:(NSString*)name;
+(void)setDefaultApiSecret:(NSString*)secretKey;
+(void)setDefaultApiPublic:(NSString*)publicKey;

@end

