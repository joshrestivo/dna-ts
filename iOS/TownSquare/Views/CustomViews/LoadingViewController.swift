
import Foundation
class LoadingManager : NSObject {
    
    var loading: LoadingViewController!
    var visibleViewController: UIViewController!
    
    class var shared : LoadingManager {
        struct Static {
            static let instance : LoadingManager = LoadingManager()
        }
        return Static.instance
    }
    
    override init() {
        super.init()
        loading = UIView.fromNib("LoadingView")
    }
    
    func showLoading(_ msg: String) {
        DispatchQueue.main.async {
            if self.visibleViewController != nil {
                self.loading.updateMessageLoading(msg)
                self.visibleViewController.view.addSubview(self.loading)
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loading.removeFromSuperview()
            self.visibleViewController = nil
        }
    }
}

class LoadingViewController : UIView {
    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = UIScreen.main.bounds
    }

    func updateMessageLoading(_ msg: String){
        Utils.startSpinning(imgLoading)
        lblMessage.text = msg
    }
}
