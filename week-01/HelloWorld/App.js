import { useState } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';

const App = () => {
  const [counter, setCounter] = useState(0);

  const increaseCounter = () => {
    setCounter(counter + 1);
  };

  return (
    <View style={styles.viewStyle}>
      <Text style={styles.myTextStyle}>Counter: {counter}</Text>
      <Button title={'Click me!'} onPress={increaseCounter}></Button>
    </View>
  );
};

const styles = StyleSheet.create({
  myTextStyle: {
    fontFamily: 'arial',
    fontSize: 30,
  },
  viewStyle: {
    alignItems: 'center',
  },
});

export default App;
