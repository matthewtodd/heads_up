#
#  rb_main.rb
#  HeadsUp
#
#  Created by Matthew Todd on 1/16/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

def rb_main_init
  path = OSX::NSBundle.mainBundle.resourcePath.fileSystemRepresentation
  rbfiles = Dir.entries(path).select {|x| /\.rb\z/ =~ x}
  rbfiles -= [ File.basename(__FILE__) ]
  rbfiles.each do |path|
    require( File.basename(path) )
  end
end

if $0 == __FILE__ then
  rb_main_init

  OSX::NSApplication.sharedApplication
  OSX::NSApp.setDelegate(HeadsUp.alloc.init)
  OSX::NSApp.run
end
