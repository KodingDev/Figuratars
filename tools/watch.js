const chokidar = require("chokidar");
const chalk = require("chalk");
const { question } = require("readline-sync");
const { join } = require("path");
const { readFileSync, writeFileSync } = require("fs");
const { DepGraph } = require("dependency-graph");

const { promisify } = require("util");
const glob = promisify(require("glob"));

const srcDirectory = "src";
const directiveRegex = /^--! @(?<name>[A-Za-z]+)( (?<value>[A-Za-z0-9 \.\/]+))?$/gm;

const directory = join("../", process.argv[2] || question("Enter an avatar: "));
const output = join(directory, "script.lua");
const sources = join(directory, srcDirectory);

const watcher = chokidar.watch(sources, {
  ignored: /(\.png|\.bbmodel|\.txt|\.zip)$/,
});

const getDirectives = (script) => {
  let result,
    matches = {};
  while ((result = directiveRegex.exec(script)))
    matches[result.groups.name] = result.groups.value || null;
  return matches;
};

watcher.on("all", async (event, path) => {
  const start = Date.now();
  console.log(`${chalk.green("[EVENT]")} ${event}: ${path}`);

  if (/\.lua$/.test(path)) {
    const dependencies = new DepGraph();
    const files = (await glob(`${sources}/**/*.lua`))
      .map((v) => v.split(sources).pop())
      .reduce((map, path) => {
        const source = readFileSync(join(sources, path)).toString();
        return {
          ...map,
          [path]: {
            path: path,
            source: source,
            directives: getDirectives(source),
          },
        };
      }, {});

    Object.values(files).forEach((file) => dependencies.addNode(file.path));
    Object.values(files).forEach((file) => {
      if (file.directives.depends)
        file.directives.depends
          .split(" ")
          .forEach((dep) =>
            dependencies.addDependency(file.path, `/${dep}.lua`)
          );
    });

    const script = dependencies
      .overallOrder()
      .map((path) => `--- Source: ${path} ---\n${files[path].source}`)
      .join("\n\n");

    writeFileSync(output, script);
    console.log(
      `${chalk.blue("[BUILT]")} Took ${Date.now() - start}ms for ${
        script.split("\n").length
      } lines`
    );
  }
});
