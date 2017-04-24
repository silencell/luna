gulp= require('gulp')
util= require('gulp-util')
Fontmin= require 'fontmin'
config= require('./config')

gulp.task 'font', ->
    # 改成读取文件的方式，把需要的文字写进font里头的一个文件中
    text =['自定义文字：混沌前端团队'].join ''
    fontmin = new Fontmin()
        .src(config.Font)             # 输入配置
        .use(Fontmin.glyph({        # 字型提取插件
            text: text              # 所需文字
        }))
        .use(Fontmin.ttf2eot())     # eot 转换插件
        .use(Fontmin.ttf2woff())    # woff 转换插件     
        .use(Fontmin.ttf2svg())     # svg 转换插件
        .use(Fontmin.css())         # css 生成插件
        .dest(config.DestPath+'/css/font');
    fontmin.run (err, files, stream)->
        if err?                  # 异常捕捉
            console.error err
        util.log 'done'        # 成功