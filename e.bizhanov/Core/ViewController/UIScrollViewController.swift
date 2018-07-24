import UIKit

private var UIActiveElementBottomMargin: CGFloat = 34

/**
 Базовый контроллер, в основе которого лежит `UIScrollView`. Автоматически поднимает активное/редактируемое поле над областью перекрытия клавиатурой
 - Precondition: В наследуемом контроллере, в иерархии объектов должен находиться `UIScrollView`.
 - Note: Реализация контроллера такова, что поиск экземпляра `UIScrollView` будет выполнен с корневого `UIView`.
 
 * Если `UIScrollView` на экране несколько, будет взят ближайший к корневому `UIView`
 
 * Если `UIScrollView` не будет найден, `UIScrollViewController` будет работать как обычный `UIViewController`
 */
class UIScrollViewController: UIBaseViewController {
    
    /// Первый найденный скролл сверху по иерархии объектов
    lazy private(set) var scrollView: UIScrollView? = findScrollView(in: self.view)
    
    private var kbInfo: KeyboardUserInfo?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
        // Добавляем обработку тапа по вью
        setupView()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    // MARK: - Настройка контроллера
    fileprivate func setupView() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    // Добавляем подписку на события клавиатуры
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: .UIKeyboardWillShow,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: .UIKeyboardWillHide,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow),
            name: .UIKeyboardDidShow,
            object: nil
        )
    }
    
    // Удаляем подписку на события клавиатуры
    fileprivate func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
    }
    
    // MARK: - Обработка событий клавиатуры
    @objc fileprivate func keyboardWillShow(notification: Notification) {
        guard let dictionary = notification.userInfo else {
            print("Keyboard userInfo is nil")
            return
        }
        
        kbInfo = kbInfo ?? KeyboardUserInfo(dictionary)
        kbInfo?.setNewSize(dictionary)
        
        moveGestureRecognizers(toState: false)

        // Инициируем начальный отступ от клавиатуры (что бы редактируемое поле не прилипало к клавиатуре)
        var bottomPadding = UIActiveElementBottomMargin
        
        if #available(iOS 11.0, *) {
            bottomPadding -= view.safeAreaInsets.bottom
        }
        
        let kbHeight = kbInfo?.size.height ?? 0
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbHeight + bottomPadding, right: 0)
        scrollView?.contentInset = contentInset
    }
    
    @objc fileprivate func keyboardDidShow(notification: Notification) {
        moveGestureRecognizers(toState: true)
    }
    
    @objc fileprivate func keyboardWillHide(notification: Notification) {
        // Ставим задержку на величину длительности анимации клавиатуры
        self.scrollView?.contentInset = .zero
    }
    
    @objc fileprivate func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Служебные методы контроллера
extension UIScrollViewController {
    /// Рекурсивный поиск `UIScrollView`
    ///
    /// - Parameter view: Корневой элемент от которого будет выполнен поиск
    fileprivate func findScrollView(in view: UIView) -> UIScrollView? {
        var scrollView: UIScrollView?
        
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                return scrollView
            } else {
                scrollView = findScrollView(in: subview)
            }
        }
        
        return scrollView
    }
    
    /// Активация/деактивация распознавателей жестов
    ///
    /// - Parameter state: состояние в которое необходимо привести объекты:
    ///   * вкл - `true`
    ///   * выкл - `false`
    fileprivate func moveGestureRecognizers(toState state: Bool) {
        guard let gestureRecognizers = view.gestureRecognizers else { return }
        for gestureRecognizer in gestureRecognizers {
            gestureRecognizer.isEnabled = state
        }
    }
}

// MARK: - Вспомогательные структуры данных
private struct KeyboardUserInfo {
    
    public private(set) var size: CGSize
    public let duration: Double
    public let animationCurve: UIViewAnimationCurve?
    
    fileprivate mutating func setNewSize(_ dictionary: [AnyHashable: Any]) {
        size = (dictionary[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size ?? size
    }
    
    init(_ dictionary: [AnyHashable: Any]) {
        size = CGSize(width: 0, height: 0)
        duration = dictionary[UIKeyboardAnimationDurationUserInfoKey] as? Double ?? 0
        animationCurve = UIViewAnimationCurve(rawValue: dictionary[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0)
    }
}
