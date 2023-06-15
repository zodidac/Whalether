import Foundation

class UserProfile {
    static let shared = UserProfile()
    var profile: Profile?
    let userDefaults = UserDefaults.standard
    init(){}
    
    func saveProfile() {
        do {
            try userDefaults.setObject(profile, forKey: "profile")
            userDefaults.synchronize()
            NotificationCenter.default.post(name: Notification.Name("UserChanged"), object: nil)
        } catch {
            print("error to save profile")
        }
    }
    
    func setDisplayName(displayName: String) {
        profile?.name = displayName
        saveProfile()
    }
    
    func getProfile() -> Profile? {
        loadProfile()
        return profile
    }
    
    func loadProfile() {
        do {
            let loadedProfile: Profile = try userDefaults.getObject(forKey: "profile", castTo: Profile.self)
            profile = loadedProfile
        } catch {
            profile = nil
            print("error to load profile")
        }
    }
    
    func clearProfile() {
        profile = nil
        do {
            try userDefaults.setObject(profile, forKey: "profile")
            userDefaults.synchronize()
            NotificationCenter.default.post(name: Notification.Name("UserChanged"), object: nil)
        } catch {
            print("error to save profile")
        }
    }
    
    func setProfile(uid: String, email: String?, name: String?) {
        profile = Profile(uid: uid, email: email, name: name)
        saveProfile()
    }
}


struct Profile: Codable {
    var uid: String
    var email: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case name
    }
}
