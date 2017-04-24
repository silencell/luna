
gulp= require('gulp')
util= require('gulp-util')
exec = require('child_process').exec
config= require('./config')
path= require 'path'
runSequence = require('run-sequence')

distPathPosix= ->
  pathObj= path.parse(__dirname)
  dirPath= pathObj.dir.split path.sep
  basePath= path.resolve(dirPath.join('/')+ '/'+pathObj.base+ "/../../#{config.DestPath}")
  distPath= basePath.split(path.sep).join('/')
  return distPath

# devremoteDir= '/home/web/devRepo/Alichs'
gulp.task 'scp:dev', (done)->
  runSequence 'initReomte:dev', 'transfer:dev', done
gulp.task 'initReomte:dev', (cb)->
  cmdLine= "ssh web@web.hundun.cn mkdir -p #{config.DevRemoteDir}"
  util.log cmdLine
  exec cmdLine, (err, stdout, stderr)->
    console.log(stdout)
    console.log(stderr)
    cb(err)
gulp.task 'transfer:dev', (cb)->
  distPath= distPathPosix()
  cmdLine= "scp -r #{distPath}/* web@web.hundun.cn:#{config.DevRemoteDir}"
  util.log cmdLine
  exec cmdLine, (err, stdout, stderr)->
    console.log(stdout)
    console.log(stderr)
    cb(err)

# testremoteDir= '/home/web/testRepo/Alichs'
gulp.task 'scp:test', (done)->
  runSequence 'initReomte:test', 'transfer:test', done
gulp.task 'initReomte:test', (cb)->
  cmdLine= "ssh web@web.hundun.cn mkdir -p #{config.TestRemoteDir}"
  util.log cmdLine
  exec cmdLine, (err, stdout, stderr)->
    console.log(stdout)
    console.log(stderr)
    cb(err)
gulp.task 'transfer:test', (cb)->
  distPath= distPathPosix()
  cmdLine= "scp -r #{distPath}/* web@web.hundun.cn:#{config.TestRemoteDir}"
  util.log cmdLine
  exec cmdLine, (err, stdout, stderr)->
    console.log(stdout)
    console.log(stderr)
    cb(err)
