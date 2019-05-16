process.on('uncaughtException', function(code){
    console.log('uncaughtException');
});
// 에러처리
sayHello();

/* Tip
if (에러)
else 정상코드
*/