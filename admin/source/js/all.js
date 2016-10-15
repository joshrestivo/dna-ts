function showLoading(selector, message, width, left) {
    $(selector).block({
        message: message,
        css: {
            padding: 10,
            backgroundColor: "#fff",
            border: "solid 1px #ddd",
            width: width + '',
            left: left + ''
        }
    });
}

function showLoadingImage(selector) {
    showLoading(selector, "<img src='images/loading.gif' />", "56px");
}

function hideLoading(selector) {
    $(selector).unblock();
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

function gotoLoginPage(){
	var return_url = location.pathname;
	if (location.seach != "" && location.search != null){
		return_url += location.search;
	}
	
	// Redirect to login page
	window.location.href = "/index.html?return_url=" + encodeURIComponent(return_url);
}

function processCommonExeption(errorCode, $scope){
	if (errorCode.indexOf("SYSTEM_ERROR") === 0) {
        $scope.errorMessage = SERVER_ERROR_MSG;
    } else if (errorCode == "INVALID_SESSION"){
    	alert(SESSION_EXPIRE_MSG);
        gotoLoginPage();
    }
}

// Check for authentication cookie
var cookie = Cookies.get('TOWNSQUARE_ADMIN');
var host = window.location.host;
var current_url = window.location.href;
if (cookie == null && 
	!current_url.endsWith(host) && 
	!current_url.endsWith(host + "/index.html") &&
	current_url.indexOf(host + "?") == -1 &&
	current_url.indexOf(host + "/index.html?") == -1){
	gotoLoginPage();
}

// Define global variables
SERVICE_BASE_URL = "http://localhost:9002/api/1.0/admin";
SERVER_ERROR_MSG = "Server is error. Please contact site administrator for support.";
SESSION_EXPIRE_MSG = "Your session is expired. Please login and try again.";
