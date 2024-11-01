import React, { createContext, useState, useEffect } from 'react';

export const WeatherContext = createContext();

const urlBase = 'https://api.openweathermap.org/data/2.5/weather?q=';
const apiKey = '&units=metric&appid={YOUR_API_KEY}';

export const WeatherProvider = ({ children }) => {
  const [location, setLocation] = useState('Tampere');
  const [weatherData, setWeatherData] = useState(null);
  const [loading, setLoading] = useState(false);

  const fetchWeatherData = async (loc = location) => {
    try {
      setLoading(true);
      const response = await fetch(urlBase + location + apiKey);
      const data = await response.json();
      if (data.cod === 200) {
        setWeatherData(data);
      } else {
        alert(data.message);
      }
    } catch (err) {
      alert('Error fetching data');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchWeatherData();
  }, []);

  return (
    <WeatherContext.Provider
      value={{ location, setLocation, weatherData, fetchWeatherData, loading }}
    >
      {children}
    </WeatherContext.Provider>
  );
};
