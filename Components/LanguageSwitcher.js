import React, { useContext } from "react";
import { IntlContext } from "../context/IntlContext";

const LanguageSwitcher = () => {
  const { locale, setLocale, supportedLocales } = useContext(IntlContext);

  return (
    <select value={locale} onChange={(e) => setLocale(e.target.value)}>
      {supportedLocales.map((lang) => (
        <option key={lang} value={lang}>
          {lang.toUpperCase()}
        </option>
      ))}
    </select>
  );
};

export default LanguageSwitcher;
