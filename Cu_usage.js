import axios from "axios";
import fs from "fs";

const API_KEY = "YOUR_API_KEY";  // replace with your real NodeReal API key

// Example: last 7 days in UNIX milliseconds
const endTime = Date.now();
const startTime = endTime - 7 * 24 * 60 * 60 * 1000;

const url = `https://portal-api.nodereal.io/v1/${API_KEY}/cu-consumption`;

async function main() {
  try {
    // Fetch usage data
    const res = await axios.get(url, {
      params: { startTime, endTime },
      headers: { accept: "application/json" }
    });

    const data = res.data.data;
    console.log("Total CU used:", data.totalCU);

    if (!data.breakdown || data.breakdown.length === 0) {
      console.log("No breakdown data available.");
      return;
    }

    // Extract values
    const labels = data.breakdown.map(d => d.date);
    const values = data.breakdown.map(d => d.cu);

    // Build chart config (Chart.js syntax)
    const chartConfig = {
      type: "line",
      data: {
        labels: labels,
        datasets: [{
          label: "CU Consumption (Last 7 Days)",
          data: values,
          fill: false,
          borderColor: "blue",
          tension: 0.1
        }]
      }
    };

    // Call QuickChart API to render the chart
    const chartUrl = "https://quickchart.io/chart";
    const chartRes = await axios.post(chartUrl, { chart: chartConfig }, { responseType: "arraybuffer" });

    // Save chart as PNG
    fs.writeFileSync("cu_usage.png", chartRes.data);
    console.log("Chart saved as cu_usage.png");
  } catch (err) {
    console.error("Error:", err.response?.status, err.response?.data || err.message);
  }
}

main();
