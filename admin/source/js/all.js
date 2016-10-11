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

SERVICE_URL = "http://localhost:9002";
SERVER_ERROR_MSG = "Server is error. Please contact site administrator for support.";