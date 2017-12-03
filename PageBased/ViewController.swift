
import UIKit

protocol SwitchPageProtocol: class {
    func pageToSwitch(to page: Int)
}

class ViewController: UIViewController, SwitchHighlightedButtonDelegate {

    weak var switchPageDelegate: SwitchPageProtocol?
    
    var lineView: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineView = UIView(frame: CGRect(x: 0, y: 48, width: self.view.frame.width/3, height: 2))
        lineView.backgroundColor = UIColor.red
        
        buttons.first?.addSubview(lineView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pageController = segue.destination as! PageViewController
        switchPageDelegate = pageController
        pageController.highlightDelegate = self
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        highlight(buttonNumber: sender.tag)
        switchPageDelegate?.pageToSwitch(to: sender.tag)
    }
    
    func highlight(buttonNumber: Int) {
        lineView.removeFromSuperview()
        buttons[buttonNumber].addSubview(lineView)
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
}
