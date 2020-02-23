const {src, dest, task, series, parallel, watch, } = require('gulp');
const exec = require('child_process').exec
const browserSync = require('browser-sync').create();
const antora = require('@antora/cli')

function build(cb){
    exec('make docs -e PLAYBOOK=antora-playbook-local.yml', function (err, stdout, stderr) {
        console.log(stdout);
        console.log(stderr);
        if(cb instanceof Function){ cb(err) }
    });
}

function serve() {
    browserSync.init({
        server: {
            baseDir: 'docs',
        },
    })
    watch([
        "overview/**/*",
        "deployment-guides/**/*",
        "learning-labs/**/*",
        "antora-playbook.yml"
    ]).on('change', build)
    watch("build/**/*").on('change', browserSync.reload)
}

exports.build = build
exports.preview = series(build, serve)