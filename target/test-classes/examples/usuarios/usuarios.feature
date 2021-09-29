Feature: sample karate test script

  Background:
    * url 'https://reqres.in/api'

  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def primero = response.data[0]
    * print primero

    Given path 'users', primero.id
    When method get
    Then status 200
    And assert primero.id == '1'
    And match primero ==
              """
              {
                "last_name": "Bluth",
                "id": 1,
                "avatar": "https://reqres.in/img/faces/1-image.jpg",
                "first_name": "George",
                "email": "george.bluth@reqres.in"
              }
             """

  Scenario: create a new user
    * def user =
          """
          {
            "first_name": "Pepe",
            "last_name": "Table"
          }
         """
    Given url 'https://reqres.in/api/users'
    Given request user
    When method post
    Then status 201
    And match response ==
              """
              {
                "createdAt": '#notnull',
                "last_name": "Table",
                "id": '#notnull',
                "first_name": "Pepe"
              }
              """

    * print 'el resp es: ', response
  # * def id = response.id
  #  * print 'created id is: ', id

   # Given path id
   # When method get
   # Then status 200
   # And match response contains table