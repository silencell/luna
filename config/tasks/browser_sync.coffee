gulp= require 'gulp'
browserSync= require('browser-sync')
reload= browserSync.reload
config= require './config'

# BrowserSync task for starting the server.
gulp.task 'browser-sync', ->
    option=
        server: { baseDir: config.DestPath }
    browserSync.init option