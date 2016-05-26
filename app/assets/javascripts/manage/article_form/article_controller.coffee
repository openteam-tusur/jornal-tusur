angular.module('article_form').
  controller('ArticleController', [
    '$scope', 'Upload', '$http', '$window',
    ($scope,   Upload,   $http,   $window) ->

      $scope.article = { submitted: false }

      $scope.commit = ->

        return if $scope.article_form.$error.required
        return if $scope.article_form.article_file && $scope.article_form.article_file.$invalid

        if $scope.article_form.article_page_from.$viewValue >= $scope.article_form.article_page_to.$viewValue
          $scope.article_form.$error.page_from_larger_page_to = true
          return
        else
          $scope.article_form.$error.page_from_larger_page_to = false

        $scope.article.submitted = true

        if $scope.article.section
          $scope.article.section_id = $scope.article.section.id
        else
          $scope.article.section_id = ''

        delete($scope.article['section'])

        $scope.upload = Upload.upload
          url: $scope.url
          method: $scope.method
          headers: { 'Content-Type': 'application/json' }
          data: { article: $scope.article }
          file: $scope.article_file
          fileFormDataName: 'article[file]'
        .then (response) ->
          $window.location = response.data.redirect_path
        , (response) ->
          console.log 'error'
        , (event) ->
          return unless event.config.data.article.file
          $scope.article.submit_proggress = parseInt(100.0 * event.loaded / event.total)
  ])
