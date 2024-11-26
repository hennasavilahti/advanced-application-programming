import React, { createContext, useState, useEffect } from 'react';

export const WeatherContext = createContext();

export const WeatherProvider = ({ children }) => {
  const [location, setLocation] = useState('Tampere');
  const [weatherData, setWeatherData] = useState(null);
  const [forecastData, setForecastData] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetchWeatherData = async (location) => {
    try {
      const apiKey = '{YOUR_API_KEY}';
      setLoading(true);

      // Fetch data for weather
      const weatherResponse = await fetch(
        `https://api.openweathermap.org/data/2.5/weather?q=${location}&units=metric&appid=${apiKey}`
      );
      const weatherData = await weatherResponse.json();
      if (weatherData.cod === 200) {
        setWeatherData(weatherData);
      } else {
        alert(weatherData.message);
      }

      // Fetch data for weather forecast
      const forecastResponse = await fetch(
        `https://api.openweathermap.org/data/2.5/forecast?q=${location}&units=metric&appid=${apiKey}`
      );
      const forecastData = await forecastResponse.json();
      if (forecastData.cod === '200') {
        setForecastData(forecastData.list);
      } else {
        alert(forecastData.message);
      }
    } catch (err) {
      alert('Error fetching data');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchWeatherData(location);
  }, []);

  return (
    <WeatherContext.Provider
      value={{
        location,
        setLocation,
        weatherData,
        forecastData,
        fetchWeatherData,
        loading,
      }}
    >
      {children}
    </WeatherContext.Provider>
  );
};

export default WeatherContext;
