//
//  SettingsManager.swift
//  EventUally
//
//  Created by Matthew Sakhnenko on 26.02.2022.
//

import Foundation

@propertyWrapper
struct Persist<T> {
  let key: String
  let defaultValue: T
 
  var wrappedValue: T {
    get {
      return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}

enum GlobalSettings {
    @Persist(key: "hasOnboarded", defaultValue: false)
    static var hasOnboarded: Bool
}
