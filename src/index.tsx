import { NativeModules } from 'react-native';

type SumUpType = {
  getDeviceName(): Promise<string>;
};

const { SumUp } = NativeModules;

export default SumUp as SumUpType;
