pkg= require('../../package.json')
dirs= pkg['luna-config'].directories
Config=
    # enviroment variable
    EnvSetting:
        NODE_ENV: 'dev'

    # static files
    H5Page: "#{dirs.src}/*.html" # html
    H5Pug: "#{dirs.src}/*.pug"  # from Jade
    Coffee: ["#{dirs.src}/js/**/*.coffee", "#{dirs.src}/libs/**/*.coffee"]
    JS: ["#{dirs.src}/js/**/*.js", "#{dirs.src}/libs/**/*.js"]
    Stylus: "#{dirs.src}/css/**/*.styl"
    Scss: "#{dirs.src}/css/**/*.scss"
    Css: "#{dirs.src}/css/**/*.css"
    Image: "#{dirs.src}/images/**/*.{jpg,png,gif}"
    Font: "#{dirs.src}/font/**/*.ttf"

    # destination dir
    DestPath: dirs.dist

    # remote dir
    DevRemoteDir: '/home/web/devRepo/Alichs'
    TestRemoteDir: '/home/web/testRepo/Alichs'

module.exports= Config