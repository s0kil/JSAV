import commonjs from "@rollup/plugin-commonjs";

export default {
  input: "src/jsav.js",
  output: {
    name: "JSAV",
    file: "dist/jsav.js",
    format: "iife",
  },
  plugins: [commonjs()],
};
