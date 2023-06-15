import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var minTempLabel: UILabel!
    @IBOutlet private var maxTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(day: String, minTemp: String, maxTemp: String) {
        dayLabel.text = day
        minTempLabel.text = minTemp
        maxTempLabel.text = maxTemp
    }
}
