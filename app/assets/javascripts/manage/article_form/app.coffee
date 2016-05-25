angular.module('article_form', [])

$(document).on 'ready page:load', ->
  angular.bootstrap($('.js-article-form'), ['article_form']) if $('.js-article-form').length
