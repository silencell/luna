gulp= require 'gulp'
runSequence = require('run-sequence')
clean = require 'gulp-clean'
config= require './config'

gulp.task 'default', (done)->
    runSequence('clean', 'init', done)

einTask= ['browser-sync', 'watch']
einTask.push 'page', 'style', 'script', 'images', 'font'
gulp.task 'init', einTask

ignorefile=
    html: "!#{config.DestPath}/*.html"
    js: "!#{config.DestPath}/js/*.js"
    css: "!#{config.DestPath}/css/*.css"
    txt: "!#{config.DestPath}/README.md"
    zip: "!#{config.DestPath}/publish.zip"
gulp.task 'clean', ->
    options=
        force: true
    gulp.src(["#{config.DestPath}/*", ignorefile.txt], read: false)
        .pipe(clean(options))