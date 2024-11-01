import React, { useContext, useState } from 'react';
import { View, Text, Image, StyleSheet, ActivityIndicator } from 'react-native';
import { WeatherContext } from '../context/WeatherContext';
import weatherIcon from '../assets/weatherIcon.png';

const WeatherInfo = () => {
  const { weatherData, loading } = useContext(WeatherContext);

  if (loading) return <ActivityIndicator size="large" color="#87CEEB" />;

  return weatherData ? (
    <View style={styles.container}>
      <View style={styles.info}>
        <Text style={styles.text}>{weatherData.weather[0].description}</Text>
        <Text style={styles.text}>{Math.round(weatherData.main.temp)} °C</Text>
        <Text style={styles.text}>
          {Math.round(weatherData.wind.speed)} m/s
        </Text>
      </View>
      <Image
        source={{
          uri: `https://openweathermap.org/img/wn/${weatherData.weather[0].icon}@4x.png`,
        }}
        style={styles.icon}
      ></Image>
    </View>
  ) : (
    <Text style={styles.text}>No weather data available.</Text>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 20,
    backgroundColor: '#d6eaf8',
    borderRadius: 10,
    marginVertical: 10,
  },
  info: {
    alignItems: 'left',
  },
  text: {
    fontSize: 23,
    textTransform: 'capitalize',
  },
  icon: {
    width: 150,
    height: 150,
  },
});

export default WeatherInfo;
