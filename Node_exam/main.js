const http = require('http');

//����� ��Ʈ ��ȣ(����)
const port = 8080;


function html_writer(request, response)
{
    //��� ����
    response.writeHead(200/*������ ����*/, {'Content-Type':'text/html'});

    //���� ����
    response.end('<h1>Hello World!!</h1>')
}

//���� ����
const server = http.createServer(html_writer);

function log_writer()
{   
    //�����߿� ��� ȣ��
    console.log('running');
}    
//���� ����
server.listen(port, log_writer);