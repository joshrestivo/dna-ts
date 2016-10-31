
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
};

function logout() {
    $.ajax({
		url: SERVICE_BASE_URL + '/logout',
		xhrFields: {
	      withCredentials: true
	  	},
		type: 'GET',				  
		success: function(result){
			deleteCookie("USERNAME_LOGIN");
			gotoLoginPage();
  		},
  		error: function (request, status, error) {
        	alert(error);
    	}
	});
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
    	deleteCookie("USERNAME_LOGIN");
        gotoLoginPage();
    } else {
    	showErrorDialog(ngDialog, SERVER_ERROR_MSG);    
    }
}

function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function deleteCookie(name) {
    createCookie(name,"",-1);
}

// Check for authentication cookie
var cookie = readCookie('TOWNSQUARE_ADMIN');
console.log(cookie);
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

// Define global variables
//SERVICE_BASE_URL = "http://localhost:9002/api/1.0/admin";
SERVICE_BASE_URL = "https://townsquare-dev.herokuapp.com/api/1.0/admin";
SERVER_ERROR_MSG = "Server is error. Please contact site administrator for support.";
SESSION_EXPIRE_MSG = "Your session is expired. Please login and try again.";
