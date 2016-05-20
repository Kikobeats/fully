'use strict'

gulp        = require 'gulp'
sass        = require 'gulp-sass'
gutil       = require 'gulp-util'
concat      = require 'gulp-concat'
header      = require 'gulp-header'
uglify      = require 'gulp-uglify'
cssmin      = require 'gulp-cssmin'
shorthand   = require 'gulp-shorthand'
pkg         = require './package.json'
prefix      = require 'gulp-autoprefixer'
strip       = require 'gulp-strip-css-comments'
browserSync = require 'browser-sync'
reload      = browserSync.reload

PORT =
  BROWSERSYNC: 3000

dist =
  name     : pkg.name
  folder   : 'dist'

src =
  sass:
    main   : 'dist/vendor/searchbox/searchbox.scss'
    files  : ['dist/vendor/searchbox/**/**']
  js       : 'src/fully.js'
  css      : 'src/fully.css'

banner = [ "/**"
           " * <%= pkg.name %> - <%= pkg.description %>"
           " * @version <%= pkg.version %>"
           " * @link    <%= pkg.homepage %>"
           " * @author  <%= pkg.author.name %> (<%= pkg.author.url %>)"
           " * @license <%= pkg.license %>"
           " */"
           "" ].join("\n")

gulp.task 'sass', ->
  gulp.src src.sass.main
  .pipe sass().on 'error', gutil.log
  .pipe concat 'searchbox.css'
  .pipe prefix()
  .pipe strip
    all: true
  .pipe shorthand()
  .pipe cssmin()
  .pipe header banner, pkg: pkg
  .pipe gulp.dest 'dist/vendor/searchbox'

gulp.task 'css', ->
  gulp.src src.css
  .pipe concat '' + dist.name + '.css'
  .pipe prefix()
  .pipe strip all: true
  .pipe shorthand()
  .pipe cssmin()
  .pipe header banner, pkg: pkg
  .pipe gulp.dest dist.folder
  return

gulp.task 'js', ->
  gulp.src src.js
  .pipe concat '' + dist.name + '.js'
  .pipe uglify()
  .pipe header banner, pkg: pkg
  .pipe gulp.dest dist.folder
  return

gulp.task 'server', ->
  browserSync.init
    server: baseDir: "./"
    files: ["#{dist.folder}/**"]
    reloadDelay: 300
    port: PORT.BROWSERSYNC
  return

gulp.task 'build', ['css', 'js']
gulp.task 'build-vendor', ['sass']

gulp.task 'default', ->
  gulp.start ['build-vendor', 'build',  'server']
  gulp.watch src.sass.files, ['sass']
  gulp.watch src.js, ['js']
  gulp.watch src.css, ['css']
