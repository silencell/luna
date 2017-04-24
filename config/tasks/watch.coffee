gulp= require('gulp')
config= require('./config')

gulp.task 'watch', ->
    gulp.watch [config.H5Page, config.H5Pug, config.Stylus, config.Scss, config.Css, config.Coffee, config.JS, config.Image, config.Font], ['html', 'pug', 'stylus', 'scss', 'css', 'coffee', 'js', 'images', 'font']