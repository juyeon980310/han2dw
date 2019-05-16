var fs = require('fs');

try{
    var data = fs.readFileSync('./helloWorld.txt', 'utf-8');
    console.log(data);
}catch(error){
    console.error('Error:', error);
}// 동기식