function checkSessionTimeout(url) {
 $.getScript(url);
}
function setSessionTimeout(url, seconds) {
 setTimeout("checkSessionTimeout(\'" + url + "\')", seconds*1000 + 15);
}
