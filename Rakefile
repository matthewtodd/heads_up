require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'pathname'

# Application own Settings
APPNAME               = "HeadsUp"
APPVERSION            = `git show-ref --hash refs/heads/master`
PUBLISH               = 'matthew@woodward:~'
DEFAULT_TARGET        = 'HeadsUpPreferencePane'
DEFAULT_CONFIGURATION = 'Release'
RELEASE_CONFIGURATION = 'Release'

# Tasks
task :default => [:run]

desc "Build the Preference Pane and run it."
task :run => [:build] do
  release_dir = 'build/Release'
  install_dir = "#{ENV['HOME']}/Library/PreferencePanes"
  pref_pane = "#{APPNAME}.prefPane"

  sh %{killall HeadsUp || true}
  sh %{osascript -e 'tell application "System Preferences" to quit'}
  sh %{rm -r "#{install_dir}/#{pref_pane}"}
  sh %{cp -r "#{release_dir}/#{pref_pane}" "#{install_dir}"}
  sh %{open "#{install_dir}/#{pref_pane}"}
end

desc "Build the Application and run it."
task :app => [:build] do
  sh %{killall HeadsUp || true}
  sh %{open build/Release/#{APPNAME}.app}
end

desc 'Build the default target using the default configuration'
task :build => "xcode:build:#{DEFAULT_TARGET}:#{DEFAULT_CONFIGURATION}"

desc 'Deep clean of everything'
task :clean do
  puts %x{ xcodebuild -alltargets clean }
end

desc "Package the application"
task :package => ["xcode:build:#{DEFAULT_TARGET}:#{RELEASE_CONFIGURATION}", "pkg"] do
  name = "#{APPNAME}.#{APPVERSION}"
  mkdir "image"
  sh %{rubycocoa standaloneify "build/#{DEFAULT_CONFIGURATION}/#{APPNAME}.app" "image/#{APPNAME}.app"}
  puts 'Creating Image...'
  sh %{
  hdiutil create -volname '#{name}' -srcfolder image '#{name}'.dmg
  rm -rf image
  mv '#{name}.dmg' pkg
  }
end

directory 'pkg'

desc 'Make Localized nib from English.lproj and Lang.lproj/nib.strings'
rule(/.nib$/ => [proc {|tn| File.dirname(tn) + '/nib.strings' }]) do |t|
  p t.name
  lproj = File.dirname(t.name)
  target = File.basename(t.name)
  rm_rf t.name
  sh %{
  nibtool -d #{lproj}/nib.strings -w #{t.name} English.lproj/#{target}
  }
end

# [Rubycocoa-devel 906] dynamically xcode rake tasks
# [Rubycocoa-devel 907]
#
def xcode_targets
  out = %x{ xcodebuild -list }
  out.scan(/.*Targets:\s+(.*)Build Configurations:.*/m)

  targets = []
  $1.each_line do |l|
    l = l.strip.sub(' (Active)', '')
    targets << l unless l.nil? or l.empty?
  end
  targets
end

def xcode_configurations
  out = %x{ xcodebuild -list }
  out.scan(/.*Build Configurations:\s+(.*)If no build configuration.*/m)

  configurations = []
  $1.each_line do |l|
    l = l.strip.sub(' (Active)', '')
    configurations << l unless l.nil? or l.empty?
  end
  configurations
end

namespace :xcode do
 targets = xcode_targets
 configs = xcode_configurations

 %w{build clean}.each do |action|
   namespace "#{action}" do

     targets.each do |target|
       desc "#{action} #{target}"
       task "#{target}" do |t|
         puts %x{ xcodebuild -target '#{target}' #{action} }
       end

       # alias the task above using a massaged name
       massaged_target = target.downcase.gsub(/[\s*|\-]/, '_')
       task "#{massaged_target}" => "xcode:#{action}:#{target}"


       namespace "#{target}" do
         configs.each do |config|
           desc "#{action} #{target} #{config}"
           task "#{config}" do |t|
             puts %x{ xcodebuild -target '#{target}' -configuration '#{config}' #{action} }
           end
         end
       end

       # namespace+task aliases of the above using massaged names
       namespace "#{massaged_target}" do
         configs.each { |conf| task "#{conf.downcase.gsub(/[\s*|\-]/, '_')}" => "xcode:#{action}:#{target}:#{conf}" }
       end

     end

   end
 end
end
