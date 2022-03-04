
import Foundation
import UIKit

//************************************
fileprivate let backContents      = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
fileprivate let TextColor         = #colorLiteral(red: 0.4117647059, green: 0.4392156863, blue: 0.4666666667, alpha: 1)
fileprivate let lineBackground    = #colorLiteral(red: 0.5716558223, green: 0.615860935, blue: 0.6777142397, alpha: 1)

fileprivate let btn1Background    = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
fileprivate let btn2Background    = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
fileprivate let btn1Text          = #colorLiteral(red: 0.2941176471, green: 0.5529411765, blue: 0.8431372549, alpha: 1)
fileprivate let btn2Text          = #colorLiteral(red: 0.2941176471, green: 0.5529411765, blue: 0.8431372549, alpha: 1)
//************************************


class UAlertController: UIViewController {

    var m_title    : String?
    var m_message  : String?
    var m_attString: NSAttributedString?
    
    private var actions: [UAlertAction] = [UAlertAction]()
    private var con1: NSLayoutConstraint!
    private var con2: NSLayoutConstraint!
    
    let contentsView: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = backContents
        uv.layer.cornerRadius = 8.0
        uv.clipsToBounds = true
        return uv
    }()
    
    let scrollView: UIScrollView = {
        let scr = UIScrollView()
        scr.translatesAutoresizingMaskIntoConstraints = false
        scr.bounces = false
        return scr
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var lblTopTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = TextColor
        lbl.backgroundColor = .clear
        lbl.font = UIFont.boldSystemFont(ofSize: 19)
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let lblText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = TextColor
        lbl.backgroundColor = .clear
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.sizeToFit()
        return lbl
    }()

    let lineHorizonal: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = lineBackground
        return uv
    }()
    let lineVertical: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = lineBackground
        return uv
    }()
    
    func setButton(tag: Int, title: String, colorStyle: ColorStype) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        switch colorStyle {
        case .standard:
            btn.setTitleColor(btn1Text, for: .normal)
            btn.setBackgroundColorM(color: btn1Background, forState: .normal)
            btn.setBackgroundColorM(color: btn1Background.withAlphaComponent(0.7), forState: .highlighted)
            break
        case .emphasis :
            btn.setTitleColor(btn2Text, for: .normal)
            btn.setBackgroundColorM(color: btn2Background, forState: .normal)
            btn.setBackgroundColorM(color: btn2Background.withAlphaComponent(0.7), forState: .highlighted)
            break
        }
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        btn.tag = tag
        return btn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(title: String, message: String, attString : NSAttributedString? = nil){
        self.init(nibName: nil, bundle: nil)
        
        self.m_title        = title
        self.m_message      = message
        self.m_attString    = attString
        
        self.modalTransitionStyle   = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        if let attStr = self.m_attString {
            self.lblText.attributedText = attStr
        }else{
            self.lblText.text  = self.m_message
        }
        
        self.view.addSubview(contentsView)
        self.contentsView.addSubview(scrollView)
        self.scrollView.addSubview(backView)
        self.backView.addSubview(lblText)
        self.contentsView.addSubview(lineHorizonal)
        
        NSLayoutConstraint.activate([
            contentsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/5, constant: 20),
            contentsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        if actions.count == 1 {
            let btn = setButton(tag: 1, title: actions[0].m_title! ,colorStyle: actions[0].m_style! )
            self.contentsView.addSubview(btn)
            NSLayoutConstraint.activate([
                btn.topAnchor.constraint(equalTo: lineHorizonal.bottomAnchor),
                btn.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor),
                btn.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor),
                btn.heightAnchor.constraint(equalToConstant: 43),
                btn.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor),
            ])
            
        }else if actions.count >= 2 {
            let btn1 = setButton(tag: 1, title: actions[0].m_title! ,colorStyle: actions[0].m_style! )
            let btn2 = setButton(tag: 2, title: actions[1].m_title! ,colorStyle: actions[1].m_style! )
            
            self.contentsView.addSubview(btn1)
            self.contentsView.addSubview(btn2)
            self.contentsView.addSubview(lineVertical)
            
            NSLayoutConstraint.activate([
                lineVertical.topAnchor.constraint(equalTo: lineHorizonal.bottomAnchor),
                lineVertical.centerXAnchor.constraint(equalTo: contentsView.centerXAnchor),
                lineVertical.widthAnchor.constraint(equalToConstant: 1),
                lineVertical.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor),
                
                btn1.topAnchor.constraint(equalTo: lineHorizonal.bottomAnchor),
                btn1.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor),
                btn1.trailingAnchor.constraint(equalTo: lineVertical.trailingAnchor),
                btn1.heightAnchor.constraint(equalToConstant: 43),
                btn1.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor),
                
                btn2.topAnchor.constraint(equalTo: lineHorizonal.bottomAnchor),
                btn2.leadingAnchor.constraint(equalTo: lineVertical.trailingAnchor),
                btn2.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor),
                btn2.heightAnchor.constraint(equalToConstant: 43),
                btn2.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentsView.topAnchor, constant: 15),
            scrollView.bottomAnchor.constraint(equalTo: actions.count == 0 ? contentsView.bottomAnchor : lineHorizonal.topAnchor, constant: -15),
            scrollView.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor, constant: 5),
            scrollView.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: -5),
        ])
        
        con1 = backView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.0)
        con2 = contentsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            con1,
        ])
        
        
        if self.m_title == "" {
            NSLayoutConstraint.activate([
                lblText.topAnchor.constraint(equalTo: backView.topAnchor),
                lblText.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor),
                lblText.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor),
                lblText.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            ])
            
        }else{
            self.lblTopTitle.text = self.m_title
            
            self.backView.addSubview(lblTopTitle)
            
            NSLayoutConstraint.activate([
                lblTopTitle.topAnchor.constraint(equalTo: backView.topAnchor),
                lblText.topAnchor.constraint(equalTo: lblTopTitle.bottomAnchor, constant: 5),
                lblText.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
                
                lblTopTitle.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
                lblTopTitle.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                lblText.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
                lblText.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            lineHorizonal.heightAnchor.constraint(equalToConstant: 1),
            lineHorizonal.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor),
            lineHorizonal.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor),
        ])
        
    }
    
    @objc func btnClick(sender:UIButton){
        dismiss(animated: true) {
            if let handler = self.actions[sender.tag-1].completionHandler{
                handler()
            }
        }
    }
    
    public func addAction(_ action: UAlertAction){
        actions.append(action)
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if contentsView.bounds.height > view.bounds.height {
            con1.isActive = false
            con2.isActive = true
        }
    }
}


public enum ColorStype {
    case emphasis
    case standard
}

class UAlertAction {
    var m_title   : String?
    var m_style   : ColorStype?
    var completionHandler: (() -> Void)?
    
    init(title: String, style: ColorStype = .standard, handler: (() -> Void)? ){
        self.m_title      = title
        self.m_style      = style
        completionHandler = handler
    }
}

private extension UIButton {
    func setBackgroundColorM(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}
