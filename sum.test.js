// sum.test.js
const sum = require('./sum'); // Import the function from the code file

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3); // The 'test' and 'expect' functions are provided by Jest
});

test('adds 5 + 10 to equal 15', () => {
    expect(sum(5, 10)).toBe(15);
});
