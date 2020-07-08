//
//  HTTPServerManager.m
//  HTTPServer
//
//  Created by Nicolas Martinez on 4/28/20.
//

#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(WebServerManager, NSObject)
RCT_EXTERN_METHOD(initWebServer)
RCT_EXTERN_METHOD(startServer: (NSInteger *) port
                  resolver: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(createServer: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(stopServer)
RCT_EXTERN_METHOD(subscribe: (NSString *) method)
RCT_EXTERN_METHOD(response: (NSString *) requestId  status: (NSInteger *) status responseData: (NSString *)data)
@end
