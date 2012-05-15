# IADisquser
## A simple iOS wrapper for [Disqus API v3.0] (http://disqus.com/api/docs/)
Ever wanted to view your Disqus' comments from your site to your iOS app? Prefer a native way than javascript-embedding? Drag it to your project and implement it without a hassle!

With IADisquser, your iOS app can view and post comments with a couple of single method. Block-based callbacks make implementing disqus in your app fast & easy.  

All you need are forum name, api secret key and api public key to put in you config file. After that you can fetch the comments using identifier or link. This is required parameters of the fetcher method. In my sample code, I'm using thread identifier, ex : (`'54 http://toogeekforpunk.com/?p=54'`). You can check the thread identifier by using view source from your browser and search the code that Disqus generate ex : (`var disqus_identifier = '<your identifier>'`).

```javascript
...
/* <![CDATA[ */
    var disqus_url = 'http://toogeekforpunk.com/2011/10/iadisquser-disqus-api-wrapper-for-ios/';
    var disqus_identifier = '54 http://toogeekforpunk.com/?p=54';
    var disqus_container_id = 'disqus_thread';
    var disqus_domain = 'disqus.com';
...
```

If you want to check IADisquser in action, please use the sample project, then you can see & post your comments from the app, or on my [blogpost] (http://3kunci.com/iadisquser-disqus-api-wrapper-for-ios/). 

## Example

### View Comments

``` objective-c
// Method for getting comments from a Disqus Thread
// Identifier & thread ID : http://docs.disqus.com/help/14/
[IADisquser getCommentsFromThreadIdentifier:@"Identifier" 
                                    success:^(NSArray *comments) {
                                        for (IADisqusComment *aComment in comments)
                                            NSLog(@"Raw comments from %@ : %@", aComment.authorName, aComment.rawMessage);
                                     } fail:nil];
```

### Posting a Comment

``` objective-c
// Method for getting comments from a Disqus Thread
// Identifier & thread ID : http://docs.disqus.com/help/14/
IADisqusComment *aComment = [[[IADisqusComment alloc] init] autorelease];
aComment.authorName = @"Ikhsan Assaat";
aComment.authorEmail = @"ixnixnixn@yahoo.com";
aComment.rawMessage = @"Nice to meet you!";
aComment.threadID = [NSNumber numberWithInteger:2000];
[IADisquser postComment:aComment success:^{NSLog(@"Comment posted.")} fail:nil];

```

## Dependencies
* [iOS 4.0+] - blocks introduced in iOS 4
* [AFNetworking] - (https://github.com/gowalla/AFNetworking)
* [JSONKit] - (https://github.com/johnezang/JSONKit)

## License

IADisquser is available under the MIT License.

## Credits

IADisquser was created by [Ikhsan Assaat](https://github.com/ixnixnixn) in the development of Beetlebox's Sajian Sedap iPad app.

* [@ixnixnixn] (http://twitter.com/ixnixnixn)
* ixnixnixn@yahoo.com
* http://id.linkedin.com/in/ixnixnixn