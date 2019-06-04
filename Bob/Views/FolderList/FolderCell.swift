import UIKit

class FolderCell: UITableViewCell {
    var deleteFolder: (() -> Void)? = nil
    var sendFolder: (() -> Void)? = nil
    @IBAction func cellButtonSend(_ sender: Any) {
        sendFolder?()
    }
    @IBAction func cellButtonDelete(_ sender: Any) {
        deleteFolder?()
    }
    @IBOutlet weak var folderCard: FolderCard!
    @IBOutlet weak var folderTitle: UILabel!
}
