import {NativeModules, NativeEventEmitter} from 'react-native';
const {WebServerManager} = NativeModules;

export const HTTPMethods = {
  GET: 'GET',
  PUT: 'PUT',
  POST: 'POST',
  PATCH: 'PATCH',
  DELETE: 'DELETE',
};

export class Router {
  constructor(path) {
    this._path = path;
    this._handlers = {};
  }

  post(handler) {
    this._handlers.post = handler;
    return this;
  }
  put(handler) {
    this._handlers.put = handler;
    return this;
  }
  patch(handler) {
    this._handlers.patch = handler;
    return this;
  }
  get(handler) {
    this._handlers.get = handler;
    return this;
  }
  delete(handler) {
    this._handlers.delete = handler;
    return this;
  }

  getHandlers() {
    return this._handlers;
  }
  getPath() {
    return this._handlers;
  }
}

export class HTTPServer {
  constructor({port}) {
    this.port = port;
    this.eventEmitter = new NativeEventEmitter(WebServerManager);
  }

  start() {
    return WebServerManager.startServer();
  }

  stop() {
    return WebServerManager.stopServer();
  }

  registerRouter(router) {
    Object.entries(router.getHandlers()).forEach(([method, handler]) => {
      const eventName = method.toUpperCase();
      WebServerManager.subscribe(eventName);
      this.subscription = this.eventEmitter.addListener(
        eventName,
        requestId => {
          const {data, status} = handler('', data);
          console.log(requestId);
          WebServerManager.response(requestId, status, JSON.stringify(data));
        },
      );
    });
  }

  registerHandler(callback) {
    WebServerManager.registerHandler('POST', (error, requestId) => {
      const {data, status} = callback(error);
      WebServerManager.response(requestId, status, JSON.stringify(data));
    });
  }
}
