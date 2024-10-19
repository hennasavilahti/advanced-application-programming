import { StyleSheet, Text, View, TextInput, Button } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <TextInput
        style={styles.textInput}
        placeholder="Check the weather at..."
      ></TextInput>
      <Text style={styles.weatherText}>28°C</Text>
      <Button title="Get weather"></Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#d6eaf8',
    alignItems: 'center',
    justifyContent: 'center',
  },
  textInput: {
    backgroundColor: '#f8f8f8',
    padding: 10,
    fontSize: 18,
    borderRadius: 10,
  },
  weatherText: {
    fontSize: 60,
    paddingTop: 30,
    paddingBottom: 30,
    fontWeight: 'bold',
  },
});
