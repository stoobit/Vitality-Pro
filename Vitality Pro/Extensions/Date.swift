import Foundation

extension Date {
    func getWeekday() -> String {
         let weekday = Calendar.current.component(
            .weekday, from: self
         )
        
        switch weekday {
        case 1: 
            return "Sunday"
        case 2: 
            return "Monday"
        case 3: 
            return "Tuesday"
        case 4: 
            return "Wednesday"
        case 5: 
            return "Thursday"
        case 6: 
            return "Friday"
        case 7: 
            return "Saturday"
        default: 
            return "error"
        }
    }
}
