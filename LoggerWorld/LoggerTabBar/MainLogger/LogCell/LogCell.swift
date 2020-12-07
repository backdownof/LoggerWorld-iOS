//
//  LogCell.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 07.12.2020.
//

import UIKit

class LogCell: UITableViewCell {

    @IBOutlet weak var logMessageLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var message: LogMessage? {
        didSet {
            var messageText = ""
            if let logMessage = message?.message {
                if let logType = message?.logClass {
                    messageText += "\(logType): "
                }
                messageText += logMessage
                logMessageLabel.text = messageText
            }
            
            if let logTime = message?.dateTime {
                var dateFor: DateFormatter = DateFormatter()
                dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"

                var yourDate: Date? = dateFor.date(from: logTime)
                var calendar = Calendar.current
                var hours = calendar.component(.hour, from: yourDate!)
                var minutes = calendar.component(.minute, from: yourDate!)
                
                dateTimeLabel.text = "\(hours):\(minutes)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
