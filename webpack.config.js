const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const { GenerateSW } = require("workbox-webpack-plugin");

module.exports = {
  entry: "./index.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.[contenthash].js",
    assetModuleFilename: "assets/[name][hash][ext]",
    clean: true,  // Clean output directory before each build
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: "babel-loader",
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.(png|jpg|jpeg|gif)$/i,
        type: "asset/resource",
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./index.html",
      title: "Fadaka Blockchain",
    }),
    new GenerateSW({
      clientsClaim: true,
      skipWaiting: true,
    }),
  ],
  optimization: {
    runtimeChunk: "single",
    splitChunks: {
      chunks: "all",
    },
  },
};
