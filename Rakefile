require 'rake/clean'

task :default => :open

desc 'Open HeadsUp.prefPane.'
task :open => :build do
  sh 'open release/HeadsUp.prefPane'
end

desc 'Package HeadsUp.dmg.'
task :package => [:clean, :build] do
  sh 'hdiutil create -volname HeadsUp -srcfolder release HeadsUp.dmg'
end
CLEAN.include('HeadsUp.dmg')


rule '.o' => ['.m'] do |task|
  sh "/usr/bin/gcc-4.0 -c #{task.source} -o #{task.name}"
end
CLEAN.include('**/*.o')

def gcc_link(executable, object_file, options, frameworks)
  directory File.dirname(executable)
  file executable => [File.dirname(executable), object_file] do
    link_frameworks = frameworks.map { |name| "-framework #{name}" }.join(' ')
    sh "/usr/bin/gcc-4.0 -o #{executable} #{link_frameworks} #{options} #{object_file}"
  end
end

gcc_link 'release/HeadsUp.prefPane/Contents/MacOS/HeadsUp', 'preference_pane/ext/bundle_main.o', '-bundle', %w[AppKit Cocoa PreferencePanes RubyCocoa]
gcc_link 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/MacOS/HeadsUp', 'application/ext/main.o', nil, %w[Cocoa RubyCocoa]
directory 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/Resources'

desc 'Build HeadsUp.prefPane.'
task :build => ['release/HeadsUp.prefPane/Contents/MacOS/HeadsUp', 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/MacOS/HeadsUp', 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/Resources'] do
  cp_r 'application/Info.plist',      'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents'
  cp_r Dir.glob('application/lib/*'), 'release/HeadsUp.prefPane/Contents/Resources/HeadsUp.app/Contents/Resources'

  cp_r 'preference_pane/Info.plist',            'release/HeadsUp.prefPane/Contents'
  cp_r Dir.glob('preference_pane/lib/*'),       'release/HeadsUp.prefPane/Contents/Resources'
  cp_r Dir.glob('preference_pane/resources/*'), 'release/HeadsUp.prefPane/Contents/Resources'
end
CLEAN.include('release')
