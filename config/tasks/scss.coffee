gulp= require('gulp')
plumber = require 'gulp-plumber'
preprocess= require('gulp-preprocess')
notify= require('gulp-notify')
browserSync= require('browser-sync')
reload= browserSync.reload
sass = require('gulp-sass')
stylus= require 'gulp-stylus'
nib = require('nib')
autoprefixer = require('gulp-autoprefixer')
sourcemaps= require('gulp-sourcemaps')
config   = require('./config')

gulp.task 'style', -> gulp.run ['stylus', 'scss', 'css']

gulp.task 'scss', ->
    options =
        outputStyle: 'compressed'
        indentedSyntax: true
    gulp.src(config.Scss)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(preprocess(context: config.EnvSetting))
        .pipe(sourcemaps.init())
        .pipe(sass(options))
        .pipe(autoprefixer({
            browsers: ['last 2 versions'],
            cascade: false
        }))
        .pipe(sourcemaps.write("./maps"))
        .pipe(gulp.dest("#{config.DestPath}/css"))
        .pipe(reload({ stream:true }))

gulp.task 'stylus', ->
    gulp.src(config.Stylus)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(preprocess(context: config.EnvSetting))
        .pipe(sourcemaps.init())
        .pipe(stylus({ use: nib() }))
        .pipe(autoprefixer({
            browsers: ['last 2 versions'],
            cascade: false
        }))
        .pipe(sourcemaps.write("./maps"))
        .pipe(gulp.dest("#{config.DestPath}/css"))
        .pipe(reload({ stream:true }))

gulp.task 'css', ->
    gulp.src(config.Css)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(preprocess(context: config.EnvSetting))
        .pipe(gulp.dest("#{config.DestPath}/css"))
        .pipe(reload({ stream:true }))


