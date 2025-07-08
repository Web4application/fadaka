import React, { useContext } from "react";
import { IntlProvider } from "react-intl";
import { IntlContext, IntlProvider as CustomIntlProvider } from "./context/IntlContext";
import Header from "./components/Header";
import Wallet from "./components/Wallet";
import Transaction from "./components/Transaction";
import LanguageSwitcher from "./components/LanguageSwitcher";
import "./assets/styles.css";
import logo from "./assets/logo.png";

const AppContent = () => {
  const { locale, messages } = useContext(IntlContext);

  return (
    <IntlProvider locale={locale} messages={messages}>
      <div className="App">
        <header className="header">
          <img src={logo} className="logo" alt="Fadaka Logo" />
          <LanguageSwitcher />
          <Header balance={5000} />
        </header>

        <main>
          <Wallet address="0x123ABC" balance={1500} />
          <Transaction sender="0x123ABC" receiver="0x456DEF" amount={300} />
        </main>
      </div>
    </IntlProvider>
  );
};

const App = () => {
  return (
    <CustomIntlProvider>
      <AppContent />
    </CustomIntlProvider>
  );
};

export default App;
