
import UIKit

protocol SwitchHighlightedButtonDelegate: class {
    func highlight(buttonNumber: Int)
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, SwitchPageProtocol, UIScrollViewDelegate {

    var pages: [UIViewController]!
    var currentIndex = 0
    
    weak var highlightDelegate: SwitchHighlightedButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
        
        pages = [
            (storyboard?.instantiateViewController(withIdentifier: "page1"))!,
            (storyboard?.instantiateViewController(withIdentifier: "page2"))!,
            (storyboard?.instantiateViewController(withIdentifier: "page3"))!
        ]
        
        setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let vcIndex = pages.index(of: (viewControllers?.first)!)!
        highlightDelegate?.highlight(buttonNumber: vcIndex)
        currentIndex = vcIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        guard pages.count != nextIndex else { return nil }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
    func pageToSwitch(to page: Int) {
        if page > currentIndex {
            setViewControllers([pages[page]], direction: .forward, animated: true, completion: nil)
            currentIndex = page
            
        } else if page < currentIndex {
            setViewControllers([pages[page]], direction: .reverse, animated: true, completion: nil)
            currentIndex = page
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let point = scrollView.contentOffset;
//        let percentComplete = fabs(point.x - self.view.frame.size.width)/self.view.frame.size.width * 100
//        print("\(scrollView.contentOffset.x) \(view.frame.size.width)")
//        print(percentComplete)
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
}
