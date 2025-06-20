import React, { createContext, useState } from "react";
import { getMessages, supportedLocales } from "../i18n";

export const IntlContext = createContext();

export const IntlProvider = ({ children }) => {
  const browserLocale = navigator.language.slice(0, 2);
  const defaultLocale = supportedLocales.includes(browserLocale) ? browserLocale : "en";

  const [locale, setLocale] = useState(defaultLocale);
  const messages = getMessages(locale);

  return (
    <IntlContext.Provider value={{ locale, setLocale, messages, supportedLocales }}>
      {children}
    </IntlContext.Provider>
  );
};
