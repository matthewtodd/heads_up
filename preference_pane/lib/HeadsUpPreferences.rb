require 'osx/cocoa'

class HeadsUpPreferences < OSX::NSObject
  attr_reader :identifier

  def initWithBundleIdentifier(identifier)
    init
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
    OSX::CFPreferencesCopyKeyList(identifier, OSX::KCFPreferencesCurrentUser, OSX::KCFPreferencesAnyHost) || []
  end
end
