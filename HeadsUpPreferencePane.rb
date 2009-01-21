require 'osx/cocoa'

class HeadsUpPreferencePane < OSX::NSPreferencePane
  APPLICATION_ID = 'org.matthewtodd.HeadsUp'

  def valueForKey(key)
    OSX::CFPreferencesCopyAppValue(key, APPLICATION_ID)
  end

  def setValue_forKey(value, key)
    willChangeValueForKey(key)
    OSX::CFPreferencesSetAppValue(key, value, APPLICATION_ID)
    OSX::CFPreferencesAppSynchronize(APPLICATION_ID)
    # TODO send a Distributed Notification that we changed something
    didChangeValueForKey(key)
    value
  end

  def willSelect
    all_preference_keys.each { |key| willChangeValueForKey(key) }
    OSX::CFPreferencesAppSynchronize(APPLICATION_ID)
    all_preference_keys.each { |key| didChangeValueForKey(key) }
  end

  private

  def all_preference_keys
    OSX::CFPreferencesCopyKeyList(APPLICATION_ID, OSX::KCFPreferencesCurrentUser, OSX::KCFPreferencesAnyHost)
  end
end
