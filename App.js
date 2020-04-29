import React, {useState} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  View,
  Text,
  StatusBar,
  TouchableOpacity,
} from 'react-native';

import {HTTPServer, Router} from './HTTPServer';

const App = () => {
  const [endpoint, setEndpint] = useState('');
  const [isServerRunning, setServerState] = useState(false);

  let server;
  const startServer = () => {
    server = new HTTPServer({port: 8080});
    const router = new Router('/coso');
    router
      .get((error, data) => {
        console.log('GET method');
        return {status: 200, data: {success: true, value: 'get'}};
      })
      .post((error, data) => {
        console.log('POST method');
        return {status: 200, data: {success: true, value: 'post'}};
      })
      .put((error, data) => {
        console.log('PUT method');
        return {status: 200, data: {success: true, value: 'put'}};
      });

    server.registerRouter(router);
    server
      .start()
      .then(() => {
        setServerState(true);
      })
      .catch(err => console.error(err));
  };

  const stopServer = () => {
    server.stop();
    setEndpint('');
    setServerState(false);
  };

  return (
    <>
      <StatusBar barStyle="light-content" />
      <SafeAreaView style={styles.safeView}>
        <View style={styles.infoBlock}>
          <Text style={styles.text}>
            Press button to turn {isServerRunning ? 'Off' : 'On'} server
          </Text>
        </View>
        <View style={styles.container}>
          <TouchableOpacity
            onPress={() => (isServerRunning ? stopServer() : startServer())}>
            <Text>{isServerRunning ? 'RUNNING' : 'STOPED'}</Text>
          </TouchableOpacity>
        </View>
        {isServerRunning ? (
          <View style={styles.container}>
            <Text style={{...styles.text, ...styles.urlEndpoint}}>
              Server is available at this Url : {endpoint}
            </Text>
          </View>
        ) : (
          <View style={styles.container} />
        )}
      </SafeAreaView>
    </>
  );
};

const styles = StyleSheet.create({
  safeView: {
    backgroundColor: '#282c34',
    height: '100%',
  },
  urlEndpoint: {
    paddingTop: 20,
  },
  text: {
    color: '#FFF',
    fontWeight: '900',
    fontSize: 20,
    textAlign: 'center',
  },
  infoBlock: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default App;
