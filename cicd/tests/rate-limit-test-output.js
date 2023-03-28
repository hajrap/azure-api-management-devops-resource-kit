const { spawn } = require("child_process");
const { createWriteStream } = require("fs");
const { K6Parser } = require("k6-to-junit");
const parser = new K6Parser();
parser.pipefrom(spawn("k6", ["run", "Rate-Limit-Testing.js"]).stdio).then(() => {
  const writer = createWriteStream("junit.xml");
  parser.toXml(writer);
  writer.once("finished", () => {
    process.exit(k6Parser.allPassed() ? 0 : 99);
  });
});