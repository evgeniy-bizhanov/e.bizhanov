//
// Расширения UIKit компонентов
//

import  UIKit

/// Инкапсулирует загрузку из Nib файла
@IBDesignable class UINibView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}

extension UIView {
    /// Вспомогательный метод для загрузки из `Nib`
    func xibSetup() {
        let view = loadFromNib()
        stretch(view: view)
        
        addSubview(view)
    }
    
    /// Инициализирует `View` из `Nib`
    ///
    /// - Returns: Возвращает `UIView`, для класса с таким же именем, что и `Nib`
    fileprivate func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }

        return view
    }
    
    /// Растягивает `Nib` по высоте и ширине родительской view
    ///
    /// - Parameter view: Обрабатываемая View
    fileprivate func stretch(view: UIView) {
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

// MARK: - UIViewController
extension UIViewController {
    // Рекурсия
    /**
      Рекурсивный поиск всех `T: UIView` удовлетворяющих условию фильтра
    
      - Parameters:
        - view: `UIView`, в котором необходимо выполнить поиск
        - filter: критерий, которому должны удовлетворять элементы, для попадания в выборку
        - item: элемент к которому применяется действие фильтра
    
      - Returns: возвращает коллекцию элементов наследуемых от `UIView` и удовлетворяющих критериям выборки
      */
    func views<T: UIView>(in view: UIView, withFilter filter: @escaping (_ item: T) -> Bool) -> [T] {
        var result = [T]()
        
        for view in view.subviews {
            result.append(contentsOf: views(in: view, withFilter: filter))
        }
        
        if let view = view as? T,
            filter(view) {
            result.append(view)
        }
        
        return result
    }
}

// MARK: - UIColor
extension UIColor {
    /// Инициирует `UIColor` из значения в HEX представлении
    ///
    /// - Parameter value: Значение в HEX
    convenience public init(hex value: Int) {
        self.init(hex: value, alpha: 1.0)
    }
    
    /// Инициирует `UIColor` из значения в HEX представлении
    ///
    /// - Parameter value: Значение в HEX
    /// - Parameter alpha: Альфа-канал (прозрачность) от 0.0, до 1.0
    convenience public init(hex value: Int, alpha: CGFloat) {
        let red = Double(value >> 16 & 0xFF) / 255.0
        let green = Double(value >> 8 & 0xFF) / 255.0
        let blue = Double(value >> 0 & 0xFF) / 255.0
        self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
    }
}
