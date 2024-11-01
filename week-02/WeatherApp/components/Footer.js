import React, { useContext, useState } from 'react';
import { View, Button, TextInput, StyleSheet } from 'react-native';
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
    <View style={styles.footer}>
      <TextInput
        placeholder="Etsi säätiedot"
        value={inputLocation}
        onChangeText={setInputLocation}
        style={styles.textInput}
      />
      <Button title="Hae säätiedot" onPress={() => handleLocationChange()} />
    </View>
  );
};

const styles = StyleSheet.create({
  footer: {
    backgroundColor: '#d6eaf8',
    borderRadius: 10,
    padding: 20,
  },
  textInput: {
    backgroundColor: 'white',
    fontSize: 20,
    textTransform: 'capitalize',
    borderRadius: 10,
    padding: 5,
    marginBottom: 10,
  },
});

export default Footer;
