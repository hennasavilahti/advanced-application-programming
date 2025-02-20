import React from 'react';
import { createDrawerNavigator } from '@react-navigation/drawer';
import { BottomTabNavigator } from './BottomTabNavigator';

import DetailsPage from '../../screens/DetailsPage';

const Drawer = createDrawerNavigator();

const DrawerNavigator = () => {
  return (
    <Drawer.Navigator>
      <Drawer.Screen name="Home" component={BottomTabNavigator} />
      <Drawer.Screen name="Details" component={DetailsPage} />
    </Drawer.Navigator>
  );
};

export { DrawerNavigator };
