angular.module('myApp.resources', []).
service('PersonService', function($resource, ABS_URL) {
    return $resource(ABS_URL + '/Persons.json', {}, {
        query: { method: 'GET', params: {}, isArray: true }
    });
});