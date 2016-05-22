/* global $ */

;(function ($) {
  'use strict'

  var DEFAULTS = {
    warning: {
      match: /\w+:\B/g,
      css: {
        'background-color': '#ffebaa',
        'border': '1px solid #ffdcb2',
        'border-color': '#ffdcb2',
        'border-right': '1px',
        'border-top-left-radius': '5px',
        'border-bottom-left-radius': '5px'
      }
    },
    success: {
      match: /\w+:\w+/g,
      css: {
        'background-color': '#ccecdf',
        'border': '1px solid #8cd5b7',
        'border-radius': '5px'
      }
    }
  }

  $.fn.fully = function (params) {
    params = $.extend(DEFAULTS, params)
    this.overlay([params.warning, params.success])
  }
})($)
