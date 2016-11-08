// Define global variables
AUTH_COOKIE_NAME = "TOWNSQUARE_ACCESS_TOKEN";
USERNAME_LOGIN_COOKIE = "USERNAME_LOGIN";
//SERVICE_BASE_URL = "http://localhost:9002/api/1.0";
SERVICE_BASE_URL = "https://townsquare-dev.herokuapp.com/api/1.0";
SERVER_ERROR_MSG = "Server is error. Please contact site administrator for support.";
SESSION_EXPIRE_MSG = "Your session is expired. Please login and try again.";
//paging
ITEM_PER_PAGE = 50;
PAGE_MAX_SIZE = 5;

function showErrorDialog(ngDialog, message) {
	ngDialog.open({
        template: 'alert-error',
        data: '{"message":"' + message + '"}'
    });
}

function showInfoDialog(ngDialog, message) {
	ngDialog.open({
        template: 'alert-ok',
        data: '{"message":"' + message + '"}'
	});
}

/// How to use:
/// var tech = getUrlParameter('technology');
/// var blog = getUrlParameter('blog');
function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
    
    return "";
};

function logout() {
	$.removeCookie(AUTH_COOKIE_NAME, { path: '/' }); 
	$.removeCookie(USERNAME_LOGIN_COOKIE, { path: '/' }); 
	gotoLoginPage();  		
};

function gotoLoginPage(){
	var return_url = location.pathname;
	if (location.seach != "" && location.search != null){
		return_url += location.search;
	}
	
	// Redirect to login page
	window.location.href = "/account/login.html?return_url=" + encodeURIComponent(return_url);
}

function gotoPage(pageName) {
	window.location.href = "/"+ pageName + ".html";
}

function processCommonExeption(errorCode, ngDialog){	
	if (errorCode.indexOf("SYSTEM_ERROR") === 0) {
		showErrorDialog(ngDialog, SERVER_ERROR_MSG);        
    } else if (errorCode == "INVALID_SESSION"){
    	alert(SESSION_EXPIRE_MSG);
    	$.removeCookie(AUTH_COOKIE_NAME, { path: '/' }); 
		$.removeCookie(USERNAME_LOGIN_COOKIE, { path: '/' }); 
        gotoLoginPage();
    } else {
    	showErrorDialog(ngDialog, SERVER_ERROR_MSG);    
    }
}

// Check for authentication cookie
var cookie = $.cookie(AUTH_COOKIE_NAME);
var host = window.location.host;
var current_url = window.location.href;

if (cookie == null){
	if (!current_url.endsWith(host + "/account/login.html") &&	current_url.indexOf(host + "/account/login.html?") == -1) {	  
	  	gotoLoginPage();
	}	
} else {	
	if(current_url.indexOf("/account/login.html") > 0) {
		window.location.href = "/";
	}
}