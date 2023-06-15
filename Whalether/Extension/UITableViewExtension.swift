import Foundation
import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type, bundle: Bundle) {
      let identifier = String(describing: cellType.self)
      let nib = UINib(nibName: identifier, bundle: bundle)
      register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeue<T: UITableViewCell>(_ cellType: T.Type) -> T {
        let identifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("Could not dequeue cellType: \(identifier)")
        }
        
        return cell
    }
}
