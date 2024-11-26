import React from 'react';
import { NavigationContainer } from '@react-navigation/native';

import { WeatherProvider } from './context/WeatherContext';
import { DrawerNavigator } from './components/navigation/DrawerNavigator';

const App = () => {
  return (
    <NavigationContainer>
      <WeatherProvider>
        <DrawerNavigator />
      </WeatherProvider>
    </NavigationContainer>
  );
};

export default App;
