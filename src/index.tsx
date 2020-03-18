import { NativeModules } from 'react-native';

type SumUpType = {
  makePayment(): Promise<void>;
};

const { SumUp } = NativeModules;

export default SumUp as SumUpType;
