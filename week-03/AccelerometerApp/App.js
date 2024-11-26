import { useState, useEffect } from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { Accelerometer } from 'expo-sensors';
import { StatusBar } from 'expo-status-bar';

export default function App() {
  const [{ x, y, z }, setData] = useState({
    x: 0,
    y: 0,
    z: 0,
  });

  const [subscription, setSubscription] = useState(null);

  const _slow = () => Accelerometer.setUpdateInterval(1000);
  const _fast = () => Accelerometer.setUpdateInterval(16);

  const _subscribe = () => {
    setSubscription(Accelerometer.addListener(setData));
  };

  const _unsubscribe = () => {
    subscription && subscription.remove();
    setSubscription(null);
  };

  useEffect(() => {
    _subscribe();
    return () => _unsubscribe();
  }, []);

  // Normalize x and y values to a range of 0 to 1
  const normalizedX = Math.min(Math.abs(x / 1), 1); // Assume max tilt is 1g
  const normalizedY = Math.min(Math.abs(y / 1), 1); // Assume max tilt is 1g
  const normalizedZ = Math.min(Math.abs(z / 1), 1); // Assume max tilt is 1g

  const getStaticBackgroundColor = (normalizedX, normalizedY, normalizedZ) => {
    if (
      (normalizedX < 0.2 && normalizedY < 0.2) ||
      (normalizedY < 0.2 && normalizedZ < 0.2)
    ) {
      return 'lime'; // Close to flat
    } else if (
      (normalizedY < 0.5 && normalizedZ < 0.5) ||
      (normalizedY < 0.5 && normalizedX < 0.5)
    ) {
      return 'yellow'; // Moderate tilt
    } else {
      return 'red'; // High tilt
    }
  };

  const backgroundColor = getStaticBackgroundColor(
    normalizedX,
    normalizedY,
    normalizedZ
  );

  return (
    <View style={[styles.container, { backgroundColor }]}>
      <Text style={styles.text}>
        Accelerometer: (in gs where 1g = 9.81 m/s^2)
      </Text>
      <Text style={styles.degree}>x: {x.toFixed(2)}</Text>
      <Text style={styles.degree}>y: {y.toFixed(2)}</Text>
      <Text style={styles.degree}>z: {z.toFixed(2)}</Text>
      <Text style={styles.text}>Current Color: {backgroundColor}</Text>
      <View style={styles.buttonContainer}>
        <TouchableOpacity
          onPress={subscription ? _unsubscribe : _subscribe}
          style={styles.button}
        >
          <Text>{subscription ? 'On' : 'Off'}</Text>
        </TouchableOpacity>
        <TouchableOpacity
          onPress={_slow}
          style={[styles.button, styles.middleButton]}
        >
          <Text>Slow</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={_fast} style={styles.button}>
          <Text>Fast</Text>
        </TouchableOpacity>
      </View>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    paddingHorizontal: 20,
  },
  text: {
    textAlign: 'center',
  },
  degree: {
    textAlign: 'center',
    fontSize: 25,
    fontWeight: 'bold',
  },
  buttonContainer: {
    flexDirection: 'row',
    alignItems: 'stretch',
    marginTop: 15,
  },
  button: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#eee',
    padding: 10,
  },
  middleButton: {
    borderLeftWidth: 1,
    borderRightWidth: 1,
    borderColor: '#ccc',
  },
});
