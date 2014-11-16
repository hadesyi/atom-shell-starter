path = require 'path'
os = require 'os'

module.exports = (grunt) ->
  {rm} = require('./task-helpers')(grunt)

  grunt.registerTask 'partial-clean', 'Delete some of the build files', ->
    tmpdir = os.tmpdir()

    pkgName = grunt.config.get('pkgName')
    rm grunt.config.get("#{pkgName}.buildDir")

    rm require('../src/coffee-cache').cacheDir
    rm require('../src/less-compile-cache').cacheDir
    rm path.join(tmpdir, 'atom-cached-atom-shells')
    rm 'atom-shell'

  grunt.registerTask 'clean', 'Delete all the build files', ->
    homeDir = process.env[if process.platform is 'win32' then 'USERPROFILE' else 'HOME']

    rm 'node_modules'
    rm path.join(homeDir, ".#{pkgName}", '.node-gyp')
    grunt.task.run('partial-clean')
