gulp= require('gulp')
plumber= require('gulp-plumber')
preprocess= require('gulp-preprocess')
pug= require 'gulp-pug'
notify= require('gulp-notify')
browserSync= require('browser-sync')
reload= browserSync.reload
config= require('./config')

gulp.task 'page', -> gulp.run ['html', 'pug']

gulp.task 'html', ->
    gulp.src(config.H5Page)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(preprocess(context: config.EnvSetting))
        .pipe(gulp.dest(config.DestPath))
        # .pipe(notify(title: 'html', message: 'preprocess html success!'))
        .pipe(reload({ stream:true }))

gulp.task 'pug', ->
    options=
        pretty: true
        locals: config.EnvSetting
    gulp.src(config.H5Pug)
        .pipe(plumber(errorHandler: notify.onError("Error: <%= error.message %>")))
        .pipe(pug(options))
        .pipe(gulp.dest(config.DestPath))
        .pipe(reload({ stream:true }))