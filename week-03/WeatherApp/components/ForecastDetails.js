import React, { useContext } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { WeatherContext } from '../context/WeatherContext';
import ForecastList from './ForecastList';

const ForecastDetails = () => {
  const { forecastData, location, loading } = useContext(WeatherContext);

  return (
    <View style={styles.container}>
      <Text style={styles.header}>Weather Forecast for {location}</Text>
      {loading ? (
        <Text>Loading forecast...</Text>
      ) : (
        <ForecastList forecastData={forecastData} />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  header: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
  },
});

export default ForecastDetails;
