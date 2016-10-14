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
        $http.get(SERVICE_BASE_URL + 'login')
            .success(function (result) {
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
            }
            .error(function(){
            	$scope.errorMessage = SERVER_ERROR_MSG;
            }));
    };
});