
import Foundation

extension String {
    //Setting String to particular Date format
    func toDate(withFormat format: String = DateFormatConstants.yyyyMMddFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: DateFormatConstants.locale)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
