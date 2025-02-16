import React, { useState, useEffect } from 'react';
import {
  StyleSheet,
  ToastAndroid,
  Image,
  Button,
  Text,
  ActivityIndicator,
  SafeAreaView,
  Platform,
} from 'react-native';
import { Linking } from 'react-native';
import * as Location from 'expo-location';

const App = () => {
  const [cat, setCat] = useState([]);
  const [loading, setLoading] = useState(true);
  const [location, setLocation] = useState(null);
  const [errorMsg, setErrorMsg] = useState(null);

  const showToast = () => {
    ToastAndroid.show('New cat picture appeared!', ToastAndroid.SHORT);
  };

  useEffect(() => {
    (async () => {
      let { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== 'granted') {
        setErrorMsg('Permission to access location was denied');
        return;
      }

      let location = await Location.getCurrentPositionAsync({});
      setLocation(location);
    })();
    fetchCatPicture();
  }, []);

  const fetchCatPicture = async () => {
    setLoading(true);
    try {
      const apiKey =
        'live_9z5sZ9M4toxRhQXe7m63K2nlKg1G6y6CRHpVHRwx1X11i66WpTymkY5aeDBCZMR0';

      const response = await fetch(
        `https://api.thecatapi.com/v1/images/search?has_breeds=1&api_key=${apiKey}`
      );
      const data = await response.json();
      if (data[0].breeds) {
        setCat(data);
        showToast();
      } else {
        alert(data.message);
      }
    } catch (err) {
      alert('Error fetching data');
    } finally {
      setLoading(false);
    }
  };

  const openMaps = (location) => {
    if (location) {
      const lat = location.coords.latitude;
      const lon = location.coords.longitude;

      const url = Platform.select({
        android: `geo:${lat},${lon}`,
        ios: `maps:${lat},${lon}`,
      });
      Linking.openURL(url);
    } else {
      const url = Platform.select({
        android: 'geo:61.50,23.78',
        ios: 'maps:67,23',
      });
      Linking.openURL(url);
    }
  };

  const openWebPage = (breed) => {
    Linking.openURL(`https://www.google.com/search?q=${breed} cat`);
  };

  if (loading)
    return (
      <ActivityIndicator
        size="large"
        color="#87CEEB"
        style={styles.container}
      />
    );

  return cat[0].url ? (
    <SafeAreaView style={styles.container}>
      <Text style={styles.text}>{cat[0].breeds[0].name}</Text>
      <Image style={styles.image} source={{ uri: cat[0].url }} />
      <Button
        title={`Search information about ${cat[0].breeds[0].name}`}
        onPress={() => openWebPage(cat[0].breeds[0].name)}
      />
      {location ? (
        <Button
          title="Search your location for adoption centre"
          onPress={() => openMaps(location)}
        />
      ) : (
        <Button
          title="Search Tampere for adoption centre"
          onPress={() => openMaps()}
        />
      )}
      <Button title="Get new cat pic" onPress={() => fetchCatPicture()} />
    </SafeAreaView>
  ) : (
    <Text style={styles.text}>No cat available.</Text>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffdef9',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 5,
  },
  text: {
    fontSize: 40,
    fontWeight: 'bold',
    letterSpacing: 0.75,
  },
  image: {
    height: 300,
    width: 300,
    borderRadius: 10,
  },
});

export default App;
