import SwiftUI

extension ContentView {
    
    func loadDays() {
        let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.object(forKey: userdefaultskey) as? Data {
            do{
                days = try JSONDecoder()
                    .decode([String: Day].self, from: savedData)
            } catch { }
        }
    }
    
    func saveDays() {
        do {
            let encodedData = try JSONEncoder().encode(days)
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(encodedData, forKey: userdefaultskey)
        } catch { }
    }
    
    func setDays() {
        let date = try? JSONDecoder().decode(Date.self, from: date)
        guard let date = date else { 
            try! self.date = JSONEncoder().encode(Date())
            for weekday in weekdays {
                days[weekday] = Day()
            }
            return
        }
        
        if Calendar.current.isDateInThisWeek(date) == false {
            days = [:]
            
            for weekday in weekdays {
                days[weekday] = Day()
            }
            
            saveDays()
        } else {
            loadDays()
        }
        
        try! self.date = JSONEncoder().encode(Date())
    }
    
}
