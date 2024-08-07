function greet(user) {
    var message = 'Hello ' + user.name + ', you are ' + user.age + ' years old';
    var output_element = document.getElementById('output');
    output_element.innerText = message;
}
var user1 = { name: 'Paul', age: 29 };
greet(user1);
