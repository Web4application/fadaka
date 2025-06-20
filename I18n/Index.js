import en from "./en.json";
import fr from "./fr.json";
import es from "./es.json";

const messages = { en, fr, es };
const defaultLocale = "en";

/**
 * Get the appropriate language messages with fallback support
 * @param {string} locale - The selected locale
 * @returns {object} - The message object
 */
export const getMessages = (locale) => {
  if (messages[locale]) {
    return { ...messages[defaultLocale], ...messages[locale] };
  }
  return messages[defaultLocale];
};

export const supportedLocales = Object.keys(messages);
