#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "IADisquser"
  s.version      = "0.0.1"
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

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = { :type => 'MIT', :file => 'LICENSE' }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors by using the SCM log. E.g. $ git log. If no email can be
  #  found CocoaPods accept just the names.
  #

  # s.authors      = { "Dmitriy Zakharkin" => "mail@zdima.net", "other author" => "email@address.com" }
  s.author       = 'Ikhsan Assaat'



  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios, '5.0'

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, svn and HTTP.
  #

  s.source       = { :git => 'git://github.com/zdima/IADisquser.git', :tag => 'v1.0' }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it include source code, for source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files = 'IADisquser/*.{h,m}'
  # s.exclude_files = 'Classes/Exclude'

  s.public_header_files = 'IADisquser/**/*.h'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = 'SomeFramework'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.library   = 'iconv'
  # s.libraries = 'iconv', 'xml2'


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  # s.dependency 'JSONKit', '~> 1.4'
  s.dependency 'AFNetworking', '1.3.2'
  # s.dependency 'AFNetworking', :path => '~/Documents/XCodeProjects/IADisquser/Example/Libraries/AFNetworking'

end
