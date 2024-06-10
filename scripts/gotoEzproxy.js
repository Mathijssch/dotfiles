let ezproxy = "http://kuleuven.ezproxy.kuleuven.be/login?url="; 
if (!startsWith(window.location.href, ezproxy)){
    window.location.href =  concat(ezproxy, window.location.href); 
}