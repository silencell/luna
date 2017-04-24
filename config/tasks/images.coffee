gulp= require('gulp')
plumber = require 'gulp-plumber'
notify= require('gulp-notify')
browserSync= require('browser-sync')
reload= browserSync.reload
config   = require('./config')
imagemin= require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
jpegtran= require 'imagemin-jpegtran'
gifsicle= require 'imagemin-gifsicle'
cache= require 'gulp-cache'
runSequence = require('run-sequence')

gulp.task 'images', (done)->
    runSequence('cleanCache', 'tiny', done)

gulp.task 'tiny', ->
    options =
        progressive: true
        use: [pngquant(), jpegtran(), gifsicle()]
    gulp.src(config.Image)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(cache(imagemin(options)))
        .pipe(gulp.dest("#{config.DestPath}/images"))
        .pipe(notify(title: 'images', message: 'preprocess images success!'))
        .pipe(reload({ stream:true }))

gulp.task 'cleanCache', (done)-> cache.clearAll(done)