var gulp        = require("gulp"),
	compass     = require("gulp-compass"),
	minifyCss   = require("gulp-minify-css"),
	imageop     = require("gulp-image-optimization"),
	browserify  = require("browserify"),
	coffeeify   = require("coffeeify"),
	watchify    = require("watchify"),
	uglify      = require("gulp-uglify"),
	source      = require("vinyl-source-stream"),
	streamify   = require("gulp-streamify"),
	browserSync = require('browser-sync').create(),

	pathes      = {
		appName: "Crypto",
		src: {
			scripts: "./app/assets/scripts",
			styles : "./app/assets/styles"
		},
		dest: {
			scripts: "./public/javascripts",
			styles : "./public/stylesheets"
		}
	},
	sourceFile = pathes.src.scripts + "/config/" + pathes.appName + ".coffee",
	destFile   = pathes.appName + ".js";


gulp.task("compass", function() {
	return gulp.src(pathes.src.styles + "/" + pathes.appName + ".sass")
		.pipe(streamify(compass({
			project_path: __dirname + "/",
			css         : pathes.dest.styles,
			sass        : pathes.src.styles
		})))
		.pipe(streamify(minifyCss()))
		.on("error", console.log)
		.pipe(gulp.dest(pathes.dest.styles))
		.pipe(browserSync.stream());
});

gulp.task("browserify", function() {
	return browserify({
		entries: sourceFile,
		debug: false,
		paths: ["./node_modules", "./app/assets/scripts"]
	})
		.ignore("jquery")
		.bundle()
		.pipe(source(destFile))
		.pipe(streamify(uglify()))
		.on("error", console.log)
		.pipe(gulp.dest(pathes.dest.scripts))
		.pipe(browserSync.stream());
});

gulp.task("html", function() {
	return gulp.src("./app/views/**/*.html")
		.pipe(gulp.dest("./public/"));
});

gulp.task("images", function() {
	return gulp.src("./app/images/**/*")
		.pipe(streamify(imageop({
			optimizationLevel: 5,
			progressive: true,
			interlaced: true
		})))
		.on("error", console.log)
		.pipe(gulp.dest("./public/images"));
});

gulp.task("uploads", function() {
	return gulp.src("./app/uploads/**/*")
		.pipe(streamify(imageop({
			optimizationLevel: 5,
			progressive: true,
			interlaced: true
		})))
		.on("error", console.log)
		.pipe(gulp.dest("./public/uploads"));
});

gulp.task("favicons", function() {
	return gulp.src("./app/favicons/**/*")
		.pipe(gulp.dest("./public/favicons"));
});

gulp.task("fonts", function() {
	return gulp.src("./app/fonts/**/*")
		.pipe(gulp.dest("./public/fonts"));
});

gulp.task("serverConfig", function() {
	return gulp.src("./app/serverConfig/.htaccess")
		.pipe(gulp.dest("./public/"));
});

gulp.task("serve", ["compass", "browserify", "html", "images", "uploads"], function() {
	browserSync.init({
		server: "./public"
	});

	gulp.watch(pathes.src.styles + "/**/*.sass", ["compass"]);

	gulp.watch(pathes.src.scripts + "/**/*", ["browserify"]);

	gulp.watch("./app/views/**/*.html", ["html"]).on("change", browserSync.reload);

	gulp.watch("./app/images/**/*", ["images"]).on("change", browserSync.reload);

	gulp.watch("./app/uploads/**/*", ["uploads"]).on("change", browserSync.reload);

	browserSync.watch([pathes.dest.styles + "/**/*.css", pathes.dest.scripts + "/**/*.js"], function (event, file) {
		if (event === "change") {
			browserSync.reload();
		}
	});
});

gulp.task("default", ["serve"]);