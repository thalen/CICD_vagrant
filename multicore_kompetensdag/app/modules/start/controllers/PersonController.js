angular.module('myApp')
    .controller('PersonController', PersonController);

function PersonController(PersonService) {
    this.country = "";
    this.person = "";
    var that = this;
    PersonService.query().$promise.then(function (response) {
       that.allPersons = response;
       that.persons = [];
    });
}

PersonController.prototype.onChangeCountry = function() {
    var that = this;
    this.persons = _.filter(this.allPersons, function (person) {
       return that.country === person;
    });
    this.person = "";
};
