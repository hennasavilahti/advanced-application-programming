import React, { useContext } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WeatherContext } from '../context/WeatherContext';

const Header = () => {
  const { location } = useContext(WeatherContext);
  return (
    <View style={styles.header}>
      <Text style={styles.text}>{location}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  text: {
    fontSize: 45,
    color: 'black',
    textAlign: 'center',
    textTransform: 'capitalize',
    fontWeight: 'bold',
    letterSpacing: 1,
  },
  header: {
    backgroundColor: '#d6eaf8',
    borderRadius: 10,
    padding: 5,
  },
});

export default Header;
