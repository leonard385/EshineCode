//
//  ViewController.swift
//  JavaScriptAndSwift
//
//  Created by huangyibiao on 15/10/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit
import JavaScriptCore

// All methods that should apply in Javascript, should be in the following protocol.
@objc protocol JavaScriptSwiftDelegate: JSExport {
  func callSystemCamera();
  
  func showAlert(title: String, msg: String);
  
  func callWithDict(dict: [String: AnyObject])
  
  func jsCallObjcAndObjcCallJsWithDict(dict: [String: AnyObject]);
}

@objc class JSObjCModel: NSObject, JavaScriptSwiftDelegate {
  weak var controller: UIViewController?
  weak var jsContext: JSContext?
  
  func callSystemCamera() {
    print("js call objc method: callSystemCamera");
    
    let jsFunc = self.jsContext?.objectForKeyedSubscript("jsFunc");
    jsFunc?.callWithArguments([]);
  }
  
  func showAlert(title: String, msg: String) {
    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
      self.controller?.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  // JS调用了我们的方法
  func callWithDict(dict: [String : AnyObject]) {
    print("js call objc method: callWithDict, args: %@", dict)
  }
  
  // JS调用了我们的就去
  func jsCallObjcAndObjcCallJsWithDict(dict: [String : AnyObject]) {
     print("js call objc method: jsCallObjcAndObjcCallJsWithDict, args: %@", dict)
    
    let jsParamFunc = self.jsContext?.objectForKeyedSubscript("jsParamFunc");
    let dict = NSDictionary(dictionary: ["age": 18, "height": 168, "name": "lili"])
    jsParamFunc?.callWithArguments([dict])
  }
}

class ViewController: UIViewController, UIWebViewDelegate {
  var webView: UIWebView!
  var jsContext: JSContext?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.webView = UIWebView(frame: self.view.bounds);
    self.view.addSubview(self.webView)
    self.webView.delegate = self
    self.webView.scalesPageToFit = true;
    let url = NSBundle.mainBundle().URLForResource("test", withExtension: "html")
    let request = NSURLRequest(URL: url!)
    self.webView.loadRequest(request)
    
    // 我们可以不通过模型来调用方法，也可以直接调用方法
    let context = JSContext()
    context.evaluateScript("var num = 10")
    context.evaluateScript("function square(value) { return value * 2}")
    // 直接调用
    let squareValue = context.evaluateScript("square(num)")
    print(squareValue)
    
    // 通过下标来获取到JS方法。
    let squareFunc = context.objectForKeyedSubscript("square")
    print(squareFunc.callWithArguments(["10"]).toString());
  }
  
  // MARK: - UIWebViewDelegate
  func webViewDidFinishLoad(webView: UIWebView) {
    let context = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext
    let model = JSObjCModel()
    model.controller = self
    model.jsContext = context
    self.jsContext = context
    
    // 这一步是将OCModel这个模型注入到JS中，在JS就可以通过OCModel调用我们公暴露的方法了。
   self.jsContext?.setObject(model, forKeyedSubscript: "OCModel")
    let url = NSBundle.mainBundle().URLForResource("test", withExtension: "html")
    self.jsContext?.evaluateScript(try? String(contentsOfURL: url!, encoding: NSUTF8StringEncoding));
    
    self.jsContext?.exceptionHandler = {
      (context, exception) in
         print("exception @", exception)
    }
  }
  
}

