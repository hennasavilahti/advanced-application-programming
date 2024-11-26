import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import HomePage from '../../screens/HomePage';
import DetailsPage from '../../screens/DetailsPage';

const Tab = createBottomTabNavigator();

const BottomTabNavigator = () => {
  return (
    <Tab.Navigator screenOptions={{ headerShown: false }}>
      <Tab.Screen name="Home" component={HomePage} />
      <Tab.Screen name="Forecast" component={DetailsPage} />
    </Tab.Navigator>
  );
};

export { BottomTabNavigator };
