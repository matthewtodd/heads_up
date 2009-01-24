require 'rake/clean'

# This way we get a little output when gcc's started.
RakeFileUtils.verbose_flag = true

CLEAN << 'application/ext/main.o'
file 'application/ext/main.o' => 'application/ext/main.m' do |task|
  options = '-x objective-c -arch i386 -pipe -Wno-trigraphs -fpascal-strings -fasm-blocks -Os -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -mdynamic-no-pic'
  sh "/usr/bin/gcc-4.0 #{options} -c #{task.prerequisites.first} -o #{task.name}"
end

CLEAN << 'preference_pane/ext/bundle_main.o'
file 'preference_pane/ext/bundle_main.o' => 'preference_pane/ext/bundle_main.m' do |task|
  options = '-x objective-c -arch i386 -pipe -Wno-trigraphs -fpascal-strings -fasm-blocks -Os -Wreturn-type -Wunused-variable -fmessage-length=0 -include /Library/Caches/com.apple.Xcode.501/SharedPrecompiledHeaders/AppKit-hkudyebjyuhwokchccyrlmlwzdmd/AppKit.h'
  sh "/usr/bin/gcc-4.0 #{options} -c #{task.prerequisites.first} -o #{task.name}"
end

def gcc_link(executable, object_file, options, frameworks)
  directory File.dirname(executable)
  file executable => [File.dirname(executable), object_file] do
    link_frameworks = frameworks.map { |name| "-framework #{name}" }.join(' ')
    sh "/usr/bin/gcc-4.0 -o #{executable} #{link_frameworks} -arch i386 #{options} #{object_file}"
  end
end

gcc_link 'release/HeadsUp.prefPane/Contents/MacOS/HeadsUp', 'preference_pane/ext/bundle_main.o', '-bundle', %w[AppKit Cocoa PreferencePanes RubyCocoa]
gcc_link 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/MacOS/HeadsUp', 'application/ext/main.o', nil, %w[Cocoa RubyCocoa]
directory 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/Resources'

CLEAN << 'release'
desc 'Build HeadsUp.prefPane.'
task :build => ['release/HeadsUp.prefPane/Contents/MacOS/HeadsUp', 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/MacOS/HeadsUp', 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/Resources'] do
  cp_r 'application/Info.plist',         'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents'
  cp_r Dir.glob('application/lib/*'),    'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/Resources'

  cp_r 'preference_pane/Info.plist',            'release/HeadsUp.prefPane/Contents'
  cp_r Dir.glob('preference_pane/lib/*'),       'release/HeadsUp.prefPane/Contents/Resources'
  cp_r Dir.glob('preference_pane/resources/*'), 'release/HeadsUp.prefPane/Contents/Resources'
end

desc 'Run HeadsUp.prefPane.'
task :run => :build do
  sh 'open release/HeadsUp.prefPane'
end

CLEAN << 'HeadsUp.dmg'
desc 'Package the HeadsUp Preference Pane'
task :package => :build do
  rm_f 'HeadsUp.dmg'
  sh 'hdiutil create -volname HeadsUp -srcfolder release HeadsUp.dmg'
end

task :default => :run