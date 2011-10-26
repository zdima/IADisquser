# IADisquser
## A simple iOS wrapper for [Disqus API v3.0] (http://disqus.com/api/docs/)
Ever wanted to view your Disqus' comments from your site to your iOS app? Prefer a native way than javascript-embedding? Drag it to your project and implement it without a hassle!

With IADisquser, your iOS app can view and post comments with a couple of single method. Block-based callbacks make implementing disqus in your app fast & easy.  

## Example

### View Comments

``` objective-c
// Method for getting comments from a Disqus Thread
// Identifier & thread ID : http://docs.disqus.com/help/14/
[IADisquser getCommentsFromThreadIdentifier:@"Identifier" 
                                    success:^(NSArray *comments) {
                                        for (IADisqusComment *aComment in comments)
                                            NSLog(@"Raw comments from %@ : %@", aComment.rawMessage, aComment.authorName);
                                     } fail:nil];
```

### Posting a Comment

``` objective-c
// Method for getting comments from a Disqus Thread
// Identifier & thread ID : http://docs.disqus.com/help/14/
IADisqusComment *aComment = [[[IADisqusComment alloc] init] autorelease];
aComment.authorName = Ikhsan Assaat;
aComment.authorEmail = ixnixnixn@yahoo.com;
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

Contacts :
* ixnixnixn@yahoo.com
* [@ixnixnixn] (http://twitter.com/ixnixnixn)
* http://id.linkedin.com/in/ixnixnixn