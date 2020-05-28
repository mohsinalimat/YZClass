//
// YZLinkLable.swift
// YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import Foundation
import UIKit

/// It is used to define `YZLinkLableDetector` types.
public enum YZLinkLableDetector {
    case mention
    case hashTag
    case url
    case custom(pattern: String)
    var pattern: String {
        switch self {
        case .mention: return "(?:^|\\s|$)#[\\p{L}0-9_]*"
        case .hashTag: return "(?:^|\\s)@[\\p{L}0-9._-]*"
        case .url: return "(^|[\\s.:;?\\-\\]<\\(])" +
            "((https?://|www\\.|pic\\.)[-\\w;/?:@&=+$\\|\\_.!~*\\|'()\\[\\]%#,☺]+[\\w/#](\\(\\))?)" +
        "(?=$|[\\s',\\|\\(\\).:;?\\-\\[\\]>\\)])"
        case .custom(let regex): return regex
        }
    }
    
    fileprivate static func getElementsFrom(_ texts: String, pattern: String, range: NSRange) -> [NSTextCheckingResult]? {
        if texts.isEmpty {return nil}
        do {
            let elementRegex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            return elementRegex.matches(in: texts, options: [], range: NSRange(texts.startIndex..., in: texts))
        } catch let error {
            print(#function + " : " + error.localizedDescription)
            return []
        }
    }
}

//MARK: - Protocol YZLinkLabelDelagete
/// It is used get detected string events
public protocol YZLinkLabelDelagete: class {
    func didTapOn(_ text: String?, linkLabel: YZLinkLabel, detector: YZLinkLableDetector?)
}

//MARK: - Class YZSelectedAttribute
fileprivate class YZSelectedAttribute: NSObject {
    var range: NSRange!
    var type: YZLinkLableDetector = .hashTag
}

//MARK: - Class YZLinkLabel
/// It is used to detect HashTags, Mentions and URLs from given texts.
public class YZLinkLabel: UILabel, UITextViewDelegate {
    public var arrOfHashTags: [NSTextCheckingResult] = [] //It is used to get number of count for hash tags.
    public var arrOfMentions: [NSTextCheckingResult] = [] //It is used to get number of count for mentions tags.
    public var arrOfURLs: [NSTextCheckingResult] = []  //It is used to get number of count for URLs.
    public weak var delegate: YZLinkLabelDelagete? //It is used to set delegate to get events.
    
    private var arrOfUserName: [NSRange] = []
    private lazy var textStorage = NSTextStorage()
    private lazy var layoutManager = NSLayoutManager()
    private lazy var textContainer = NSTextContainer()
    private var heightCorrection: CGFloat = 0
    private var arrOfSelectedAttributes: [YZSelectedAttribute] = []
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    public override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        textContainer.size = CGSize(width: superSize.width, height: CGFloat.greatestFiniteMagnitude)
        let size = layoutManager.usedRect(for: textContainer)
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }

    public override func drawText(in rect: CGRect) {
        let range = NSRange(location: 0, length: textStorage.length)
        textContainer.size = rect.size
        let newOrigin = textOrigin(inRect: rect)
        layoutManager.drawBackground(forGlyphRange: range, at: newOrigin)
        layoutManager.drawGlyphs(forGlyphRange: range, at: newOrigin)
        setNeedsDisplay()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if onTouch(touch: touch) { return }
        super.touchesBegan(touches, with: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if onTouch(touch: touch) { return }
        super.touchesBegan(touches, with: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if onTouch(touch: touch) { return }
        super.touchesMoved(touches, with: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = onTouch(touch: touch)
        super.touchesCancelled(touches, with: event)
    }

    fileprivate func setupLabel() {
        textStorage.setAttributedString(attributedText!)
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = .byTruncatingTail
        textContainer.maximumNumberOfLines = 0
        isUserInteractionEnabled = true
    }
    
    /// It is used to set attributed texts.
    /// - Parameters:
    ///   - attributedString: `NSAttributedString` type object.
    ///   - linebreak: `NSLineBreakMode` type object. Default value is **.byTruncatingTail**.
    public func set(_ attributedString: NSAttributedString, linebreak : NSLineBreakMode = .byTruncatingTail){
        attributedText = attributedString
        textContainer.lineBreakMode = linebreak
        textStorage.setAttributedString(attributedString)
        setNeedsDisplay()
        
        let str = NSString(string: attributedString.string)
        let range = str.range(of: str as String)
        
        if let arrOfHashTags = YZLinkLableDetector.getElementsFrom(attributedText!.string, pattern: YZLinkLableDetector.hashTag.pattern, range: range) {
            self.arrOfHashTags = arrOfHashTags
        }
        if let arrOfMentions = YZLinkLableDetector.getElementsFrom(attributedText!.string, pattern: YZLinkLableDetector.mention.pattern, range: range) {
            self.arrOfMentions = arrOfMentions
        }
        if let arrOfURLs = YZLinkLableDetector.getElementsFrom(attributedText!.string, pattern: YZLinkLableDetector.url.pattern, range: range) {
            self.arrOfURLs = arrOfURLs
        }
        
        arrOfUserName = []
        attributedString.enumerateAttribute(NSAttributedString.Key.attachment, in: range, options: []) { (attribute, rangeOfAtt, data) in
            if let _ = attribute {
                arrOfUserName.append(rangeOfAtt)
            }
        }
    }

    private func textOrigin(inRect rect: CGRect) -> CGPoint {
        let usedRect = layoutManager.usedRect(for: textContainer)
        heightCorrection = (rect.height - usedRect.height)/2
        let glyphOriginY = heightCorrection > 0 ? rect.origin.y + heightCorrection : rect.origin.y
        return CGPoint(x: rect.origin.x, y: glyphOriginY)
    }
    
    private func onTouch(touch: UITouch) -> Bool {
        var avoidSuperCall = false
        var touchPoint:CGPoint = touch.location(in: self)
        touchPoint.y -= heightCorrection
        let glyphRect = layoutManager.boundingRect(forGlyphRange: NSMakeRange(0, attributedText!.string.utf16.count), in: textContainer)
        switch touch.phase {
        case .began, .moved:
            
            for hashTag in arrOfHashTags {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= hashTag.range.location && idx <= (hashTag.range.length + hashTag.range.location){
                        break
                    }
                }
            }
            
            for mention in arrOfMentions {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= mention.range.location && idx <= (mention.range.length + mention.range.location){
                        break
                    }
                }
            }
            
            for url in arrOfURLs {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= url.range.location && idx <= (url.range.length + url.range.location){
                        break
                    }
                }
            }
            
            for userName in arrOfUserName {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= userName.location && idx <= (userName.length + userName.location){
                        break
                    }
                }
            }
            
            avoidSuperCall = true
            break
        case .ended:
            var tapFound = false
            for mention in arrOfMentions {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= mention.range.location && idx <= (mention.range.length + mention.range.location){
                        let attributedSubstring = textStorage.attributedSubstring(from: mention.range)
                        delegate?.didTapOn(attributedSubstring.string, linkLabel: self, detector: .mention)
                        tapFound = true
                        break
                    }
                }
            }
            
            for hashTag in arrOfHashTags {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= hashTag.range.location && idx <= (hashTag.range.length + hashTag.range.location){
                        let attributedSubstring = textStorage.attributedSubstring(from: hashTag.range)
                        delegate?.didTapOn(attributedSubstring.string, linkLabel: self, detector: .hashTag)
                        tapFound = true
                        break
                    }
                }
            }
            
            for url in arrOfURLs {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= url.range.location && idx <= (url.range.length + url.range.location){
                        let attributedSubstring = textStorage.attributedSubstring(from: url.range)
                        delegate?.didTapOn(attributedSubstring.string, linkLabel: self, detector: .url)
                        tapFound = true
                        break
                    }
                }
            }
            
            for userName in arrOfUserName {
                if glyphRect.contains(touchPoint) {
                    let idx = layoutManager.glyphIndex(for: touchPoint, in: textContainer)
                    if idx >= userName.location && idx <= (userName.length + userName.location){
                        attributedText!.enumerateAttribute(NSAttributedString.Key.attachment, in: userName, options: []) { (attribute, rangeOfAtt, data) in
                            if let attribute = attribute {
                                delegate?.didTapOn(attribute as? String, linkLabel: self, detector: .mention)
                            }
                        }
                        tapFound = true
                        break
                    }
                }
            }
            
            if !tapFound{
                delegate?.didTapOn(nil, linkLabel: self, detector: nil)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {self.removeAttributes()})
            
            avoidSuperCall = true
            
            break
        case .cancelled:
            removeAttributes()
            break
        case .stationary:
            removeAttributes()
            break
        case .regionEntered:
            print(#function + " : .regionEntered")
        case .regionMoved:
            print(#function + " : .regionMoved")
        case .regionExited:
            print(#function + " : .regionExited")
        @unknown default:
            fatalError("NO MORE UITouch.Phase FOUND.")
        }
        return avoidSuperCall
    }
    
    fileprivate func setAttributeFor(_ range: NSRange, actType: YZLinkLableDetector){
        removeAttributes()
        
        let objSelectedAttribute = YZSelectedAttribute()
        objSelectedAttribute.range = range
        objSelectedAttribute.type = actType
        arrOfSelectedAttributes.append(objSelectedAttribute)
        
        let attributes: [NSAttributedString.Key: AnyObject]!
        switch actType {
        case .hashTag:
            attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            break
        case .mention:
            attributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
            break
        default:
            attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            break
        }
        
        textStorage.addAttributes(attributes, range: range)
        
        setNeedsDisplay()
    }
    
    fileprivate func removeAttributes() {
        
        for item in arrOfSelectedAttributes {
            let attri: [NSAttributedString.Key: AnyObject]!
            switch item.type {
            case .hashTag:
                attri = [NSAttributedString.Key.foregroundColor: UIColor.gray]
                break
            case .mention:
                attri = [NSAttributedString.Key.foregroundColor: UIColor.red]
                break
            default:
                attri = [NSAttributedString.Key.foregroundColor: UIColor.red]
                break
            }
            textStorage.addAttributes(attri, range: item.range)
        }
        
        arrOfSelectedAttributes = []
        
        setNeedsDisplay()
    }
}

//MARK: UIGestureRecognizerDelegate
extension YZLinkLabel: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: - String Extension(s)
extension String {
    
    /// It is used to prepare `NSAttributedString` to highlight texts, based on given parameters.
    /// - Parameters:
    ///   - defaultFont: `UIFont` type object to apply default font.
    ///   - defaultColor: `UIColor` type object to apply default color.
    ///   - hashTagFont: `UIFont` type object to apply font on hash tag texts.
    ///   - hashColor: `UIColor` type object to apply color on hash tag texts.
    ///   - mentionFont: `UIFont` type object to apply font on mention texts.
    ///   - mentionColor: `UIColor` type object to apply color on mention texts.
    ///   - alignment: `NSTextAlignment` type object to set text alignments.
    /// - Returns: It will return `NSAttributedString` type object.
    public func getHighlightedTexts(_ defaultFont: UIFont, defaultColor: UIColor,
                                    hashTagFont: UIFont, hashColor: UIColor,
                                    mentionFont: UIFont, mentionColor: UIColor,
                                    alignment: NSTextAlignment = .natural) -> NSAttributedString {
        let attbStr = NSMutableAttributedString(string: self)
        let str = NSString(string: self)
        let range = str.range(of: str as String)
        
        
        attbStr.addAttribute(.font, value: defaultFont, range: range)
        attbStr.addAttribute(.foregroundColor, value: defaultColor, range: range)
        
        if let arrOfHasTags = YZLinkLableDetector.getElementsFrom(self, pattern: YZLinkLableDetector.hashTag.pattern, range: range) {
            for has in arrOfHasTags {
                attbStr.addAttribute(.font, value: hashTagFont, range: has.range)
                attbStr.addAttribute(.foregroundColor, value: hashColor, range: has.range)
            }
        }
        
        if let arrOfUserNames = YZLinkLableDetector.getElementsFrom(self, pattern: YZLinkLableDetector.mention.pattern, range: range) {
            for userName in arrOfUserNames {
                attbStr.addAttribute(.font, value: mentionFont, range: userName.range)
                attbStr.addAttribute(.foregroundColor, value: mentionColor, range: userName.range)
            }
        }
        
        if let arrOfUrls = YZLinkLableDetector.getElementsFrom(self, pattern: YZLinkLableDetector.url.pattern, range: range) {
            for url in arrOfUrls {
                attbStr.addAttribute(.font, value: defaultFont, range: url.range)
                attbStr.addAttribute(.foregroundColor, value: UIColor.blue, range: url.range)
            }
        }
        
        let para = NSMutableParagraphStyle()
        para.alignment = alignment
        attbStr.addAttributes([NSAttributedString.Key.paragraphStyle: para], range: range)
        return attbStr
    }
}
