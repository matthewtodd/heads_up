require 'rake/clean'
require 'erb'

rule '.o' => ['.m'] do |task|
  sh "/usr/bin/gcc-4.0 -c #{task.source} -o #{task.name}"
end; CLEAN.include('**/*.o')

def bundle(name, options)
  link_flags    = options[:link_flags] || []
  frameworks    = options[:link_frameworks] || []
  prefix        = options[:prefix] || ''
  source        = options[:source] || raise('source is required')
  contents_dir  = File.expand_path("release/#{prefix}/#{name}/Contents")
  mac_os_dir    = "#{contents_dir}/MacOS"
  resources_dir = "#{contents_dir}/Resources"
  executable    = "#{mac_os_dir}/#{name.pathmap('%n')}" # pathmap is from Rake; %n is basename without extension
  object_file   = "#{source}/ext/main.o"

  task name => object_file do
    mkdir_p contents_dir
    File.open("#{contents_dir}/Info.plist", 'w') { |file| file.write(ERB.new(File.read("#{source}/Info.plist")).result) }
    mkdir_p mac_os_dir
    sh "/usr/bin/gcc-4.0 -o %s %s %s %s" % [executable, frameworks.map { |name| "-framework #{name}" }.join(' '), link_flags.join(' '), object_file]
    mkdir_p resources_dir
    cp_r Dir.glob("#{source}/lib/*"), resources_dir
    cp_r Dir.glob("#{source}/resources/*"), resources_dir
  end
end


HEADS_UP_VERSION = '0.1.0'
HEADS_UP_GIT_SHA = `git show-ref --hash=6 HEAD`.chomp

task :default => :open

desc 'Build HeadsUp.prefPane'
task :build => ['HeadsUp.prefPane', 'HeadsUp.app']

desc 'Edit the HeadsUp Preference Pane NIB.'
task :edit do
  sh 'open preference_pane/resources/English.lproj/HeadsUpPreferencePane.nib'
end

desc 'Open HeadsUp.prefPane.'
task :open => :build do
  sh 'open release/HeadsUp.prefPane'
end

desc 'Package HeadsUp.dmg.'
task :package => [:clean, :build] do
  sh "hdiutil create -volname HeadsUp -srcfolder release HeadsUp-#{HEADS_UP_VERSION}.dmg"
end; CLEAN.include('HeadsUp-*.dmg')


bundle 'HeadsUp.prefPane', :source => 'preference_pane', :link_frameworks => ['Cocoa', 'RubyCocoa', 'AppKit', 'PreferencePanes'], :link_flags => ['-bundle']
bundle 'HeadsUp.app',      :source => 'application',     :link_frameworks => ['Cocoa', 'RubyCocoa'], :prefix => 'HeadsUp.prefPane/Contents/Resources'

CLEAN.include('release')