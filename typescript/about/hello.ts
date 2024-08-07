type User = {name: string; age: number};

function greet(user: User) {
  let message: string = 'Hello ' + user.name + ', you are ' + user.age + ' years old';
  const output_element = document.getElementById('output');
  output_element.innerText = message;
}

const user1: User = { name: 'Paul', age: 29 };
greet(user1)
