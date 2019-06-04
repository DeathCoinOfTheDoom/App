import UIKit

class FolderCell: UITableViewCell {
    var actionBlock: (() -> Void)? = nil
    @IBAction func cellButton(_ sender: Any) {
        actionBlock?()
    }
    @IBOutlet weak var folderCard: FolderCard!
    @IBOutlet weak var folderTitle: UILabel!
}
