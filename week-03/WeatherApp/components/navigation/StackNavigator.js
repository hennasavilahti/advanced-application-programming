import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';

import HomePage from '../../screens/HomePage';
import DetailsPage from '../../screens/DetailsPage';

const Stack = createStackNavigator();

const MainStackNavigator = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen name="Home" component={HomePage} />
      <Stack.Screen name="Details" component={DetailsPage} />
    </Stack.Navigator>
  );
};
export { MainStackNavigator };
