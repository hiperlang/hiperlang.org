# hiperlang.org

Website for [Hiper.](https://hiperlang.org)

## Running locally

The website is prebuilt and ready for static file serving. To view it:

1. Clone the repository:

```
git clone https://github.com/hiperlang/hiperlang.org.git
```

2. Navigate to the root of the website:

```
cd hiperlang.org/docs
```

3. Start a file-serving HTTP server in the current directory (eg. using Python):

```
python -m http.server 8080
```

4. Open your web browser and go to http://localhost:8080

## Building locally

To build the website from source, you'll need [bun](https://bun.sh/) (preferable) or [npm](https://www.npmjs.com/) installed. Then:

1. Navigate to the root of the repository:

```
cd hiperlang.org
```

2. Install the necessary dependencies:

```
bun install
```

3. Run the build script in development or release mode:

```
bun run dev        # the same as `./build.sh` (HTTP server, live reload, source maps)
bun run release    # the same as `./build.sh --release` (static build, minifying)
```

4. Once the build is complete, you can view it locally at `docs/` (explained in the previous section).

<!-- 5. (Optional) To build the "Hi." icons, you'll need [ImageMagick](https://imagemagick.org/index.php) installed. Then:
```
cd hiperlang.org/assets/icons
./build-icon.sh icon.svg  # icon.svg is build from icon.psd using https://www.photopea.com/
``` -->

## Feedback

If you've found a bug, typo, or you want to suggest an improvement, please let me know by [creating an issue](https://github.com/hiperlang/hiperlang.org/issues) 👋.
