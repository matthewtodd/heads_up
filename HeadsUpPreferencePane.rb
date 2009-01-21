require 'osx/cocoa'

class HeadsUpApplication < OSX::NSObject
  attr_reader :enabled

  def enabled=(state)
    willChangeValueForKey(:enabled)
    # TODO everything else
    puts "received enabled= with #{state.inspect}"
    didChangeValueForKey(:enabled)
    state
  end
end

class HeadsUpPreferences < OSX::NSObject
  attr_reader :identifier

  def initWithBundleIdentifier(identifier)
    @identifier = identifier
    self
  end

  def valueForKey(key)
    OSX::CFPreferencesCopyAppValue(key, identifier)
  end

  def setValue_forKey(value, key)
    willChangeValueForKey(key)
    OSX::CFPreferencesSetAppValue(key, value, identifier)
    OSX::CFPreferencesAppSynchronize(identifier)
    OSX::NSDistributedNotificationCenter.defaultCenter.postNotificationName_object('HeadsUpPreferencesChanged', identifier)
    didChangeValueForKey(key)
    value
  end

  def refresh
    all_preference_keys.each { |key| willChangeValueForKey(key) }
    OSX::CFPreferencesAppSynchronize(identifier)
    all_preference_keys.each { |key| didChangeValueForKey(key) }
  end

  private

  def all_preference_keys
    OSX::CFPreferencesCopyKeyList(identifier, OSX::KCFPreferencesCurrentUser, OSX::KCFPreferencesAnyHost)
  end
end

class HeadsUpPreferencePane < OSX::NSPreferencePane
  attr_accessor :application, :preferences

  def initWithBundle(bundle)
    super_initWithBundle(bundle)
    self.application = HeadsUpApplication.alloc.init
    self.preferences = HeadsUpPreferences.alloc.initWithBundleIdentifier(bundle.bundleIdentifier)
    self
  end

  def willSelect
    preferences.refresh
  end
end
