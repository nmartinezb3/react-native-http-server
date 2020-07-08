//
//  HttpServer.swift
//  RNHttpServer
//
//  Created by Nicolas Martinez on 4/29/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


@objc(WebServerManager)
class WebServerManager: RCTEventEmitter {
  private enum ServerState {
    case Stopped
    case Running
  }
  
  private let webServer: GCDWebServer = GCDWebServer()
  private var serverRunning : ServerState =  ServerState.Stopped
  private var completionBlocks: NSMutableDictionary = NSMutableDictionary() ;

  override init(){
    super.init()
  }

//  @objc static override func requiresMainQueueSetup() -> Bool {
//    return true
//  }
  
  override func supportedEvents() -> [String]! {
    return ["GET", "POST", "PUT", "PATCH", "DELETE"]
  }
  
  /**
   Creates an NSError with a given message.

  - Parameter message: The error message.

  - Returns: An error including a domain, error code, and error      message.
   */
   private func createError(message: String)-> NSError{
     let error = NSError(domain: "app.domain", code: 0,userInfo: [NSLocalizedDescriptionKey: message])
     return error
   }
  
  
  @objc public func response(_ requestId: String, status: NSInteger, responseData data: String) {
    let completion: GCDWebServerCompletionBlock = completionBlocks.value(forKey: requestId) as! GCDWebServerCompletionBlock
    let response = GCDWebServerDataResponse(data: Data(data.data(using: .utf8)!), contentType: "application/json")
    completion(response)
  }
  
 
  @objc public func subscribe(_ method: String) {
    webServer.addDefaultHandler(forMethod: method, request: GCDWebServerRequest.self) { (request, completionBlock) in
      let requestId = NSString(string: UUID().uuidString)
      self.completionBlocks.setObject(completionBlock, forKey: requestId)
      self.sendEvent(withName: method, body: requestId)
    }
  }
  
  /**
   Start `webserver` on the Main Thread
  - Returns:`Promise` to JS side, resolve the server URL and reject thrown errors
   */
  @objc public func startServer(_ port: NSInteger, resolver resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
     if (serverRunning == ServerState.Stopped){
       DispatchQueue.main.sync {
           serverRunning = ServerState.Running
           webServer.start(withPort: UInt(port), bonjourName: "React Native Web Server")
           resolve(webServer.serverURL?.absoluteString)
       }
     } else {
       let errorMessage : String = "Server start failed"
       reject("0", errorMessage, createError(message:errorMessage))
     }
   }
  
  /**
  Stop `webserver` and update serverRunning variable to Stopped case
  */
  @objc public func stopServer() -> Void {
    if(serverRunning == ServerState.Running){
      webServer.stop()
      serverRunning = ServerState.Stopped
    }
  }

}
