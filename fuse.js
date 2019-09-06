const { FuseBox, JSONPlugin } = require("fuse-box");

const fuse = FuseBox.init({
  homeDir: "src",
  output: "dist/$name.js",
  globals: { default: "*" },
  plugins: [JSONPlugin()]
});

fuse.bundle("main").instructions(`> main.ts`);

fuse.run();
