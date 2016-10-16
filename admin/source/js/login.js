var app = angular.module("login", ['ui.bootstrap']);
app.controller('loginController', function ($scope, $http) {
    $scope.user_name = "";
    $scope.password = "";
    $("#user_name").focus();
   	$scope.authenticate = function () {
        $scope.errorMessage = "";
        if ($scope.user_name == "" || $scope.password == "") {
            $scope.errorMessage = "Please input the user name or password.";
            return;
        }

        showLoadingImage("div.login-container");
        $.ajax({
        	url: SERVICE_BASE_URL + '/login',
        	type: 'POST',
        	data: JSON.stringify({username: $scope.user_name, password: $scope.password}),
        	contentType: 'application/json',
        	success: function(result){
                hideLoading("div.login-container");
                if (result.Success) {
                	var return_url = getUrlParameter("return_url");
                    if (return_url != ""){
                    	window.location.herf = return_url;
                    }
                } else {
                	processCommonExeption(result.Data, $scope);
                    $("#user_name").focus();
                }
        	},
        	error: function(){
            	hideLoading("div.login-container");
            	$scope.errorMessage = SERVER_ERROR_MSG;
        	}
        });
    };
});