import React from 'react';
import { View, Text, FlatList, StyleSheet } from 'react-native';

const ForecastList = ({ forecastData }) => {
  const renderForecastItem = ({ item }) => {
    return (
      <View style={styles.itemContainer}>
        <Text style={styles.date}>
          {new Date(item.dt * 1000).toLocaleString()}
        </Text>
        <Text style={styles.temp}>Temp: {item.main.temp}°C</Text>
        <Text style={styles.description}>{item.weather[0].description}</Text>
      </View>
    );
  };

  return (
    <FlatList
      data={forecastData}
      keyExtractor={(item) => item.dt.toString()}
      renderItem={renderForecastItem}
    />
  );
};

const styles = StyleSheet.create({
  itemContainer: {
    padding: 15,
    marginVertical: 5,
    backgroundColor: 'white',
    borderRadius: 8,
  },
  date: {
    fontSize: 14,
    fontWeight: 'bold',
  },
  temp: {
    fontSize: 16,
    marginTop: 5,
  },
  description: {
    fontSize: 14,
    fontStyle: 'italic',
  },
});

export default ForecastList;
