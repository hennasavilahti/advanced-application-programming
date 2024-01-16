import { useState } from 'react';
import { StyleSheet, TextInput, View, Button, Text, Image } from 'react-native';

const App = () => {
  const [city, setCity] = useState(undefined);
  const [error, setError] = useState(false);
  const [wind, setWind] = useState(undefined);
  const [iconURL, setIconURL] = useState(undefined);
  const [temperature, setTemperature] = useState(undefined);

  const fetchWeatherData = async (city) => {
    setError(false);

    try {
      const response = await fetch(
        `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=6018b2f91594758c9da952d55a649364&units=metric`
      );
      const weatherJSON = await response.json();
      setWeatherData(weatherJSON);
    } catch (error) {
      setError(true);
    }
  };

  const setWeatherData = (weatherJSON) => {
    setTemperature(Math.round(weatherJSON.main.temp));
    setIconURL(
      `http://openweathermap.org/img/wn/${weatherJSON.weather[0].icon}@4x.png`
    );
    setWind(Math.round(weatherJSON.wind.speed));
  };

  let content = <Text style={styles.wind}>No city found yet</Text>;

  if (temperature) {
    content = (
      <>
        <Text style={styles.temperature}>{temperature}°C</Text>
        <Image style={styles.image} source={{ uri: iconURL }}></Image>
        <Text style={styles.wind}>Wind speed: {wind}m/s</Text>
      </>
    );
  }

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        placeholder="Search for a city..."
        value={city}
        onChangeText={(value) => setCity(value)}
      ></TextInput>
      {content}
      <Button
        style={styles.button}
        title="Search"
        onPress={() => fetchWeatherData(city)}
      ></Button>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  input: {
    fontSize: 25,
    padding: 3,
    width: 300,
    marginBottom: 30,
    borderColor: 'grey',
    borderWidth: 1,
    textAlign: 'center',
    borderRadius: 10,
  },
  image: {
    width: 150,
    height: 150,
  },
  wind: {
    fontSize: 18,
    color: 'grey',
    marginBottom: 20,
  },
  temperature: {
    fontSize: 30,
    fontWeight: 'bold',
    marginBottom: 0,
  },
});

export default App;
