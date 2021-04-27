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
  let result;
  let matches = {};
  while ((result = directiveRegex.exec(script)))
    matches[result.groups.name] = result.groups.value || null;
  return matches;
};

// TODO: Clean this entire method up
watcher.on("all", async (event, path) => {
  const start = Date.now();
  console.log(`${chalk.green("[EVENT]")} ${event}: ${path}`);

  if (/\.lua$/.test(path)) {
    let directives = {};
    const files = (await glob(`${sources}/**/*.lua`)).map((v) =>
      v.split(sources).pop()
    );

    const dependencies = new DepGraph();
    files.forEach((v) => dependencies.addNode(v));
    files.forEach((v) => {
      const source = readFileSync(join(sources, v)).toString();
      const items = getDirectives(source);
      directives[v] = items;

      if (!items.depends) return;
      items.depends
        .split(" ")
        .forEach((dep) => dependencies.addDependency(v, `/${dep}.lua`));
    });

    const script = dependencies
      .overallOrder()
      .map(
        (v) =>
          `--- Source: ${v} ---\n${readFileSync(join(sources, v)).toString()}`
      )
      .join("\n\n");
    
    writeFileSync(output, script);
    console.log(
      `${chalk.blue("[BUILT]")} Took ${Date.now() - start}ms for ${
        script.split("\n").length
      } lines`
    );
  }
});
