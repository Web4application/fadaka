import axios from "axios";
import config from "../config";

export const fetchTransactionAnalytics = async (transactionId) => {
  try {
    const response = await axios.get(`${config.rodaaiApiUrl}/analytics/transaction/${transactionId}`);
    return response.data;
  } catch (error) {
    console.error("Error fetching transaction analytics:", error);
    return null;
  }
};
