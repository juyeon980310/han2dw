function sayHello(){
    console.log('Hello World');
}

//3초뒤 실행
//setTimeout(function() {
 //   sayHello();
//}, 3 * 1000);

setInterval(function(){
    sayHello();
}, 2* 1000);