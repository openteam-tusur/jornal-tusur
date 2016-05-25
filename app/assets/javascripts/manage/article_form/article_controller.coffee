angular.module('article_form').
  controller('ArticleController', [
    '$scope', 'Upload', '$http', '$window',
    ($scope,   Upload,   $http,   $window) ->

      $scope.article = { submitted: false }

      $scope.commit = ->

        return if $scope.article_form.$error.required
        return if $scope.article_form.article_file && $scope.article_form.article_file.$invalid

        $scope.article.submitted = true

        $scope.upload = Upload.upload
          url: $scope.article.url
          method: $scope.article.method
          headers: { 'Content-Type': 'application/json' }
          data: { article: $scope.article }
          file: $scope.article_file
          fileFormDataName: 'article[file]'
        .then (response) ->
          console.log 'success'
          console.log response
          $window.location = response.data.redirect_path
        , (response) ->
          console.log 'error'
        , (event) ->
          return unless event.config.data.article.file
          $scope.article.submit_proggress = parseInt(100.0 * event.loaded / event.total)
  ])
