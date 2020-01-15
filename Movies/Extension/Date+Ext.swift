
import Foundation

extension Date {
    //Setting Date to particular format
    func toString(withFormat format: String = DateFormatConstants.ddMMMMyyyyFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: DateFormatConstants.locale)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
