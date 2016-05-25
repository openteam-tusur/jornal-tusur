angular.module('article_form').
  controller('ArticleController', [
    '$scope', '$http', '$window',
    ($scope,   $http,   $window) ->

      $scope.article = {}

      $scope.commitArticle = ->
        return if $scope.article_form.$error.required
        $http
          method: $scope.article.method
          url: $scope.article.url
          headers: { 'Content-Type': 'application/json' }
          data: { article: $scope.article }
        .success (response) ->
          console.log response
          $window.location = response.redirect_path
  ])
