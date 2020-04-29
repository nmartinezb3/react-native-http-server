# react-native-http-server

## Getting started

`$ npm install http-server-react-native --save`

### Mostly automatic installation

`$ react-native link http-server-react-native`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-http-server` and add `RNHttpServer.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNHttpServer.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

Not supported yet

## Usage

```javascript
import React, { Component } from 'react';
import { HttpServer, Router }  from 'http-server-react-native';

class Server extends Component {

  componentDidMount() {
     const router = new Router('/path');
     router
      .get(data => {
        return { status: 200, data: { some: 'data' } };
      })
      .post(data => {
        return { status: 200, data: { some: 'data'} };
      })
      .put(data => {
        return { status: 200, data: { some: 'data'} };
      })
      .patch(data => {
        return { status: 200, data: { some: 'data'} };
      })
      .delete(data => {
        return { status: 200, data: { some: 'data'} };
      })

      this.server = new HTTPServer({ port: 8080 });
      this.server.registerRouter(router);
      this.server
        .start()
        .then(url => console.log(`Server running on ${url}`)
        .catch(err => console.error(err));
    }

    componentWillUnmount() {
      this.server.stop()
    }

    ...
}
;
```
