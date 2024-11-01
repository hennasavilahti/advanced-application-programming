import React from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { WeatherProvider } from './context/WeatherContext';
import Header from './components/Header';
import WeatherInfo from './components/WeatherInfo';
import Footer from './components/Footer';

export default function App() {
  return (
    <WeatherProvider>
      <SafeAreaView style={[styles.container, { flexDirection: 'column' }]}>
        <Header style={{ flex: 1 }} />
        <WeatherInfo style={{ flex: 3 }} />
        <Footer style={{ flex: 1 }} />
      </SafeAreaView>
    </WeatherProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    justifyContent: 'center',
  },
});
