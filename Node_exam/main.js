const http = require('http');

//사용할 포트 번호(임의)
const port = 8080;


function html_writer(request, response)
{
    //헤더 써줌
    response.writeHead(200/*성공을 뜻함*/, {'Content-Type':'text/html'});

    //본문 써줌
    response.end('<h1>Hello World!!</h1>')
}

//서버 생성
const server = http.createServer(html_writer);

function log_writer()
{   
    //실행중에 계속 호출
    console.log('running');
}    
//서버 실행
server.listen(port, log_writer);