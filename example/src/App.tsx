import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import SumUp from 'react-native-sum-up';

export default function App() {
  React.useEffect(() => {
    // SumUp.makePayment().then(setDeviceName);
  }, []);

  return (
    <View style={styles.container}>
      <Text>React-Native-Sum-Up</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
