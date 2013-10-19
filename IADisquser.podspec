
Pod::Spec.new do |s|

  s.name         = "IADisquser"
  s.version      = "1.0.0"
  s.summary      = 'A simple iOS wrapper for [Disqus API v3.0]'
  s.homepage     = 'https://github.com/zdima/IADisquser'
  s.description  = <<-DESC
Ever wanted to view your Disqus' comments from your site to your iOS app? Prefer a native way than javascript-embedding? Drag it to your project and implement it without a hassle!

With IADisquser, your iOS app can view and post comments with a couple of single method. Block-based callbacks make implementing disqus in your app fast & easy.  
All you need are forum name, api secret key and api public key to put in you config file. After that you can fetch the comments using identifier or link. This is required parameters of the fetcher method. In my sample code, I'm using thread identifier, ex : (`'85 http://toogeekforpunk.com/?p=54'`). You can check the thread identifier by using view source from your browser and search the code that Disqus generate ex : (`var disqus_identifier = '<your identifier>'`).

```javascript
...
/* <![CDATA[ */    
    var disqus_url = 'http://3kunci.com/iadisquser-disqus-api-wrapper-for-ios/';
    var disqus_identifier = '85 http://toogeekforpunk.com/?p=54';
    var disqus_container_id = 'disqus_thread';
    var disqus_domain = 'disqus.com';
    var disqus_shortname = '3kunci';
...
```

If you want to check IADisquser in action, please use the sample project, then you can see & post your comments from the app, or on my [blogpost] (http://3kunci.com/iadisquser-disqus-api-wrapper-for-ios/). 

## Example

### View Comments

``` objective-c
// Method for getting comments from a Disqus Thread
// Identifier & thread ID : http://docs.disqus.com/help/14/
[IADisquser getCommentsFromThreadIdentifier:@"<Your Identifier>" 
                                    success:^(NSArray *comments) {
                                        for (IADisqusComment *aComment in comments)
                                            NSLog(@"Raw comments from %@ : %@", aComment.authorName, aComment.rawMessage);
                                     } fail:nil];
```
                   DESC

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Ikhsan Assaat',"Dmitriy Zakharkin"
  s.platform     = :ios, '5.0'
  s.source       = { :git => 'https://github.com/zdima/IADisquser.git', :tag => '1.0.0' }
  s.source_files = 'IADisquser/*.{h,m}'
  s.public_header_files = 'IADisquser/**/*.h'
  s.requires_arc = true
  s.dependency 'AFNetworking', '1.3.2'

end
