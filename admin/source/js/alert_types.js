var app = angular.module("alert_types", ['ui.bootstrap']);
app.controller('alertTypesController', function ($scope, $http) {
    $scope.maxSize = 5; 
    $scope.itemPerPage = 20;
    $scope.reverse = false;    
   	$scope.TotalItems = 1;
   	$scope.currentPage = 1;
   	$scope.alertTypes = [
   		{ Name:"Alert Type1", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type2", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type3", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type4", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type5", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type6", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type7", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type8", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type9", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Alert Type10", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"}		
   	];
   	
   	$(".nav li.tab_alert_types").addClass("active"); 
});
angular.bootstrap(document.getElementById("alert_types"), ['alert_types']);