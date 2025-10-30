import { execSync } from 'node:child_process';
import { writeFileSync } from 'fs';

const commit = execSync('git rev-parse --short=8 HEAD').toString().trim();
const dirty = execSync('git diff --shortstat').toString().trim();
const full = dirty ? `${commit}.mod` : commit;

const data = {
  commit: full,
  date: new Date().toISOString(),
  network: process.env.HARDHAT_NETWORK ?? "local"
};

writeFileSync('./src/buildInfo.json', JSON.stringify(data, null, 2));
console.log("✅ buildInfo.json written:", data);
