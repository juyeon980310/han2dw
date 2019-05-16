var util = require('util');

function parent(){
}

parent.prototype.sayHello = function(){
    console.log('Hello World, from Parent Class!');
}

var obj = new parent();
    obj.sayHello();

function Child(){
}

util.inherits(Child, parent);

var obj2 = new Child();
obj2.sayHello();