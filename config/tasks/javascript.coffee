gulp= require('gulp')
coffee= require('gulp-coffee')
sourcemaps= require('gulp-sourcemaps')
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
preprocess= require('gulp-preprocess')
notify= require('gulp-notify')
browserSync= require('browser-sync')
reload= browserSync.reload
config   = require('./config')

gulp.task 'script', -> gulp.run ['coffee', 'js']

gulp.task 'js', ->
    gulp.src(config.JS)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(preprocess(context: config.EnvSetting))
        .pipe(gulp.dest("#{config.DestPath}/js"))
        .pipe(reload({ stream:true }))

gulp.task 'coffee', ->
    options =
        bare: true
    gulp.src(config.Coffee)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(preprocess(context: config.EnvSetting))
        .pipe(sourcemaps.init())
        .pipe(coffee(options))
        .pipe(sourcemaps.write("./maps"))
        .pipe(gulp.dest("#{config.DestPath}/js"))
        .pipe(reload({ stream:true }))

