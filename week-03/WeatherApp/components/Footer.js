import React, { useContext, useState } from 'react';
import { View, Text, TextInput, StyleSheet, Pressable } from 'react-native';
import { WeatherContext } from '../context/WeatherContext';

const Footer = () => {
  const { setLocation, fetchWeatherData } = useContext(WeatherContext);
  const [inputLocation, setInputLocation] = useState('');

  const handleLocationChange = () => {
    if (inputLocation) {
      setLocation(inputLocation);
      fetchWeatherData(inputLocation);
    }
  };

  return (
    <View style={[styles.container, { flexDirection: 'row' }]}>
      <TextInput
        placeholder="Syötä kaupunki"
        value={inputLocation}
        onChangeText={setInputLocation}
        style={[styles.textInput, { flex: 3 }]}
      />
      <Pressable
        style={[styles.button, { flex: 1 }]}
        onPress={() => handleLocationChange()}
      >
        <Text style={styles.buttonText}>Hae</Text>
      </Pressable>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 10,
    justifyContent: 'center',
    alignItems: 'center',
  },
  textInput: {
    backgroundColor: 'white',
    fontSize: 18,
    textTransform: 'capitalize',
    borderRadius: 4,
    padding: 8,
    marginRight: 5,
    elevation: 2,
  },
  button: {
    justifyContent: 'center',
    alignItems: 'center',
    marginHorizontal: 'auto',
    textAlign: 'center',
    padding: 10,
    elevation: 2,
    borderRadius: 4,
    backgroundColor: 'white',
    maxHeight: 50,
    maxWidth: 50,
  },
  buttonText: {
    fontSize: 15,
  },
});

export default Footer;
