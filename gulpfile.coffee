gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
coffeeify = require 'coffeeify'
clean = require 'gulp-clean'

gulp.task 'clean-scripts', (done) ->
  gulp
    .src 'dist/app.js', read: false
    .on 'error', done
    .pipe clean()

gulp.task 'scripts', ['clean-scripts'], (done) ->
  bundle = browserify
    entries: ['./src/index.coffee']
    extensions: ['.coffee']
    debug: (process.env.NODE_ENV isnt 'production')

  bundle = bundle
    .transform coffeeify
    .bundle()
    .on 'error', done
    .pipe (source 'app.js')
    .pipe (gulp.dest 'dist')

gulp.task 'watch', ['default'], ->
  gulp.watch 'src/**/*.coffee', ['scripts']

gulp.task 'default', ['scripts']
