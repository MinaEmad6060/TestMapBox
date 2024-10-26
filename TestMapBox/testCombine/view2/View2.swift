import UIKit

// Custom UIView class
import UIKit

// Custom UIView class
class View2: UIView {
    
    @IBOutlet var view: UIView! // Outlet to connect the view in XIB
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "View2", bundle: nil)
        guard let loadedView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        view = loadedView
        addSubview(view)
        
        // Set constraints to fill the entire view
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View2 commonInit called")

        // Create an instance of your custom view
        let customView = View2()
        customView.backgroundColor = .green
        customView.frame = view.bounds // Set frame for the custom view
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Resize with parent view
        
        view.addSubview(customView) // Add custom view to the main view
    }
}

