import axios from "axios";
import config from "../config";

export const getWalletNotifications = async (walletAddress) => {
  try {
    const response = await axios.get(`${config.lolaApiUrl}/notifications/wallet/${walletAddress}`);
    return response.data;
  } catch (error) {
    console.error("Error fetching wallet notifications:", error);
    return [];
  }
};
