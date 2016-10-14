var app = angular.module("locations", ['ui.bootstrap']);
app.controller('locationController', function ($scope, $http) {
    $scope.maxSize = 5; 
    $scope.itemPerPage = 20;
    $scope.reverse = false;    
   	$scope.TotalItems = 1;
   	$scope.currentPage = 1;
   	$scope.locations = [
   		{ Name:"Location1", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location2", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location3", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location4", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location5", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location6", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location7", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location8", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location9", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"},
   		{ Name:"Location10", City:"New York", State:"State", Longitute: "-74.005941", Latitute: "40.712784"}		
   	];
});
angular.bootstrap(document.getElementById("locations"), ['locations']);