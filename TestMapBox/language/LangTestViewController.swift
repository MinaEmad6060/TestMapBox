import UIKit

class LangTestViewController: UIViewController {

    @IBOutlet weak var labelLang: UILabel!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Listen for language change notification
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: LocalizationService.changedLanguage, object: nil)

        // Initial text update based on the current language
        updateTexts()
    }

    @objc func languageChanged() {
        // Handle language change, like updating UI text here
        updateTexts()

        // Update the layout direction
        updateLayoutDirection()
    }

    private func updateTexts() {
        // Update UI elements based on the new language
        self.button.setTitle(NSLocalizedString("button_title", comment: ""), for: .normal)
        self.labelLang.text = NSLocalizedString("label_text", comment: "")
    }

    private func updateLayoutDirection() {
        // Set layout direction based on current language
        let isRTL = LocalizationService.shared.language.isRTL
        UIView.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        
        // Reload the root view controller to apply layout direction
        reloadRootViewController()
    }

    @IBAction func changeLanguageTapped(_ sender: UIButton) {
        // Switch language between Arabic and English
        let newLanguage: Language = LocalizationService.shared.language == .arabic ? .english_us : .arabic
        LocalizationService.shared.changeLanguage(to: newLanguage)
    }

    func reloadRootViewController() {
        guard let window = UIApplication.shared.windows.first else { return }
        let rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
class LocalizationService {

    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")

    private init() {}

    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "language") else {

                var languageCode = ""

                if #available(iOS 16, *) {
                    languageCode = NSLocale.current.language.languageCode?.identifier ?? ""
                } else {
                    // Fallback on earlier versions
                    languageCode = NSLocale.current.languageCode ?? ""
                }

                // Set default language based on the system's current language
                if languageCode == Language.arabic.rawValue {
                    UserDefaults.standard.setValue(Language.arabic.rawValue, forKey: "language")
                    return .arabic
                } else {
                    UserDefaults.standard.setValue(Language.english_us.rawValue, forKey: "language")
                    return .english_us
                }
            }

            return Language(rawValue: languageString) ?? .english_us
        }

        set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "language")
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }

    func changeLanguage(to newLanguage: Language) {
        language = newLanguage
    }
}
enum Language: String {
    case arabic = "ar"
    case english_us = "en"
    case ukrainian = "uk"

    var isRTL: Bool {
        return self == .arabic
    }
}
