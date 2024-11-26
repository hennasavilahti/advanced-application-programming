import React from 'react';
import { SafeAreaView, Pressable, StyleSheet, Text } from 'react-native';
import ForecastDetails from '../components/ForecastDetails';

const DetailsPage = ({ navigation }) => {
  return (
    <SafeAreaView style={[styles.container, { flexDirection: 'column' }]}>
      <ForecastDetails style={{ flex: 1 }} />
      <Pressable style={styles.button} onPress={() => navigation.goBack()}>
        <Text style={styles.buttonText}>Back</Text>
      </Pressable>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    justifyContent: 'center',
    backgroundColor: '#d6eaf8',
  },
  button: {
    flex: 1,
    marginTop: 5,
    justifyContent: 'center',
    alignItems: 'center',
    marginHorizontal: 'auto',
    textAlign: 'center',
    paddingVertical: 10,
    paddingHorizontal: 25,
    elevation: 2,
    borderRadius: 6,
    backgroundColor: 'white',
    maxHeight: 45,
    width: 150,
  },
  buttonText: {
    fontSize: 16,
  },
});

export default DetailsPage;
