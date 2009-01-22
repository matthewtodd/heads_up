task :default => :run

desc 'Build the HeadsUp Preference Pane'
task :build do
  puts %x{ xcodebuild -target 'HeadsUpPreferencePane' -configuration 'Release' build }
end

desc 'Clean Everything'
task :clean do
  puts %x{ xcodebuild -alltargets clean }
end

desc 'Run the HeadsUp Preference Pane'
task :run => :build do
  release_dir = 'build/Release'
  install_dir = "#{ENV['HOME']}/Library/PreferencePanes"
  pref_pane = "HeadsUp.prefPane"

  sh %{ killall HeadsUp || true }
  sh %{ osascript -e 'tell application "System Preferences" to quit' }
  sh %{ rm -rf "#{install_dir}/#{pref_pane}" }
  sh %{ cp -r "#{release_dir}/#{pref_pane}" "#{install_dir}" }
  sh %{ open "#{install_dir}/#{pref_pane}" }
end

desc 'Package the HeadsUp Preference Pane'
task :package => :build do
  sh %{ rm -rf image }
  sh %{ mkdir image }
  sh %{ cp -r build/Release/HeadsUp.prefPane image }
  sh %{ rm -f HeadsUp.dmg }
  sh %{ hdiutil create -volname HeadsUp -srcfolder image HeadsUp.dmg }
  sh %{ rm -r image }
end
