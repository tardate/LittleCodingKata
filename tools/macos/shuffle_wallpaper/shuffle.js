// Get reference to System Events
const systemEvents = Application('System Events');

// Get the current desktop
const currentDesktop = systemEvents.desktops[0];

// Get the current picture setting
console.log(`Current picture setting: ${currentDesktop.picture()}`);

// Get the change interval setting
const changeInterval = currentDesktop.changeInterval();
console.log(`Current change interval setting: ${changeInterval}`);

console.log('Reset the change interval')
currentDesktop.changeInterval = changeInterval;

console.log(`Current picture setting: ${currentDesktop.picture()}`);
console.log(`Current change interval setting: ${currentDesktop.changeInterval()}`);
